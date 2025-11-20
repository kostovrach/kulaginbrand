export interface IContact {
    id: string | number;
    date_updated: string | null;
    phone: string;
    email: string;
    address: string | null;
    studio_link: string;

    vk: string | null;
    tg: string | null;
    whatsapp: string | null;
    ok: string | null;
    tiktok: string | null;
}