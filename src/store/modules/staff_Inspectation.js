import {
    getAllInspectations,
    goAddInspectation,
    goDeletehInspectation,
    getInspectationDetail,
    goModifyInspectation,
    goSearchInspectation,
    getLandlordList
} from "@/api";
import { Notification } from "element-ui";

const state = {
    total: 0,
    pageSize: 5,
    pageNo: 1,
    currentPage: 1,
    all: [],
    list: [],
    search: [],
    detail: {},
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
    search(state, payload) {
        state.search = payload.data;
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
    async GetAll({ rootState, commit }, pageNo) {
        let tableName = rootState.Administrator.adminID + '_inspectation'
        // console.log(tableName);
        let res = await getAllInspectations({ pageNo, tableName });
        // console.log(res);
        commit("all", res);
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
    async SearchInspectation({ rootState, commit }, { keywords, pageNo, Overall }) {
        let tableName = rootState.Administrator.adminID + '_inspectation'
        let res = await goSearchInspectation({ keywords, pageNo, tableName, Overall });
        // console.log(res);
        commit("search", res);
        if (res) {
            return res.success;
        }
    },

    // 删除
    async DeleteInspectation({ rootState }, No) {
        let tableName = rootState.Administrator.adminID + '_inspectation'
        let res = await goDeletehInspectation({ No, tableName });
        // console.log(res);
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
    async InspectationDetail({ rootState, commit }, No) {
        let tableName = rootState.Administrator.adminID + '_inspectation'
        let res = await getInspectationDetail({ No, tableName });
        // console.log(res);
        commit('detail', res.data[0])
        if (res) {  // 成功
            return res.data[0];
        }
    },

    // 编辑
    async ModifyInspectation({ rootState, commit }, form) {
        let tableName = rootState.Administrator.adminID + '_inspectation'
        let res = await goModifyInspectation({ form, tableName });
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
    async AddInspectation({ rootState, commit }, form) {
        let tableName = rootState.Administrator.adminID + '_inspectation'
        let res = await goAddInspectation({ form, tableName });
        // console.log(res);
        if (res) {
            // 成功
            if (res.success)
                Notification({
                    title: "成功",
                    offset: 60,
                    duration: 2000,
                    type: "success",
                    message: "新增成功！",
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

    async LandlordList({ rootState }) {
        let { AreaID } = rootState.Administrator.userInfo
        let res = await getLandlordList(AreaID)
        // console.log(res);
        return res.data
    }
};

export default {
    state,
    mutations,
    actions,
};
