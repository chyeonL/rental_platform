import { allRoom, detailRoom, newRoom,typeList, contractList,modifyRoom, deleteRoom, searchRoom } from '@/api'
import { Message } from "element-ui";
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
            // console.log(pageNo, tableName);
            let res = await allRoom(pageNo, tableName);
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
        async SearchRoom({ rootState, commit }, { keywords, pageNo }) {
            let tableName = 'room_' + rootState.Administrator.adminID
            console.log(keywords, pageNo, tableName);
            let res = await searchRoom(keywords, pageNo, tableName);
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
        async DeleteRoom({ rootState }, No) {
            let tableName = 'room_' + rootState.Administrator.adminID
            // console.log(No, tableName);
            let res = await deleteRoom(No, tableName);
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
        async DetailRoom({ rootState, commit }, No) {
            let tableName = 'room_' + rootState.Administrator.adminID
            // console.log(No, tableName);
            let res = await detailRoom(No, tableName);
            console.log(res);
            commit('detail', res.data[0])
            if (res) {  // 成功
                return res.data[0];
            }
        },

        // 编辑
        async ModifyRoom({ rootState, commit }, form) {
            let tableName = 'room_' + rootState.Administrator.adminID
            let res = await modifyRoom(form, tableName );
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
        async AddRoom({ rootState, commit }, form) {
            let tableName = 'room_' + rootState.Administrator.adminID
            console.log(form, tableName);
            let res = await newRoom(form, tableName);
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
        
        // 房型列表
        async TypeList({rootState}){
            let tableName = 'roomtype_' + rootState.Administrator.adminID
            // console.log( tableName);
            let res = await typeList(tableName)
            console.log(res);
            if(res)     return res.data
        },

         // 房型列表
         async ContractList({rootState}){
            let tableName = 'contract_' + rootState.Administrator.adminID
            // console.log( tableName);
            let res = await contractList(tableName)
            console.log(res);
            if(res)     return res.data
        }
    }
}