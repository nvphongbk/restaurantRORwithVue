import Vue from 'vue'
import App from '../app.vue'
import '../src/assets/tailwind.min.css'
import router from '../src/router.js'
import Antd from "ant-design-vue";
import "ant-design-vue/dist/antd.css";
Vue.use(Antd);
Vue.config.productionTip = false;

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    router,
    render: h => h(App)
  }).$mount()
  document.body.appendChild(app.$el)
})
