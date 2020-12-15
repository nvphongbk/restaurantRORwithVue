import Vue from 'vue'
import VueRouter from 'vue-router'
import SignIn from './components/Signin'
import HomePage from "./components/HomePage"
import Dashboard from "./components/Dashboard"
import Restaurants from "./components/Restaurants"
import Categories from "./components/Categories"
import Dishes from "./components/Dishes"
import ImportMedia from "./components/common/ImportMedia"
Vue.use(VueRouter)
const router = new VueRouter({
  mode: 'history',
  routes: [
    {
      path: '/restaurants',
      name: 'Restaurants',
      component: Restaurants,
      meta: {
        openKey: 'Restaurant'
      }
    },
    {
      path: '/categories',
      name: 'Categories',
      component: Categories,
      meta: {
        openKey: 'Category'
      }
    },
    {
      path: '/dishes',
      name: 'Dishes',
      component: Dishes,
      meta: {
        openKey: 'Dish'
      }
    },
    {
      path: '/signin',
      name: 'SignIn',
      component: SignIn,
      meta: {
        openKey: 'SignIn'
      }
    },
    {
      path: '/',
      name: 'HomePage',
      component: HomePage,
      meta: {
        openKey: 'HomePage'
      }
    },
    {
      path: '/dashboard',
      name: 'Dashboard',
      component: Dashboard,
      meta: {
        openKey: 'System'
      }
    },
    {
      path: '/import-media',
      name: 'ImportMedia',
      component: ImportMedia,
      meta: {
        openKey: 'import-media'
      }
    }
  ]
})
export default router
