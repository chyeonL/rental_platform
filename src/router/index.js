import Vue from "vue";
import VueRouter from "vue-router";

Vue.use(VueRouter);
// 路由模块化
import routes from "./routes";
// vuex 用于判断登陆状态
import store from "@/store";
// 弹窗提示
import { Message } from "element-ui";

const router = new VueRouter({
  routes,
  // mode:'history'  默认hash模式
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
    Message({
      message: "登录以继续",
      type: "warning",
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
