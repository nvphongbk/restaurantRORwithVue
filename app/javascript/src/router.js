import Vue from 'vue'
import VueRouter from 'vue-router'
import SignIn from './components/Signin'
import HomePage from "./components/HomePage"
import Dashboard from "./components/Dashboard"

Vue.use(VueRouter)
const router = new VueRouter({
  mode: 'history',
  routes: [
    {
      path: '/signin',
      name: 'SignIn',
      component: SignIn,
      meta: {
        openKey: 'System'
      }
    },
    {
      path: '/home_page',
      name: 'HomePage',
      component: HomePage,
      meta: {
        openKey: 'System'
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
  ]
})
export default router
