import {
  getAllHouse,
  goSearchHouse,
  goDeletehHouse,
  getHouseDetail,
  goModifyHouse,
  goAddHouse,
  getLandlordIdList
} from "@/api";
import { Notification } from "element-ui";
const state = {
  total: 0,
  pageSize: 5, // 获取后端设定的页面数据量大小，
  pageNo: 1,
  currentPage: 1,
  allHouse: [], // 所有出租屋 或 搜索结果
  HouseList: [], // 所有页面--分页展示的数据
  searchList: [], // 搜索展示的数据
  houseDetail: {}, // xx出租屋的具体信息
};

const mutations = {
  // 所有出租屋
  AllHouse(state, payload) {
    state.total = payload.total;
    state.pageSize = payload.pageSize;
    state.pageNo = payload.pageNo;
    state.currentPage = payload.pageNo;
    state.allHouse = payload.allData;
    state.HouseList = payload.data;
  },
  // 搜索
  SearchList(state, payload) {
    state.searchList = payload.data;
    state.total = payload.total;
    state.pageSize = payload.pageSize;
    state.pageNo = payload.pageNo;
    state.currentPage = payload.pageNo;
    state.allHouse = payload.allData;
  },
  // 详情
  HouseDetail(state, payload) {
    state.houseDetail = payload
  }
};

const actions = {
  // 所有出租屋
  async GetAllHouse({ rootState, commit }, pageNo) {
    let res = await getAllHouse(pageNo, rootState.Administrator.adminID);
    commit("AllHouse", res);
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
  async SearchHouse({ rootState, commit }, { keywords, pageNo }) {
    let res = await goSearchHouse({ keywords, pageNo, ID: rootState.Administrator.adminID });
    commit("SearchList", res);
    if (res) { 
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
  async DeleteHouse(context, No) {
    let res = await goDeletehHouse({ No });
    if (res) {
      // 成功
      if (res.success)
        Notification({
          title: "成功",
          offset: 60,
          duration: 2000,
          type: "success",
          message: "成功删除！",
        });
      else
        Notification({
          title: "失败提醒",
          offset: 60,
          duration: 2000,
          type: "error",
          message: "删除失败",
        });
      return res.success;
    }
  },

  // 获取详情
  async HouseDetail({ commit }, No) {
    let res = await getHouseDetail(No);
    // console.log(res);
    commit('HouseDetail', res.data[0])
    if (res) {  // 成功
      return res.data[0];
    }
  },

  // 编辑
  async ModifyHouse({ commit }, data) {
    console.log(data);
    let res = await goModifyHouse(data);
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
  async AddHouse({ commit }, data) {
    let res = await goAddHouse(data);
    if (res) {
      // 成功
      if (res.success)
        Notification({
          title: "成功",
          offset: 60,
          duration: 2000,
          type: "success",
          message: "新增出租屋成功！",
        });
      else
        Notification({
          title: "失败提醒",
          offset: 60,
          duration: 2000,
          type: "error",
          message: "新增失败",
        });
      return res.success;
    }
  },

  // 获取管理员ID List
  async LandlordIdList(context, data) {
    let res = await getLandlordIdList(data)
    if (res) {
      return res.data
    }
  }
};

export default {
  state,
  mutations,
  actions,
};
