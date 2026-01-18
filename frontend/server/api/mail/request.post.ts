import nodemailer from 'nodemailer';
import validator from 'validator';
import { parsePhoneNumberWithError } from 'libphonenumber-js';
import Mail from 'nodemailer/lib/mailer';
import { rateLimit } from '~~/server/utils/rateLimit';

let transporter: nodemailer.Transporter | undefined;

export default defineEventHandler(
    async (event): Promise<{ status: number; success: boolean; message?: string }> => {
        const config = useRuntimeConfig();
        const smtpConfig = useRuntimeConfig().smtp;
        const isDev = config.public.appEnv === 'dev';

        const ip =
            getRequestHeader(event, 'x-forwarded-for') || event.node.req.socket.remoteAddress;

        if (!rateLimit(ip as string, 5, 60_000)) {
            return {
                status: 429,
                success: false,
                message: 'Слишком много запросов. Попробуйте позже',
            };
        }

        if (!transporter) {
            if (isDev) {
                const testAccount = await nodemailer.createTestAccount();
                transporter = nodemailer.createTransport({
                    host: 'smtp.ethereal.email',
                    port: 587,
                    secure: false,
                    auth: {
                        user: testAccount.user,
                        pass: testAccount.pass,
                    },
                });
            } else {
                transporter = nodemailer.createTransport({
                    host: smtpConfig.host,
                    port: Number(smtpConfig.port),
                    secure: true,
                    auth: {
                        user: smtpConfig.user,
                        pass: smtpConfig.pass,
                    },
                });
            }
        }

        try {
            const data = await readMultipartFormData(event);
            if (!data) {
                return { status: 400, success: false, message: 'В запросе отсутсвуют данные' };
            }

            const getField = (name: string) => {
                const field = data.find((f) => f.name === name);
                return field ? Buffer.from(field.data).toString('utf-8') : null;
            };

            const subject = getField('subject');
            const name = getField('name');
            const phone = getField('phone');
            const message = getField('message');
            const email = getField('email');
            const companyName = getField('companyName');

            const fileField = data.find((f) => f.name === 'file') || null;

            if (fileField && fileField.data.length > 10 * 1024 * 1024) {
                return {
                    status: 413,
                    success: false,
                    message: 'Вложенный файл слишком большой',
                };
            }

            if (email && !validator.isEmail(email)) {
                return {
                    status: 400,
                    success: false,
                    message: 'Некорректный адрес электронной почты',
                };
            }

            if (phone) {
                try {
                    const parsedPhone = parsePhoneNumberWithError(phone, 'RU');
                    if (!parsedPhone.isValid()) {
                        return {
                            status: 400,
                            success: false,
                            message: 'Некорректный номер телефона',
                        };
                    }
                } catch {
                    return {
                        status: 500,
                        success: false,
                        message: 'Ошибка валидации номера телефона',
                    };
                }
            }

            const mailOptions: Mail.Options = {
                from: 'Заявка',
                to: smtpConfig.target,
                subject: 'Заявка с сайта',
                html: `
                    <!DOCTYPE html>
                    <html lang="ru">
                    <head>
                        <meta charset="UTF-8">
                        <title>Новая заявка с сайта</title>
                        <style>
                            body { font-family: Arial, sans-serif; background-color: #FFFFFF; color: #1C3A19; }
                            .mail { max-width: 740px; margin: 0 auto; background-color: #EBEBEB; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
                            .mail__header { display: flex; align-items: center; justify-content: space-between; padding: 24px 16px; color: #FFFFFF; background-color: #1C3A19; border-radius: 8px; }
                            .mail__title { font-size: 30px; font-weight: bold; margin: 0; }
                            .mail__logo { width: 64px; height: 64px; display: block; }
                            .mail__logo > img { width: 100%; height: 100%; object-fit: contain; }
                            .mail__content { padding: 32px 0; display: flex; flex-direction: column; gap: 32px; padding: 0 16px; margin-top: 48px; }
                            .mail__subtitle { font-size: 24px; font-weight: bold; margin: 0; }
                            .mail__data { display: flex; flex-direction: column; margin: 0; padding: 0; }
                            .mail__data-item { list-style: none; font-size: 20px; padding: 12px 0; display: flex; align-items: center; justify-content: space-between; gap: 32px; border-bottom: 1px solid lightgray }
                            .mail__data-item--large { flex-direction: column; align-items: flex-start; border-bottom: none; }
                            .mail__data-item--large > p { font-size: 16px; line-height: 1.4; margin: 0; }
                            .mail__data-item > span { font-size: 18px; text-align: right; }
                        </style>
                    </head>
                    <body>
                        <div class="mail">
                            <div class="mail__header">
                                <h2 class="mail__title">Заявка с сайта</h2>
                                <a class="mail__logo" href="${config.public.siteUrl}" target="_blank">
                                    <img src="${config.public.siteUrl}/favicon.svg" alt="ПКЗ">
                                </a>
                            </div>
                            <div class="mail__content">
                                <h3 class="mail__subtitle">Отправленные данные:</h3>
                                <ul class="mail__data">
                                    <li class="mail__data-item"><strong>Тема заявки:</strong><span>${subject || '-'}</span></li>
                                    <li class="mail__data-item"><strong>Имя клиента:</strong><span>${name || '-'}</span></li>
                                    <li class="mail__data-item"><strong>E-mail:</strong><span>${email || '-'}</span></li>
                                    <li class="mail__data-item"><strong>Номер телефона:</strong><span>${phone || '-'}</span></li>
                                    <li class="mail__data-item"><strong>Название комании:</strong><span>${companyName || '-'}</span></li>
                                    <li class="mail__data-item"><strong>Вложенные файлы:</strong><span>${fileField ? 'Прикреплены во вложении' : '-'}</span></li>
                                    <li class="mail__data-item mail__data-item--large">
                                        <strong>Дополнительная информация:</strong>
                                        <p>${message || '-'}</p>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </body>
                    </html>
                    `,
                attachments: fileField
                    ? [
                          {
                              filename: fileField.filename || 'attached-file',
                              content: fileField.data,
                              contentType: fileField.type || 'application/octet-stream',
                          },
                      ]
                    : undefined,
            };

            const res = await transporter.sendMail(mailOptions);

            if (isDev) {
                console.log('Preview URL:', nodemailer.getTestMessageUrl(res));
            }
        } catch {
            return {
                status: 500,
                success: false,
                message: 'Ошибка сервера, попробуйте повторить попытку позже',
            };
        }
        return {
            status: 200,
            success: true,
        };
    }
);
