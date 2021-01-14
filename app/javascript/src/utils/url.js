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
  CATEGORY_CHANGE_ACTIVE: (id) => `${getBaseUrl()}/categories/${id}/change_active`,
  CATEGORY_SEARCH: (id) => `${getBaseUrl()}/categories/${id}/dishes`,

  IMPORT_DATA: () => `${getBaseUrl()}/import_data`,

  DISHES: () => `${getBaseUrl()}/dishes`,
  DISH: (id) => `${getBaseUrl()}/dishes/${id}`,
  DISH_CHANGE_ACTIVE: (id) => `${getBaseUrl()}/dishes/${id}/change_active`,

  IMAGES: () => `${getBaseUrl()}/images`,

  FILE_XAMPLE_IMPORT_DATA: () => `form-data.xlsx`,

  SIGNIN: () => `${getBaseUrl()}/signin`,
  SIGNOUT: () => `${getBaseUrl()}/signout`,

  MENU: (id) => `${getBaseUrl()}/restaurants/${id}/menus`,

  RESTAURANT_URL: (id) => `${HOME_URL}/restaurants/${id}`,

  MESSAGES: () => `${getBaseUrl()}/messages`,
  MESSAGE: (id) => `${getBaseUrl()}/messages/${id}`,
  MESSAGE_CONTACT: () => `${getBaseUrl()}/messages`,
};
