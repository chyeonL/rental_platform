import Vue from 'vue'
import App from './App.vue'
import router from '@/router'
import store from '@/store'
import ElementUI from 'element-ui';   // 全部引入
import 'element-ui/lib/theme-chalk/index.css'; // 样式
Vue.use(ElementUI);
import '@/assets/css/reset.css'
import * as api from '@/api'
// 腾讯地图
import { VueJsonp } from 'vue-jsonp'
Vue.use(VueJsonp)
// echarts图表
import * as echarts from 'echarts';

Vue.config.productionTip = false

new Vue({
  render: h => h(App),
  router,
  store,
  beforeCreate(){
    Vue.prototype.$api = api
    Vue.prototype.$echarts = echarts;
  }
}).$mount('#app')
