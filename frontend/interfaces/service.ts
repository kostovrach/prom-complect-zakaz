import type { IArticle } from './article';

export interface IService {
    id: string | number;
    date_created: string;
    date_updated: string | null;

    hero_title: string;
    hero_subtitle: string;
    hero_advant: {
        content: string;
    }[];
    hero_image: string;
    hero_image_url?: string;

    about_title: string;
    about_content: string;

    banner_value: string | null;
    banner_unit: string | null;
    banner_description: string | null;
    banner_content: string | null;
    banner_article: {
        id: string | number;
        banner_article_id: any;
        articles_id: IArticle;
    } | null;

    gallery_title: string | null;
    gallery_slides: {
        id: string | number;
        gallery_slides_id: any;
        services_gallery_id: {
            id: string | number;
            date_created: string;
            date_updated: string | null;
            title: string;
            description: string;
            image: string;
            image_url?: string;
        };
    }[];

    faq_tag: string | null;
    faq_title: string | null;
    faq_items: {
        title: string;
        content: string;
    }[];

    articles_title: string | null;
    articles_items: {
        id: string | null;
        articles_items_id: any;
        articles_id: IArticle;
    }[];

    docs_title: string | null;
    docs_items: {
        id: string | null;
        docs_items_id: any;
        services_docs_id: {
            id: string | number;
            date_created: string;
            date_updated: string | null;
            title: string;
            file: string;
            file_url?: string;
        };
    }[];
}
