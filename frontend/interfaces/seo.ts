export interface ISeo {
    id: string | number;

    meta_title: string;
    meta_description: string | null;
    og_image: string | null;
    og_image_url?: string | null;
}