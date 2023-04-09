import {
  getAllHouse,
  goSearchHouse,
  goDeletehHouse,
  getHouseDetail,
  goModifyHouse,
  goAddHouse,
  getLandlordIdList
} from "@/api";
import { Message } from "element-ui";
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
    // console.log(rootState.Administrator.adminID);
    let res = await getAllHouse(pageNo, rootState.Administrator.adminID);
    console.log(res);
    commit("AllHouse", res);
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
  async SearchHouse({ rootState, commit }, {keywords, pageNo}) {
    let res = await goSearchHouse({ keywords, pageNo, ID: rootState.Administrator.adminID });  // params包括 keywords和pageNo
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
  async DeleteHouse(context, No) {
    // params包括 keywords和pageNo
    let res = await goDeletehHouse({ No });
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
  async HouseDetail({ commit }, No) {
    let res = await getHouseDetail(No);
    console.log(res);
    commit('HouseDetail', res.data[0])
    if (res) {  // 成功
      return res.data[0];
    }
  },

  // 编辑
  async ModifyHouse({ commit }, data) {
    console.log(data);
    let res = await goModifyHouse(data);
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
  async AddHouse({ commit }, data) {
    let res = await goAddHouse(data);
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

  // 获取管理员ID List
  async LandlordIdList(context, data) {
    let res = await getLandlordIdList(data)
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
