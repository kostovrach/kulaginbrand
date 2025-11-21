export interface IProject {
    id: string | number;
    date_created: string;
    date_updated: string | null;
    location: string;
    name: string;
    services: string[] | null;
    description: string | null;
    link: string | null;
}
