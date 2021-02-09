import {HOME_URL} from "./constant";

export const getBaseUrl = () => {
  return "/api/v1"
};
export const URLS = {
  GUEST_RESTAURANTS: () => `${getBaseUrl()}/restaurants/guest_index`,
  RESTAURANTS: () => `${getBaseUrl()}/restaurants`,
  RESTAURANT: (id) => `${getBaseUrl()}/restaurants/${id}`,
  RESTAURANT_SEARCH: (id) => `${getBaseUrl()}/restaurants/${id}/categories`,
  RESTAURANT_COOKINGMETHOD: (id) => `${getBaseUrl()}/restaurants/${id}/cooking_methods`,
  RESTAURANT_MAININGREDIENT: (id) => `${getBaseUrl()}/restaurants/${id}/main_ingredients`,
  CATEGORIES: () => `${getBaseUrl()}/categories`,
  CATEGORY: (id) => `${getBaseUrl()}/categories/${id}`,
  CATEGORY_DISHES: (id) => `${getBaseUrl()}/categories/${id}/dishes`,
  CATEGORY_CHANGE_ACTIVE: (id) => `${getBaseUrl()}/categories/${id}/change_active`,
  CATEGORY_SEARCH: (id) => `${getBaseUrl()}/categories/${id}/dishes`,
  IMPORT_DATA: () => `${getBaseUrl()}/import_data`,
  DISHES: () => `${getBaseUrl()}/dishes`,
  DISH: (id) => `${getBaseUrl()}/dishes/${id}`,
  DISH_CHANGE_ACTIVE: (id) => `${getBaseUrl()}/dishes/${id}/change_active`,
  DESTROY_SELECT_DISH: (id) => `${getBaseUrl()}/dishes/${id}/destroy_select`,
  GUEST_DISHES: (id) => `${getBaseUrl()}/restaurants/${id}/guest_dishes`,
  GUEST_RESTAURANT_INFO: (id) => `${getBaseUrl()}/restaurants/${id}/guest_restaurant_info`,
  CURRENT_USER_INFO: () => `${getBaseUrl()}/users/get_info`,
  IMAGES: () => `${getBaseUrl()}/images`,
  IMAGE: (id) => `${getBaseUrl()}/images/${id}`,
  MAIN_INGREDIENTS: () => `${getBaseUrl()}/main_ingredients`,
  MAIN_INGREDIENT: (id) => `${getBaseUrl()}/main_ingredients/${id}`,
  MAIN_INGREDIENT_CHANGE_ACTIVE: (id) => `${getBaseUrl()}/main_ingredients/${id}/change_active`,
  COOKING_METHODS: () => `${getBaseUrl()}/cooking_methods`,
  COOKING_METHOD: (id) => `${getBaseUrl()}/cooking_methods/${id}`,
  COOKING_METHOD_CHANGE_ACTIVE: (id) => `${getBaseUrl()}/cooking_methods/${id}/change_active`,
  COOKING_METHOD_DISHES: (id) => `${getBaseUrl()}/cooking_methods/${id}/dishes`,
  FILE_XAMPLE_IMPORT_DATA: () => `form-data.xlsx`,
  SIGNIN: () => `${getBaseUrl()}/signin`,
  SIGNOUT: () => `${getBaseUrl()}/signout`,
  SIGNUP: () => `${getBaseUrl()}/signup`,
  RESTAURANT_URL: (slug) => `${HOME_URL}/restaurants/${slug}`,
  MESSAGES: () => `${getBaseUrl()}/messages`,
  MESSAGE: (id) => `${getBaseUrl()}/messages/${id}`,
  MESSAGE_CONTACT: () => `${getBaseUrl()}/messages`,

//  Methods
  CHANGE_RESTAURANT_DEFAULT: () => `${getBaseUrl()}/users/change_restaurant_default`,
  CHANGE_CATEGORY_DISPLAY_HOME: (id) => `${getBaseUrl()}/categories/${id}/change_display_home`,
};
