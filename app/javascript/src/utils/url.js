import { HOME_URL } from "./constant";

export const getBaseUrl = () => {
  return "/api/v1"
};
export const URLS = {
  RESTAURANTS: () => `${getBaseUrl()}/restaurants`,
  RESTAURANT: (id) => `${getBaseUrl()}/restaurants/${id}`,
  RESTAURANT_SEARCH: (id) => `${getBaseUrl()}/restaurants/${id}/categories`,


  CATEGORIES: () => `${getBaseUrl()}/categories`,
  CATEGORY: (id) => `${getBaseUrl()}/categories/${id}`,
  CATEGORY_DISHES: (id) => `${getBaseUrl()}/categories/${id}/dishes`,
  CATEGORY_CHANGE_ACTIVE: (id) => `${getBaseUrl()}/categories/${id}/change_active`,
  CATEGORY_SEARCH: (id) => `${getBaseUrl()}/categories/${id}/dishes`,

  IMPORT_DATA: () => `${getBaseUrl()}/import_data`,

  DISHES: () => `${getBaseUrl()}/dishes`,
  DISH: (id) => `${getBaseUrl()}/dishes/${id}`,
  DISH_CHANGE_ACTIVE: (id) => `${getBaseUrl()}/dishes/${id}/change_active`,
  DISHES_FILTER: (id) =>`${getBaseUrl()}/restaurants/${id}/dishes_filter`,

  IMAGES: () => `${getBaseUrl()}/images`,

  MAIN_INGREDIENTS: () => `${getBaseUrl()}/main_ingredients`,
  MAIN_INGREDIENT: (id) => `${getBaseUrl()}/main_ingredients/${id}`,
  MAIN_INGREDIENT_CHANGE_ACTIVE: (id) => `${getBaseUrl()}/main_ingredients/${id}/change_active`,

  COOKING_METHODS: () => `${getBaseUrl()}/cooking_methods`,
  COOKING_METHOD: (id) => `${getBaseUrl()}/cooking_methods/${id}`,
  COOKING_METHOD_CHANGE_ACTIVE: (id) => `${getBaseUrl()}/cooking_methods/${id}/change_active`,
  COOKING_METHOD_DISHES: (id) =>`${getBaseUrl()}/cooking_methods/${id}/dishes`,

  FILE_XAMPLE_IMPORT_DATA: () => `form-data.xlsx`,

  SIGNIN: () => `${getBaseUrl()}/signin`,
  SIGNOUT: () => `${getBaseUrl()}/signout`,

  SIGNUP: () => `${getBaseUrl()}/signup`,

  MENU: (id) => `${getBaseUrl()}/restaurants/${id}/menus`,

  RESTAURANT_URL: (id) => `${HOME_URL}/restaurants/${id}`,

  MESSAGES: () => `${getBaseUrl()}/messages`,
  MESSAGE: (id) => `${getBaseUrl()}/messages/${id}`,
  MESSAGE_CONTACT: () => `${getBaseUrl()}/messages`,

};
