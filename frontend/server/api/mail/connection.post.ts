import nodemailer from 'nodemailer';
import Mail from 'nodemailer/lib/mailer';
import { rateLimit } from '~~/server/utils/rateLimit';

export default defineEventHandler(
    async (event): Promise<{ status: number; success: boolean; message?: string }> => {
        const config = useRuntimeConfig().smtp;
        const ip =
            getRequestHeader(event, 'x-forwarded-for') || event.node.req.socket.remoteAddress;

        if (!rateLimit(ip as string, 5, 60_000)) {
            return {
                status: 429,
                success: false,
                message: 'Слишком много запросов. Попробуйте позже',
            };
        }
        try {
            const data = await readBody<{ email: string }>(event);

            if (!data.email) {
                return {
                    status: 400,
                    success: false,
                    message: 'Некорректный адрес электронной почты',
                };
            }

            const transporter = nodemailer.createTransport({
                host: config.host,
                port: Number(config.port || 587),
                secure: true,
                auth: {
                    user: config.user,
                    pass: config.pass,
                },
            });

            const mailOptions: Mail.Options = {
                from: 'Заявка',
                to: config.target,
                subject: 'Заявка с сайта',
                html: `<p><strong>E-mail:</strong> ${data.email}</p>`,
            };

            await transporter.sendMail(mailOptions);
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
