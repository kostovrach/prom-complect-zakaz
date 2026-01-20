import type { IArticle } from '~~/interfaces/article';

export const useBlogStore = defineStore('blog', () => {
    // State
    const articles = ref<IArticle[]>([]);
    const tags = computed(() => {
        const set = new Set(...articles.value.map((el) => el.tags.flatMap((el) => el)));
        return set;
    });

    // Actions
    function setArticles(data: IArticle[]) {
        articles.value = data;
    }

    function getArticleById(id: IArticle['id']): IArticle | null {
        return articles.value.find((el) => el.id === id) ?? null;
    }

    return { articles, tags, setArticles, getArticleById };
});
