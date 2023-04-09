import {
  getAllOpinions,     // staff    
  getOpinionDetail,
  goModifyOpinion,
  goAddOpinion,
  goDeletehOpinion,
  goSearchOpinions,
  getMyOpinion,       // landlord
  newMyOpinion,
  deleteMyOpinion,
  modifyMyOpinion,
  searchMyOpinion,
  detailMyOpinion
} from "@/api";
import { Message } from "element-ui";
const state = {
  total: 0,
  pageSize: 5, // 获取后端设定的页面数据量大小，
  pageNo: 1,
  currentPage: 1,
  all: [], // 所有出租屋 或 搜索结果
  list: [], // 所有页面--分页展示的数据
  searchList: [], // 搜索展示的数据
  detail: {}, // xx出租屋的具体信息
};

const mutations = {
  // 所有
  all(state, payload) {
    state.total = payload.total;
    state.pageSize = payload.pageSize;
    state.pageNo = payload.pageNo;
    state.currentPage = payload.pageNo;
    state.all = payload.allData;
    state.list = payload.data;
  },
  // 搜索
  SearchList(state, payload) {
    state.searchList = payload.data;
    state.total = payload.total;
    state.pageSize = payload.pageSize;
    state.pageNo = payload.pageNo;
    state.currentPage = payload.pageNo;
    state.all = payload.allData;
  },
  // 详情
  detail(state, payload) {
    state.detail = payload
  }
};

const actions = {
  // staff
  // 所有
  async GetAllOpinion({ rootState, commit }, pageNo) {
    let res = await getAllOpinions(pageNo, rootState.Administrator.adminID);
    console.log(res);
    commit("all", res);
    if (res) {  // 成功
      if (!res.success)
        Message({
          type: "error",
          message: "信息获取失败！",
        });
      return res.success;
    }
  },
  // 搜索
  async SearchOpinion({ rootState, commit }, { keywords, pageNo }) {
    let res = await goSearchOpinions({ keywords, pageNo, ID: rootState.Administrator.adminID });  // params包括 keywords和pageNo
    console.log(res);
    commit("SearchList", res);
    if (res) {  // 成功
      if (!res.success)
        Message({
          type: "error",
          message: "搜索失败！没有找到相关记录。",
        });
      else
        Message({
          type: "success",
          message: "搜索成功！",
        });
      return res.success;
    }
  },
  // 删除
  async DeleteOpinion(context, No) {
    let res = await goDeletehOpinion({ No });
    console.log(res);
    if (res) {
      // 成功
      if (res.success)
        Message({
          type: "success",
          message: "成功删除！",
        });
      else
        Message({
          type: "error",
          message: "删除失败",
        });
      return res.success;
    }
  },
  // 获取详情
  async OpinionDetail({ commit }, No) {
    let res = await getOpinionDetail(No);
    console.log(res);
    commit('detail', res.data[0])
    if (res) {  // 成功
      return res.data[0];
    }
  },
  // 编辑
  async ModifyOpinion({ commit }, data) {
    //   console.log(data);
    let res = await goModifyOpinion(data);
    console.log(res);
    if (res) {
      // 成功
      if (res.success)
        Message({
          type: "success",
          message: "编辑成功！",
        });
      else
        Message({
          type: "error",
          message: "编辑失败",
        });
      return res.success;
    }
  },
  // 添加
  async AddOpinion({ commit }, data) {
    let res = await goAddOpinion(data);
    console.log(res);
    if (res) {
      // 成功
      if (res.success)
        Message({
          type: "success",
          message: "新增成功！",
        });
      else
        Message({
          type: "error",
          message: "新增失败",
        });
      return res.success;
    }
  },


  // landlord
  // 所有
  async GetMyOpinion({ rootState, commit }, pageNo) {
    let tableName = rootState.Administrator.userInfo.InChargeStaffID + '_opinion'
    // console.log(pageNo, tableName, rootState.Administrator.adminID);
    let res = await getMyOpinion(pageNo, tableName, rootState.Administrator.adminID);
    console.log(res);
    commit("all", res);
    if (res) {  // 成功
      if (!res.success)
        Message({
          type: "error",
          message: "信息获取失败！",
        });
      return res.success;
    }
  },
  // 搜索
  async SearchMyOpinion({ rootState, commit }, { keywords, pageNo }) {
    let tableName = rootState.Administrator.userInfo.InChargeStaffID + '_opinion'
    // console.log(tableName, keywords, pageNo);
    let res = await searchMyOpinion(tableName, keywords, pageNo);
    console.log(res);
    commit("SearchList", res);
    if (res) {  // 成功
      if (!res.success)
        Message({
          type: "error",
          message: "搜索失败！没有找到相关记录。",
        });
      else
        Message({
          type: "success",
          message: "搜索成功！",
        });
      return res.success;
    }
  },
  // 删除
  async DeleteMyOpinion({ rootState }, No) {
    let tableName = rootState.Administrator.userInfo.InChargeStaffID + '_opinion'
    // console.log(tableName, No);
    let res = await deleteMyOpinion(tableName, No);
    console.log(res);
    if (res) {
      // 成功
      if (res.success)
        Message({
          type: "success",
          message: "成功删除！",
        });
      else
        Message({
          type: "error",
          message: "删除失败",
        });
      return res.success;
    }
  },
  // 获取详情
  async DetailMyOpinion({ commit, rootState }, No) {
    let tableName = rootState.Administrator.userInfo.InChargeStaffID + '_opinion'
    console.log(tableName, No);
    let res = await detailMyOpinion(tableName, No);
    console.log(res);
    commit('detail', res.data[0])
    if (res) {  // 成功
      return res.data[0];
    }
  },
  // 编辑
  async ModifyMyOpinion({ rootState }, data) {
    let tableName = rootState.Administrator.userInfo.InChargeStaffID + '_opinion'
    console.log(tableName, data);
    let res = await modifyMyOpinion(tableName, data);
    console.log(res);
    if (res) {
      // 成功
      if (res.success)
        Message({
          type: "success",
          message: "编辑成功！",
        });
      else
        Message({
          type: "error",
          message: "编辑失败",
        });
      return res.success;
    }
  },
  // 添加
  async NewMyOpinion({ rootState, commit }, data) {
    let tableName = rootState.Administrator.userInfo.InChargeStaffID + '_opinion'
    // console.log(tableName, data);
    let res = await newMyOpinion(tableName, data);
    console.log(res);
    if (res) {
      // 成功
      if (res.success)
        Message({
          type: "success",
          message: "新增成功！",
        });
      else
        Message({
          type: "error",
          message: "新增失败",
        });
      return res.success;
    }
  },
};

export default {
  state,
  mutations,
  actions,
};
