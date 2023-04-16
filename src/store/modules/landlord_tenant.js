import { allTenants, detailTenant, modifyTenant, deleteTenant, searchTenant, reportTenant } from '@/api'
import { Notification } from "element-ui";
export default {
    state: {
        total: 0,
        pageSize: 5, // 获取后端设定的页面数据量大小，
        pageNo: 1,
        currentPage: 1,
        all: [], // 所有出租屋 或 搜索结果
        list: [], // 所有页面--分页展示的数据
        search: [], // 搜索展示的数据
        detail: {}, // xx出租屋的具体信息
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
        async GetAllTenants({ rootState, commit }, pageNo) {
            // let tableName = 'room_' + rootState.Administrator.adminID
            // console.log(pageNo, tableName);
            let res = await allTenants(rootState.Administrator.adminID, pageNo);
            // console.log(res);
            commit("all", res);
            if (res) {  // 成功
                if (!res.success)
                    Notification({
                        title: '失败',
                        message: `信息获取失败！`,
                        type: 'error',
                        offset: 100,
                        duration: 3000
                    });
                return res.success;
            }
        },

        // 搜索
        async SearchTenant({ rootState, commit }, { keywords, pageNo }) {
            let tableName = 'tenant_' + rootState.Administrator.adminID
            // console.log(keywords, pageNo, tableName);
            let res = await searchTenant(tableName, keywords, pageNo);
            console.log(res);
            commit("search", res);
            if (res) {  // 成功
                if (!res.success)
                    Notification({
                        title: '失败',
                        message: `搜索失败！没有找到相关记录。`,
                        type: 'error',
                        offset: 100,
                        duration: 3000
                    });
                else
                    Notification({
                        title: '成功',
                        message: `搜索成功！`,
                        type: 'success',
                        offset: 100,
                        duration: 3000
                    });
                return res.success;
            }
        },

        // 删除
        async DeleteTenant({ rootState }, No) {
            let res = await deleteTenant(rootState.Administrator.adminID, No);
            // console.log(res);
            if (res) {
                // 成功
                if (res.success)
                    Notification({
                        title: '成功',
                        message: `成功删除！`,
                        type: 'success',
                        offset: 100,
                        duration: 3000
                    });
                else
                    Notification({
                        title: '失败',
                        message: `删除失败`,
                        type: 'error',
                        offset: 100,
                        duration: 3000
                    });
                return res.success;
            }
        },

        // 获取详情
        async DetailTenant({ rootState, commit }, No) {
            let tableName = 'tenant_' + rootState.Administrator.adminID
            // console.log(No, tableName);
            let res = await detailTenant(tableName, No);
            // console.log(res);
            commit('detail', res.data[0])
            if (res) {  // 成功
                return res.data[0];
            }
        },

        // 编辑
        async ModifyTenant({ rootState, commit }, form) {
            let res = await modifyTenant(rootState.Administrator.adminID, form);
            // console.log(res);
            if (res) {
                // 成功
                if (res.success)
                    Notification({
                        title: '成功',
                        message: `编辑成功！`,
                        type: 'success',
                        offset: 100,
                        duration: 3000
                    });
                else
                    Notification({
                        title: '错误',
                        message: `编辑失败`,
                        type: 'error',
                        offset: 100,
                        duration: 3000
                    });
                return res.success;
            }
        },

        // 报备
        async ReportTenant({ rootState, commit }) {
            let res = await reportTenant(rootState.Administrator.adminID, rootState.Administrator.userInfo.Name, { Staff_ID: rootState.Administrator.userInfo.InChargeStaffID, StaffName: rootState.Administrator.userInfo.InChargeStaffName, Area: rootState.Administrator.userInfo.Area, AreaID: rootState.Administrator.userInfo.AreaID })
            // console.log(res);
            if (res.code == '200') {
                Notification({
                    title: '成功',
                    message: `成功向${res.data.StaffName}报备${res.data.number}名租户：编号${res.data.NoStr}`,
                    type: 'success',
                    offset: 100,
                    duration: 3000
                });
            } else if (res.code == '203') {
                Notification({
                    title: '提醒',
                    message: res.msg,
                    type: 'warning',
                    offset: 100,
                    duration: 3000
                });
            } else {
                Notification({
                    title: '错误',
                    message: '报备失败',
                    type: 'error',
                    offset: 100,
                    duration: 3000
                });
            }
        },
    }
}