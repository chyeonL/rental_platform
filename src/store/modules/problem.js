import {
  getAllProblems,
  goAddProblem,
  getOwnerNameList,
  goSearchProblem,
  goDeletehProblem,
  getProblemDetail,
  goModifyProblem,
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
  // 所有
  async GetAllProblem({ rootState, commit }, pageNo) {
    // console.log({ pageNo, ID: rootState.Administrator.adminID });
    let res = await getAllProblems(pageNo, rootState.Administrator.adminID)
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
  async SearchProblem({ rootState, commit }, { keywords, pageNo }) {
    // console.log({ keywords, pageNo, ID: rootState.Administrator.adminID });
    let res = await goSearchProblem( keywords, pageNo,  rootState.Administrator.adminID );  // params包括 keywords和pageNo
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
  async DeleteProblem(context, No) {
    let res = await goDeletehProblem({ No });
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
  async ProblemDetail({ commit }, No) {
    let res = await getProblemDetail(No);
    console.log(res);
    commit('detail', res.data[0])
    if (res) {  // 成功
      return res.data[0];
    }
  },

  // 编辑
  async ModifyProblem({ commit }, data) {
    //   console.log(data);
    let res = await goModifyProblem(data);
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
  async AddProblem({ commit }, data) {
    let res = await goAddProblem(data);
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

  // 获取房东 name List
  async OwnerNameList(context, data) {
    // console.log(data);
    let res = await getOwnerNameList(data)
    if (res) {
      // console.log(res);
      return res.data
    }
  }
};

export default {
  state,
  mutations,
  actions,
};
