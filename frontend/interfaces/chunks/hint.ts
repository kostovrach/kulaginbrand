export interface IVideoHint {
    id: string | number;
    date_created: string;
    date_updated: string | null;
    title: string;
    description: string | null;
    video: string;
    video_url?: string;
    button_text: string;
}
