export const getBaseUrl = () => {
  return "http://localhost:3000/api/v1"
};
export const URLS = {
  RESTAURANTS: () => `${getBaseUrl()}/restaurants`,
  RESTAURANT: (id) => `${getBaseUrl()}/restaurants/${id}`,
  RESTAURANT_SEARCH: (id) => `${getBaseUrl()}/restaurants/${id}/categories`,


  CATEGORIES: () => `${getBaseUrl()}/categories`,
  CATEGORY: (id) => `${getBaseUrl()}/categories/${id}`,
  CATEGORY_SEARCH: (id) => `${getBaseUrl()}/categories/${id}/dishes`,

  IMPORT_DATA: () => `${getBaseUrl()}/import_data`,

  DISHES: () => `${getBaseUrl()}/dishes`,
  DISH: (id) => `${getBaseUrl()}/dishes/${id}`,

  IMAGES: () => `${getBaseUrl()}/images`,

  FILE_XAMPLE_IMPORT_DATA: () => `form-data.xlsx`,

  SIGNIN: () => `${getBaseUrl()}/signin`,
  SIGNOUT: () => `${getBaseUrl()}/signout`,

  MENU: (id) => `${getBaseUrl()}/restaurants/${id}/menus`,

  MESSAGES: () => `${getBaseUrl()}/messages`,
  MESSAGE: (id) => `${getBaseUrl()}/messages/${id}`,
  MESSAGE_CONTACT: () => `${getBaseUrl()}/messages`,
};
