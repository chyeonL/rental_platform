import { allContracts, newContract, terminateContract, deleteContract, searchContract, detailContract, getRoomList } from '@/api'
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
        async GetAllContracts({ rootState, commit }, pageNo) {
            let res = await allContracts(rootState.Administrator.adminID, pageNo);
            // console.log(res);
            commit("all", res);
            if (res) {  // 成功
                if (!res.success)
                    Notification({
                        title: "错误提醒",
                        offset: 60,
                        duration: 2000,
                        type: "error",
                        message: "信息获取失败！",
                    });
                return res.success;
            }
        },

        // 搜索
        async SearchContract({ rootState, commit }, { keywords, pageNo, Stage }) {
            let tableName = 'contract_' + rootState.Administrator.adminID
            console.log(keywords, pageNo, Stage );
            let res = await searchContract(tableName, keywords, pageNo, Stage);
            console.log(res);
            commit("search", res);
            if (res) {  
                return res.success;
            }
        },

        // 删除
        async DeleteContract({ rootState }, No) {
            let res = await deleteContract(rootState.Administrator.adminID, No);
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
                        title: "错误提醒",
                        offset: 60,
                        duration: 2000,
                        type: "error",
                        message: "删除失败",
                    });
                return res.success;
            }
        },

        // 获取详情
        async DetailContract({ rootState, commit }, No) {
            let tableName = 'contract_' + rootState.Administrator.adminID
            let res = await detailContract(tableName, No);
            commit('detail', res.data[0])
            if (res) {  // 成功
                return res.data[0];
            }
        },

        // 编辑 -- 终止合同
        async TerminateContract({ rootState }, { No, Room, RoomType }) {
            let res = await terminateContract(rootState.Administrator.adminID, No, Room, RoomType);
            if (res) {
                // 成功
                if (res.success)
                    Notification({
                        title: "成功",
                        offset: 60,
                        duration: 2000,
                        type: "success",
                        message: "成功终止合同！",
                    });
                else
                    Notification({
                        title: "错误提醒",
                        offset: 60,
                        duration: 2000,
                        type: "error",
                        message: "终止失败",
                    });
                return res.success;
            }
        },

        // 添加
        async AddContract({ rootState }, form) {
            let res = await newContract(rootState.Administrator.adminID, form);
            // console.log(res);
            if (res) {
                // 成功
                if (res.success)
                    Notification({
                        title: "成功",
                        offset: 60,
                        duration: 4000,
                        type: "success",
                        message: "新增合同成功！请前往'收入租金'和'流动人员'分别完善月租、租户信息!",
                    });
                else
                    Notification({
                        title: "错误提醒",
                        offset: 60,
                        duration: 2000,
                        type: "error",
                        message: "新增合同失败",
                    });
                return res.success;
            }
        },

        // 房间列表
        async RoomList({ rootState }) {
            let tableName = 'room_' + rootState.Administrator.adminID
            let res = await getRoomList(tableName)
            if (res) return res.data
        },
    }
}