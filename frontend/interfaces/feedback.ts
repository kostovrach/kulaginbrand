export interface IFeedback {
    id: string | number;
    date_created: string;
    date_updated: string | null;
    name: string | null;
    tag: string | null;
    text: string;
}