import { allRents, detailRent, newRent, getMonthsList, modifyRent, deleteRent, searchRent } from '@/api'
import { Notification } from "element-ui";
export default {
    state: {
        total: 0,
        pageSize: 5,
        pageNo: 1,
        currentPage: 1,
        all: [],
        list: [],
        search: [],
        detail: {},
    },
    mutations: {
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
    },
    actions: {
        // 所有
        async GetAllRent({ rootState, commit }, pageNo) {
            let res = await allRents(rootState.Administrator.adminID, pageNo);
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
        async SearchRent({ rootState, commit }, { keywords, pageNo, Status }) {
            let tableName = 'rent_' + rootState.Administrator.adminID
            let res = await searchRent(tableName, keywords, pageNo, Status);
            console.log(res);
            commit("search", res);
            if (res) {
                return res.success;
            }
        },

        // 删除
        async DeleteRent({ rootState }, No) {
            let res = await deleteRent(rootState.Administrator.adminID, No);
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
        async DetailRent({ rootState, commit }, No) {
            let tableName = 'rent_' + rootState.Administrator.adminID
            let res = await detailRent(tableName, No);
            // console.log(res);
            commit('detail', res.data[0])
            if (res) {  // 成功
                return res.data[0];
            }
        },

        // 编辑
        async ModifyRent({ rootState, commit }, form) {
            let res = await modifyRent(rootState.Administrator.adminID, form);
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
        async AddRent({ rootState, commit }, form) {
            let tableName_room = 'rent_' + rootState.Administrator.adminID
            let res = await newRent(tableName_room, form);
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

        // 月份列表
        async MonthsList({ rootState }, ContractNo) {
            let res = await getMonthsList(rootState.Administrator.adminID, ContractNo)
            // console.log(res);
            if (res) return res.data
        }
    }
}