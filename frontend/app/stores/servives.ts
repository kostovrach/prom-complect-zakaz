import type { IService } from '~~/interfaces/service';

export const useServicesStore = defineStore('services', () => {
    // State
    const services = ref<IService[]>([]);

    // Actions
    function setServices(data: IService[]) {
        services.value = data;
    }

    function getServiceById(id: IService['id']): IService | null {
        return services.value.find((el) => el.id === id) ?? null;
    }

    return { services, setServices, getServiceById };
});
