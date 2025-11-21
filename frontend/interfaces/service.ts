export interface IService {
    id: string | number;
    date_created: string;
    date_updated: string | null;

    image: string;
    image_url?: string;
    title: string;
    price: number;
    discount: number | null;
    tag: string | null;
}
