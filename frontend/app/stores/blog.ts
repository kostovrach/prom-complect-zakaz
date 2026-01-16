import type { IArticle } from '~~/interfaces/article';

export const useBlogStore = defineStore('blog', () => {
    // State
    const articles = ref<IArticle[]>([]);

    // Actions
    function setArticles(data: IArticle[]) {
        articles.value = data;
    }

    function getArticleById(id: IArticle['id']): IArticle | null {
        return articles.value.find((el) => el.id === id) ?? null;
    }

    return { articles, setArticles, getArticleById };
});
