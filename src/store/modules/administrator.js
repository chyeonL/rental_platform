import { login, changePassword, changeInfo, Avatar } from "@/api";
import { Message } from "element-ui";
export default {
  state: {
    userInfo: JSON.parse(localStorage.getItem("isLogin")) || {},
    isLogin: JSON.parse(localStorage.getItem("isLogin")),
    role: localStorage.getItem("role") || '',
    adminID: JSON.parse(localStorage.getItem("adminID")) || '',
    // token: "",
  },
  mutations: {
    // 本地存储用户信息
    setUserInfo(state, payload) {
      state.userInfo = payload.data;
      localStorage.setItem("userInfo", JSON.stringify(payload.data));

      // state.token = payload.data.Token;
      // localStorage.setItem("token", JSON.stringify(payload.data.token));

      state.role = payload.data.Role;
      localStorage.setItem("role", JSON.stringify(payload.data.Role));

      state.adminID = payload.data.Admin_ID;
      localStorage.setItem("adminID", JSON.stringify(payload.data.Admin_ID));

      state.isLogin = true;
      localStorage.setItem("isLogin", true);
    },
    // 退出登录
    clearUserInfo(state) {
      state.isLogin = false;
      state.userInfo = {};
      state.role = {};
      state.adminID = {};
      // state.token = {};
      localStorage.removeItem("userInfo");
      localStorage.removeItem("role");
      localStorage.removeItem("adminID");
      // localStorage.removeItem("token");
      localStorage.setItem("isLogin", false);
    },

    // 初始化
    initUserInfo(state) {
      if (state.isLogin) {
        state.userInfo = JSON.parse(localStorage.getItem("userInfo"));
        state.role = JSON.parse(localStorage.getItem("role"));
        state.adminID = JSON.parse(localStorage.getItem("adminID"));
        // state.token = JSON.parse(localStorage.getItem("token"));
      } else {
        localStorage.setItem("isLogin", false);
      }
      return state.isLogin;
    },
  },
  actions: {
    // 登录
    async Login({ state, commit }, data) {
      let res = await login(data);
      if (res.success) commit("setUserInfo", res);
      return res;
    },
    // 退出登录
    async Logout({ commit }) {
      commit("clearUserInfo");
      Message({
        type: "success",
        message: "已退出登录",
      });
    },
    // 修改密码
    async modifyPwd({ commit }, { No, newPwd, oldpwd }) {
      let res = await changePassword(No, newPwd, oldpwd)
      console.log(res);
      return res
    },
    // 修改账号信息   
    async modifyInfo({ commit }, { Name, UserName, Tel, Gender, No, Note }) {
      let res = await changeInfo(Name, UserName, Tel, Gender, No, Note)
      console.log(res);
      return res
    },
    // 上传头像
    async uploadAvatar({ rootState }, { url, No }) {
      // console.log(url, No);
      let res = await Avatar(url, No)
      console.log(res);
      return res
    }
  },
  getters: {},
};
