import { login, changePassword, changeInfo, Avatar, getFeedbackNumber, getIncompleteTenant, getIncompleteRent, toBeReport, variousOpinions, rentedOut, roomtypeBarChart } from "@/api";
export default {
  state: {
    userInfo: JSON.parse(localStorage.getItem("isLogin")) || {},
    isLogin: JSON.parse(localStorage.getItem("isLogin")),
    role: localStorage.getItem("role") || '',
    adminID: JSON.parse(localStorage.getItem("adminID")) || '',
    rent: 0,
    tenant: 0,
    opinion: 0,
    toBeReport: 0,
    rentedOut: 0,
    all: 0
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

    // 顶部的消息通知
    Rent(state, payload) {
      state.rent = payload
    },

    Tenant(state, payload) {
      state.tenant = payload
    },

    Opinion(state, payload) {
      state.opinion = payload
    },

    ToBeReport(state, payload) {
      state.toBeReport = payload
    },

    RentedOut(state, payload) {
      state.rentedOut = payload.data
      state.all = payload.all
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
    },
    // 修改密码
    async modifyPwd({ commit }, { No, newPwd, oldpwd }) {
      let res = await changePassword(No, newPwd, oldpwd)
      return res
    },
    // 修改账号信息   
    async modifyInfo({ commit }, { Name, UserName, Tel, Gender, No, Note }) {
      let res = await changeInfo(Name, UserName, Tel, Gender, No, Note)
      return res
    },
    // 上传头像
    async uploadAvatar({ rootState }, { url, No }) {
      let res = await Avatar(url, No)
      return res
    },
    // 待完善租金记录
    async RentNumber({ commit }, tableName) {
      let res = await getIncompleteRent(tableName)
      if (res.success) commit('Rent', res.data)
    },
    // 
    async TenantNumber({ commit }, tableName) {
      let res = await getIncompleteTenant(tableName)
      if (res.success) commit('Tenant', res.data)
    },
    // 
    async FeedbackNumber({ commit }, tableName) {
      let res = await getFeedbackNumber(tableName)
      if (res.success) commit('Opinion', res.data)
    },
    // 可上报 
    async ToBeReport({ commit }, tableName) {
      let res = await toBeReport(tableName)
      if (res.success) commit('ToBeReport', res.data)
    },
    // 意见反馈的饼图
    async VariousOpinions({ rootState, commit }) {
      let tableName = rootState.Administrator.userInfo.InChargeStaffID + '_opinion'
      let res = await variousOpinions(tableName, rootState.Administrator.adminID)
      return res
    },
    // rentedOut
    async RentedOutRooms({ rootState, commit }) {
      let tableName = 'room_' + rootState.Administrator.adminID
      let res = await rentedOut(tableName)
      // console.log(res);
      if (res.success) commit('RentedOut', res)
    },
    // 
    async RoomtypeBarChart({ rootState, commit }) {
      let tableName = 'roomtype_' + rootState.Administrator.adminID
      let res = await roomtypeBarChart(tableName)
      return res
    },
  },
};
