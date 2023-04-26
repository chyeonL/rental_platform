import {
  getAllMigrants,
  getMigranteDetail,
  getLandlordNameList,
  goModifyMigrant,
  goAddMigrant,
  goDeletehMigrant,
  goSearchMigrant
} from "@/api";
import { Notification } from "element-ui";
const state = {
  total: 0,
  pageSize: 5, // 获取后端设定的页面数据量大小，
  pageNo: 1,
  currentPage: 1,
  allMigrants: [], // 所有出租屋 或 搜索结果
  migrantList: [], // 所有页面--分页展示的数据
  searchList: [], // 搜索展示的数据
  migrantDetail: {}, // xx出租屋的具体信息
};

const mutations = {
  // 所有
  allMigrants(state, payload) {
    state.total = payload.total;
    state.pageSize = payload.pageSize;
    state.pageNo = payload.pageNo;
    state.currentPage = payload.pageNo;
    state.allMigrants = payload.allData;
    state.migrantList = payload.data;
  },
  // 搜索
  SearchList(state, payload) {
    state.searchList = payload.data;
    state.total = payload.total;
    state.pageSize = payload.pageSize;
    state.pageNo = payload.pageNo;
    state.currentPage = payload.pageNo;
    state.allMigrants = payload.allData;
  },
  // 详情
  migrantDetail(state, payload) {
    state.migrantDetail = payload
  }
};

const actions = {
  // 所有
  async GetAllMigrants({ rootState, commit }, pageNo) {
    let res = await getAllMigrants(pageNo, rootState.Administrator.adminID);
    // console.log(res);
    commit("allMigrants", res);
    if (res) {  // 成功
      if (!res.success)
        Notification({
          type: "error",
          message: "信息获取失败！",
          title: '失败提醒',
          offset: 60,
          duration: 2000
        })
      return res.success;
    }
  },

  // 搜索
  async SearchMigrant({ rootState, commit }, { keywords, pageNo }) {
    let res = await goSearchMigrant({ keywords, pageNo, ID: rootState.Administrator.adminID });  // params包括 keywords和pageNo
    // console.log(res);
    commit("SearchList", res);
    if (res) {  // 成功
      if (!res.success)
        Notification({
          title: "失败提醒",
          offset: 60,
          duration: 2000,
          type: "error",
          message: "搜索失败！没有找到相关记录。",
        });
      else
        Notification({
          title: "成功",
          offset: 60,
          duration: 2000,
          type: "success",
          message: "搜索成功！",
        });
      return res.success;
    }
  },

  // 删除
  // async DeleteMigrant(context, No) {
  //   // params包括 keywords和pageNo
  //   let res = await goDeletehMigrant({ No });
  //   // console.log(res);
  //   if (res) {
  //     // 成功
  //     if (res.success)
  //       Notification({
  //         title: "成功",
  //         offset: 60,
  //         duration: 2000,
  //         type: "success",
  //         message: "成功删除！",
  //       });
  //     else
  //       Notification({
  //         title: "失败提醒",
  //         offset: 60,
  //         duration: 2000,
  //         type: "error",
  //         message: "删除失败",
  //       });
  //     return res.success;
  //   }
  // },

  // 获取详情
  async migrantDetail({ commit }, No) {
    let res = await getMigranteDetail(No);
    // console.log(res);
    commit('migrantDetail', res.data[0])
    if (res) {  // 成功
      return res.data[0];
    }
  },

  // 编辑
  async ModifyMigrant({ commit }, data) {
    //   console.log(data);
    let res = await goModifyMigrant(data);
    // console.log(res);
    if (res) {
      // 成功
      if (res.success)
        Notification({
          title: "成功",
          offset: 60,
          duration: 2000,
          type: "success",
          message: "编辑成功！",
        });
      else
        Notification({
          title: "失败提醒",
          offset: 60,
          duration: 2000,
          type: "error",
          message: "编辑失败",
        });
      return res.success;
    }
  },

  // 添加
  // async AddMigrant({ commit }, data) {
  //   let res = await goAddMigrant(data);
  //   // console.log(res);
  //   if (res) {
  //     // 成功
  //     if (res.success)
  //       Notification({
  //         title: "成功",
  //         offset: 60,
  //         duration: 2000,
  //         type: "success",
  //         message: "编辑成功！",
  //       });
  //     else
  //       Notification({
  //         title: "失败提醒",
  //         offset: 60,
  //         duration: 2000,
  //         type: "error",
  //         message: "编辑失败",
  //       });
  //     return res.success;
  //   }
  // },

  // 获取房东 name List
  async LandlordNameList(context, data) {
    let res = await getLandlordNameList(data)
    if (res) {
      console.log(res);
      return res.data
    }
  }
};

export default {
  state,
  mutations,
  actions,
};
