import { allRoom, detailRoom, newRoom, typeList, contractList, modifyRoom, deleteRoom, searchRoom } from '@/api'
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
        async GetAllRoom({ rootState, commit }, pageNo) {
            let tableName = 'room_' + rootState.Administrator.adminID
            let res = await allRoom(pageNo, tableName);
            commit("all", res);
            if (res) {  // 成功
                if (!res.success)
                    Notification({
                        title: "失败提醒",
                        offset: 60,
                        duration: 2000,
                        type: "error",
                        message: "信息获取失败！",
                    });
                return res.success;
            }
        },


        // 搜索
        async SearchRoom({ rootState, commit }, { keywords, pageNo, RentStatus }) {
            let tableName = 'room_' + rootState.Administrator.adminID
            let res = await searchRoom(keywords, pageNo, tableName, RentStatus);
            commit("search", res);
            if (res) {  
                return res.success;
            }
        },

        // 删除
        async DeleteRoom({ rootState }, { No, RoomType, RoomNumber }) {
            let tableName_room = 'room_' + rootState.Administrator.adminID
            let tableName_roomtype = 'roomtype_' + rootState.Administrator.adminID
            let res = await deleteRoom(tableName_room, tableName_roomtype, No, RoomType, RoomNumber);
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
        async DetailRoom({ rootState, commit }, No) {
            let tableName = 'room_' + rootState.Administrator.adminID
            let res = await detailRoom(No, tableName);
            commit('detail', res.data[0])
            if (res) {  // 成功
                return res.data[0];
            }
        },

        // 编辑
        async ModifyRoom({ rootState }, form) {
            let tableName_room = 'room_' + rootState.Administrator.adminID
            let tableName_roomtype = 'roomtype_' + rootState.Administrator.adminID
            let res = await modifyRoom(form, tableName_room, tableName_roomtype);
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
        async AddRoom({ rootState }, form) {
            let tableName_room = 'room_' + rootState.Administrator.adminID
            let tableName_roomtype = 'roomtype_' + rootState.Administrator.adminID
            let res = await newRoom(form, tableName_room, tableName_roomtype);
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

        // 房型列表
        async TypeList({ rootState }) {
            let tableName = 'roomtype_' + rootState.Administrator.adminID
            let res = await typeList(tableName)
            if (res) return res.data
        },

        // 合同列表
        async ContractList({ rootState }) {
            let tableName = 'contract_' + rootState.Administrator.adminID
            let res = await contractList(tableName)
            if (res) return res.data
        }
    }
}