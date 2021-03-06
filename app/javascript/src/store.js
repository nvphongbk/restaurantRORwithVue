import Vue from 'vue'
import Vuex from 'vuex'
import {ApiCaller} from "./utils/api";
import {URLS} from "./utils/url";

Vue.use(Vuex)

const store = new Vuex.Store({
  state: {
    current_restaurant: {
      id: '',
      name: ''
    },
    restaurants: [],
    categories: [],
  },
  mutations: {
    SET_CURRENT_RESTAURANT( state, payload ) {
      state.current_restaurant = payload
    },
    SET_RESTAURANTS( state, payload ) {
      state.restaurants = payload
    },
    SET_CATEGORIES( state, payload ) {
      state.categories = payload
    }
  },
  getters: {
    currentRestaurant: state => {
      return state.current_restaurant
    },
    restaurants: state => {
      return state.restaurants
    },
    categories: state => {
      return state.categories
    }
  },
  actions: {
   async getRestaurantInfo({ commit }) {
     const response = await ApiCaller().get(URLS.CURRENT_USER_INFO())
     if(response) {
       commit('SET_CURRENT_RESTAURANT', response.data.current_restaurant)
       commit('SET_RESTAURANTS', response.data.restaurants)
       commit('SET_CATEGORIES', response.data.categories)
     }
   },
   async changeRestaurant({ commit, dispatch }, restaurant_id) {
     const response = await ApiCaller().post(URLS.CHANGE_RESTAURANT_DEFAULT(), {
       id: restaurant_id
     })
     if(response) {
       dispatch('getRestaurantInfo')
       window.location.reload()
     }
   }
  }
  })
export default store
