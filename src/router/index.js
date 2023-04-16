import Vue from "vue";
import VueRouter from "vue-router";
Vue.use(VueRouter);
// 路由模块化
import routes from "./routes";
// vuex 用于判断登陆状态
import store from "@/store";
import { Notification } from "element-ui";

const router = new VueRouter({
  routes,
});

// 登录拦截
router.beforeEach((to, from, next) => {
  // 只要有一个匹配到的路由有requireAuth，就返回true
  let requireAuth = to.matched.some((item) => item.meta.requireAuth);
  let isLogin = store.state.Administrator.isLogin;
  // console.log(isLogin);
  // console.log(requireAuth);
  // 未登录
  if (!isLogin && requireAuth) {
    Notification({
      title: "登陆提醒",
      offset: 60,
      duration: 2000,
      type: "warning",
      message: '登录以继续',
    });
    next({
      path: "/login",
      query: {
        redirect: to.fullPath,
      },
    });
  } else next();
});

export default router;
