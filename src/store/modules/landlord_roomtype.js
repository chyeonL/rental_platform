import { allRoomType, DetailRoomType, newRoomType, roomTypePicture, modifyRoomtype, deleteRoomtype, searchRoomtype } from '@/api'
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
        // 所有房型 GetAllRoomType
        async GetAllRoomType({ rootState, commit }, pageNo) {
            let tableName = 'roomtype_' + rootState.Administrator.adminID
            // console.log(pageNo, tableName);
            let res = await allRoomType(pageNo, tableName);
            console.log(res);
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

        // 上传照片
        async TypePicture({ rootState }, { url, No }) {
            let tableName = 'roomtype_' + rootState.Administrator.adminID
            let res = await roomTypePicture(url, No, tableName)
        },


        // 搜索
        async SearchRoomtype({ rootState, commit }, { keywords, pageNo }) {
            let tableName = 'roomtype_' + rootState.Administrator.adminID
            let res = await searchRoomtype(keywords, pageNo, tableName);
            commit("search", res);
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
        async DeleteRoomtype({ rootState }, No) {
            let tableName = 'roomtype_' + rootState.Administrator.adminID
            let res = await deleteRoomtype(No, tableName);
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
        async RoomTypeDetail({ rootState, commit }, No) {
            let tableName = 'roomtype_' + rootState.Administrator.adminID
            let res = await DetailRoomType(No, tableName);
            commit('detail', res.data[0])
            if (res) {  // 成功
                return res.data[0];
            }
        },

        // 编辑
        async ModifyRoomtype({ rootState, commit }, form) {
            let tableName = 'roomtype_' + rootState.Administrator.adminID
            let res = await modifyRoomtype(form, tableName);
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
        async AddRoomType({ rootState, commit }, form) {
            let tableName = 'roomtype_' + rootState.Administrator.adminID
            // console.log(form, tableName);
            let res = await newRoomType(form, tableName);
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
        }
    }
}