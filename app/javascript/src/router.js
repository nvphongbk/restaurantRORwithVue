import Vue from 'vue'
import VueRouter from 'vue-router'
import SignIn from './components/Signin'
import HomePage from "./components/HomePage"
import Dashboard from "./components/Dashboard"
import Restaurants from "./components/Restaurants"
import Categories from "./components/Categories"
import Dishes from "./components/Dishes"
import ImportMedia from "./components/common/ImportMedia"
import {JWT_KEY} from "./utils/constant"
import Menu from "./components/Menu"
import About from "./components/About"
import Contact from "./components/Contact"

Vue.use(VueRouter)
const router = new VueRouter({
  mode: 'history',
  routes: [
    {
      path: '/admin/restaurants',
      name: 'Restaurants',
      component: Restaurants,
      meta: {
        openKey: 'Restaurant',
        guest: true
      }
    },
    {
      path: '/admin/categories',
      name: 'Categories',
      component: Categories,
      meta: {
        openKey: 'Category'
      }
    },
    {
      path: '/admin/dishes',
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
        openKey: 'SignIn',
        guest: true
      }
    },
    {
      path: '/',
      name: 'HomePage',
      component: HomePage,
      meta: {
        openKey: 'HomePage',
        guest: true
      }
    },
    {
      path: '/admin/dashboard',
      name: 'Dashboard',
      component: Dashboard,
      meta: {
        openKey: 'System'
      }
    },
    {
      path: '/admin/import-media',
      name: 'ImportMedia',
      component: ImportMedia,
      meta: {
        openKey: 'Import-media'
      }
    },
    {
      path: '/restaurants/:id',
      name: 'Menu',
      component: Menu,
      meta: {
        openKey: 'Menu',
        guest: true
      }
    },
    {
      path: '/about',
      name: 'About',
      component: About,
      meta: {
        openKey: 'About',
        guest: true
      }
    },
    { path: '/contact',
      name: 'Contact',
      component: Contact,
      meta: {
        openKey: 'Contact',
        guest: true
      }
    }
  ]
})

router.beforeEach((to, from, next) => {
  if (localStorage.getItem(JWT_KEY) == null) {
    if (to.name !== 'SignIn' && !to.matched.some(record => record.meta.guest)) {
      router.push('/signin')
    }
    else if(to.name !== 'SignIn' && to.matched.some(record => record.meta.guest)) {
      next()
    }
  } else {
    if (to.name == 'SignIn' && to.matched.some(record => record.meta.guest)) { //guest = true
      router.push('/dashboard')
    }
  }
  next()
})

export default router
