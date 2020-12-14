export const getBaseUrl = () => {
  return "http://localhost:3000/api/v1"
};
export const URLS = {
  RESTAURANTS: () => `${getBaseUrl()}/restaurants`,
  RESTAURANT: (id) => `${getBaseUrl()}/restaurants/${id}`,
  RESTAURANTSEARCH: (id) => `${getBaseUrl()}/restaurants/${id}/categories`,


  CATEGORIES: () => `${getBaseUrl()}/categories`,
  CATEGORY: (id) => `${getBaseUrl()}/categories/${id}`,
  CATEGORYSEARCH: (id) => `${getBaseUrl()}/categories/${id}/dishes`,

  DISHES: () => `${getBaseUrl()}/dishes`,
  DISH: (id) => `${getBaseUrl()}/dishes/${id}`
};
