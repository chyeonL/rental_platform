import {
    getVillageInfoByID,
    getVillageList,
    changeVillage,
    getCurrentVillage,
    ModifyVillageInfo,
    // 出租屋
    changeHouse,
    getCurrentHouse,
    getHouseList,
    getHouseInfoByID,
    modifyHouseInfo,
    uploadCover,
    roomtypeList
} from '@/api'
const state = {
    village: {},
    house: {},
}
const mutations = {
    // 村庄资讯
    VillageInfo(state, payload) {
        state.village = payload
    },
    // 出租屋资讯
    HouseInfo(state, payload) {
        state.house = payload
    }
}

const actions = {
    // 村庄

    // 获取资讯  Staff_ID
    async GetVillageInfoByID({ commit }, Staff_ID) {
        // console.log(Staff_ID);
        let res = await getVillageInfoByID(Staff_ID)
        console.log(res);
        if (res) {
            commit('VillageInfo', res.data[0])
            return res
        }
    },

    async ChangeVillage(context, AreaID) {                    // 切换村庄
        // console.log(AreaID);
        let res = await changeVillage(AreaID)
        console.log(res);
        if (res) return res
    },

    async GetCurrentVillage({ commit }) {                  // 当前村庄
        let res = await getCurrentVillage()
        console.log(res);
        if (res) {
            commit('VillageInfo', res.data[0])
            return res
        }
    },

    async ModifyVillageInfo({ commit }, Info) {           // 修改
        // console.log(Info);
        let res = await ModifyVillageInfo(Info)
        console.log(res);
        if (res) return res
    },

    async GetVillageList({ commit }) {                  // 获取村庄list
        let res = await getVillageList()
        console.log(res);
        return res.data
    },


    // 出租屋

    async ChangeHouse(context, { AreaID, Landlord_ID }) {       // 切换
        // console.log(AreaID, Landlord_ID);
        let res = await changeHouse(AreaID, Landlord_ID)
        console.log(res);
        if (res) return res
    },

    async GetCurrentHouse({ commit }, AreaID) {      // 当前出租屋
        // console.log(AreaID);
        let res = await getCurrentHouse(AreaID)
        console.log(res);
        if (res) {
            commit('HouseInfo', res.data[0])
            return res
        }
    },

    async GetHouseList({ commit }, AreaID) {    // 出租屋list
        // console.log(AreaID);
        let res = await getHouseList(AreaID)
        console.log(res);
        return res.data
    },

    async GetHouseInfoByID({ commit }, ID) {        // 获取 出租资讯 Landlord_ID
        // console.log(ID);
        let res = await getHouseInfoByID(ID)
        console.log(res);
        if (res) {
            commit('HouseInfo', res.data[0])
            return res
        }
    },

    async ModifyHouseInfo({ commit }, Info) {        // 修改
        console.log(Info);
        let res = await modifyHouseInfo(Info)
        console.log(res);
        if (res) return res
    },

    async UploadCover({ commit }, { url, ID, coverSeq }) {        // 上传图片
        console.log(url, ID, coverSeq);
        let res = await uploadCover(url, ID, coverSeq)
        console.log(res);
        if (res) return res
    },

    async getRoomtypeList({ rootState }, Landlord_ID) {
        let tableName = 'roomtype_' + Landlord_ID
        let res = await roomtypeList(tableName)
        console.log(res);
        if (res) return res.data
    }

}

export default {
    state, mutations, actions
}