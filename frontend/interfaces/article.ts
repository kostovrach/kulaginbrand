export interface IArticle {
    id: string | number;
    date_created: string;
    date_updated: string | null;
    cover: string;
    cover_url?: string;
    title: string;
    summary: string | null;
    content: string;
}