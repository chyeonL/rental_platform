import {
    getAllInspectations,
    goAddInspectation,
    goDeletehInspectation,
    getInspectationDetail,
    goModifyInspectation,
    goSearchInspectation
} from "@/api";
import { Message } from "element-ui";

const state = {
    total: 0,
    pageSize: 5, // 获取后端设定的页面数据量大小，
    pageNo: 1,
    currentPage: 1,
    all: [], // 所有出租屋 或 搜索结果
    list: [], // 所有页面--分页展示的数据
    search: [], // 搜索展示的数据
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
    async SearchInspectation({ rootState, commit }, { keywords, pageNo }) {
        let tableName = rootState.Administrator.adminID + '_inspectation'
        let res = await goSearchInspectation({ keywords, pageNo , tableName });
        console.log(res);
        commit("search", res);
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
    async DeleteInspectation({ rootState }, No) {
        let tableName = rootState.Administrator.adminID + '_inspectation'
        let res = await goDeletehInspectation({ No, tableName });
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
    async InspectationDetail({ rootState,commit }, No) {
        let tableName = rootState.Administrator.adminID + '_inspectation'
        let res = await getInspectationDetail({ No, tableName });
        console.log(res);
        commit('detail', res.data[0])
        if (res) {  // 成功
            return res.data[0];
        }
    },

    // 编辑
    async ModifyInspectation({ rootState,commit }, form) {
        let tableName = rootState.Administrator.adminID + '_inspectation'
        let res = await goModifyInspectation({ form, tableName });
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
    async AddInspectation({ rootState, commit }, form) {
        let tableName = rootState.Administrator.adminID + '_inspectation'
        let res = await goAddInspectation({ form, tableName });
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
