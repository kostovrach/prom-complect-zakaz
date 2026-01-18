import type { LngLat } from '@yandex/ymaps3-types';

export interface IContacts {
    id: string | number;
    date_created: string;
    date_updated: string | null;

    copyright: string;
    legal_info: string | null;

    phone: string | null;
    email: string | null;
    vk: string | null;
    tg: string | null;
    ok: string | null;

    address: string | null;
    address_description: string | null;
    map_points: {
        id: string | number;
        contacts_id: any;
        contact_map_id: {
            id: string | number;
            title: string | null;
            subtitle: string | null;
            point: {
                coordinates: LngLat;
                type: string;
            };
        };
    }[];
}
