import axios from 'axios'
import {JWT_KEY} from "./constant";

//customHeader is user for upload image
export const ApiCaller = (customHeader = null) => {
  const header = {'Authorization': `Bearer ${localStorage.getItem(JWT_KEY)}`}
  const instance = axios.create({
    headers: Object.assign(customHeader || {}, header),
    timeout: 10000
  })
  // instance.interceptors.response.use((response) => {
  //   return response
  // }, (error) => {
  //   let errorMessage = error.toString()
  //   if (error.response) {
  //     if (error.response.data.message) {
  //       errorMessage = error.response.data.message
  //     }
  //     if (error.response.status === 401) {
  //       localStorage.clear()
  //       setTimeout(() => {
  //         window.location.href = '/signin'
  //       }, 2000)
  //     }
  //   }
  //   store.commit('message/SET_MESSAGE', errorMessage)
  //   return Promise.reject(error)
  // })
  return instance
}
