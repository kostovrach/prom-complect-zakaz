export interface IArticle {
    id: string | number;
    date_created: string;
    date_updated: string | null;
    
    tags: string[];
    cover: string;
    cover_url?: string;
    title: string;
    content: string;
    hint_enabled: boolean;
}