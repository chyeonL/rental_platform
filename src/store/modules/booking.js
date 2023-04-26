import { newBooking, allBooking, searchBooking, deleteBooking, detailBooking, updateBookingStatus, toBeConfirm, viewHistory, rescheduleBooking } from '@/api'
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
        confirmNumber: 0
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
        },
        confirmNumber(state, payload) {
            state.confirmNumber = payload
        }
    },
    actions: {
        async NewBooking({ rootState }, { Name, Time, Contact, Gender, Requirement, Roomtype }) {
            let data = {
                Name, Time, Contact, Gender, Requirement, Roomtype,
                Staff_ID: rootState.Website.village.Staff_ID,
                Area: rootState.Website.village.Area,
                Landlord_ID: rootState.Website.house.Landlord_ID,
                Landlord_Name: rootState.Website.house.LandlordName,
                BookingStatus: '提交预约'
            }
            // console.log(data);
            let res = await newBooking(data);
            // console.log(res);
            return res;
        },


        async GetAllBooking({ rootState, commit }, pageNo) {
            let res = await allBooking(rootState.Administrator.adminID, pageNo);
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


        async SearchBooking({ rootState, commit }, { keywords, pageNo, BookingStatus }) {
            let res = await searchBooking(rootState.Administrator.adminID, keywords, pageNo, BookingStatus);
            // console.log(res);
            commit("search", res);
            if (res) {
                return res.success;
            }
        },


        async DeleteBooking({ rootState }, No) {
            let res = await deleteBooking(No);
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


        async DetailBooking({ commit }, No) {
            let res = await detailBooking(No);
            // console.log(res);
            commit('detail', res.data[0])
            if (res) {  // 成功
                return res.data[0];
            }
        },


        async UpdateBookingStatus({ rootState }, { No, BookingStatus }) {
            let res = await updateBookingStatus(No, BookingStatus);
            // console.log(res);
            if (res) {
                // 成功
                if (res.success)
                    Notification({
                        title: '成功',
                        message: `成功处理访客预约！`,
                        type: 'success',
                        offset: 100,
                        duration: 3000
                    });
                else
                    Notification({
                        title: '错误',
                        message: `修改失败`,
                        type: 'error',
                        offset: 100,
                        duration: 3000
                    });
                return res.success;
            }
        },


        async ToBeConfirm({ rootState, commit }) {
            let res = await toBeConfirm(rootState.Administrator.adminID)
            // console.log(res);
            if (res.success) commit('confirmNumber', res.data)
        },

        async ViewHistory({ commit }, { pageNo, Name, Contact }) {
            let res = await viewHistory(pageNo, Name, Contact)
            console.log(res);
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

        // No, Time 
        async rescheduleBooking(context, { No, Time }) {
            let res = await rescheduleBooking(No, Time)
            console.log(res);
            if (res) return res.sucess
        }
    },
};
