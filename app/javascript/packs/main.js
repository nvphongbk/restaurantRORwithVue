import Vue from 'vue'
import App from '../app.vue'
import '../src/assets/tailwind.min.css'
import router from '../src/router.js'
import Antd from "ant-design-vue";
import "ant-design-vue/dist/antd.css";
import '../css/application.css';
import '../css/custom.css';
import { FormModel } from 'ant-design-vue';

Vue.use(Antd);
Vue.use(FormModel);
Vue.config.productionTip = false;

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    router,
    render: h => h(App)
  }).$mount()
  document.body.appendChild(app.$el)
})
