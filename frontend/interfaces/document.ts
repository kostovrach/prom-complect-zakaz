export interface IDocument {
    id: string | number;
    date_created: string;
    date_updated: string | null;
    title: string;
    content: string;
}