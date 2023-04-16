// 统一封装接口 并 分别暴露
import request from "./request";


// 用户      
export const login = (data) => request.post('/login', data)
export const changePassword = (No, newPwd, oldpwd) => request.post('/changePassword', { No, newPwd, oldpwd })
export const changeInfo = (Name, UserName, Tel, Gender, No, Note) => request.post('/changeInfo', { Name, UserName, Tel, Gender, No, Note })
export const Avatar = (url, No) => request.post('/avatar', { url, No })

// staff用
// 出租屋
export const getAllHouse = (pageNo, ID) => request({ url: '/allHouse', params: { pageNo, ID } })
export const goSearchHouse = (params) => request({ url: '/searchHouse', params })
export const goDeletehHouse = (data) => request({ url: '/deleteHouse', data, method: 'post' })
export const getHouseDetail = (No) => request({ url: '/HouseDetail', method: 'get', params: { No } })// .get('/HouseDetail',param)
export const goModifyHouse = (data) => request({ url: '/updateHouse', data, method: 'post' })
export const goAddHouse = (data) => request({ url: '/addHouse', data, method: 'post' })
export const getLandlordIdList = (AreaID) => request({ url: '/getLandlordID', params: { AreaID: AreaID }, method: 'get' })
// 流动人员
export const getAllMigrants = (pageNo, ID) => request({ url: '/allMigrants', params: { pageNo, ID } })
export const getMigranteDetail = (No) => request({ url: '/migrantDetail', method: 'get', params: { No } })
export const getLandlordNameList = (AreaID) => request({ url: '/getLandlordName', params: { AreaID: AreaID }, method: 'get' })
export const goModifyMigrant = (data) => request({ url: '/updateMigrant', data, method: 'post' })
// export const goAddMigrant = (data) => request({ url: '/addMigrant', data, method: 'post' })
export const goDeletehMigrant = (data) => request({ url: '/deleteMigrant', data, method: 'post' })
export const goSearchMigrant = (params) => request({ url: '/searchMigrant', params })
// 巡视记录 
export const getAllInspectations = (params) => request({ url: '/allInspectation', params, method: 'get' })      // all
export const goAddInspectation = (data) => request({ url: '/newInspectation', data, method: 'post' })           // add
export const goDeletehInspectation = (data) => request({ url: '/deleteInspectation', data, method: 'post' })    // delete
export const getInspectationDetail = (params) => request({ url: '/inspectationDetail', method: 'get', params }) // detail
export const goModifyInspectation = (data) => request({ url: '/updateInspectation', data, method: 'post' })     // modify
export const goSearchInspectation = (params) => request({ url: '/searchInspectation', params })                 // search
export const getLandlordList = (AreaID) => request({ url: '/getLandlordList', params: { AreaID: AreaID } })
// 群众意见         
export const getAllOpinions = (tableName, pageNo) => request({ url: '/allOpinions', params: { tableName, pageNo } })
export const goSearchOpinions = (tableName, keywords, pageNo) => request({ url: '/searchOpinions', params: { tableName, keywords, pageNo } })
export const getOpinionDetail = (tableName, No) => request({ url: '/opinionDetail', method: 'get', params: { tableName, No } })
export const goModifyOpinion = (tableName, form) => request({ url: '/updateOpinion', data: { tableName, form }, method: 'post' })
export const goDeletehOpinion = (tableName, No) => request({ url: '/deleteOpinion', data: { tableName, No }, method: 'post' })
export const getFeedbackNumber = (tableName) => request({ url: '/getFeedbackNumber', params: { tableName } })



// landlord用
// 房型
export const allRoomType = (pageNo, tableName) => request({ url: '/allRoomType', method: 'get', params: { pageNo, tableName } })   // 所有房型
export const DetailRoomType = (No, tableName) => request({ url: '/DetailRoomType', params: { tableName, No }, method: 'get' })
export const newRoomType = (form, tableName) => request({ url: '/newRoomType', method: 'post', data: { tableName, form } })
export const roomTypePicture = (url, No, tableName) => request({ url: '/roomTypePicture', method: 'post', data: { url, No, tableName } })
export const modifyRoomtype = (form, tableName) => request({ url: '/modifyRoomtype', method: 'post', data: { form, tableName } })
export const deleteRoomtype = (No, tableName) => request({ url: '/deleteRoomtype', params: { tableName, No }, method: 'get' })
export const searchRoomtype = (keywords, pageNo, tableName) => request({ url: '/searchRoomtype', params: { keywords, pageNo, tableName }, method: 'get' })
// 房间
export const allRoom = (pageNo, tableName) => request({ url: '/allRoom', params: { pageNo, tableName } })
export const newRoom = (form, tableName_room, tableName_roomtype) => request({ url: '/newRoom', data: { form, tableName_room, tableName_roomtype }, method: 'post' })
export const typeList = (tableName) => request({ url: '/typeList', params: { tableName } })
export const contractList = (tableName) => request({ url: '/contractList', params: { tableName } })
export const deleteRoom = (tableName_room, tableName_roomtype, No, RoomType, RoomNumber) => request({ url: '/deleteRoom', params: { tableName_room, tableName_roomtype, No, RoomType, RoomNumber }, method: 'get' })
export const searchRoom = (keywords, pageNo, tableName) => request({ url: '/searchRoom', params: { keywords, pageNo, tableName }, method: 'get' })
export const detailRoom = (No, tableName) => request({ url: '/detailRoom', params: { tableName, No }, method: 'get' })
export const modifyRoom = (form, tableName_room, tableName_roomtype) => request({ url: '/modifyRoom', method: 'post', data: { form, tableName_room, tableName_roomtype } })
// 意见
export const getMyOpinion = (pageNo, tableName, Landlord_ID) => request({ url: '/getMyOpinion', params: { pageNo, tableName, Landlord_ID } })
export const newMyOpinion = (tableName, form) => request({ url: '/newMyOpinion', data: { tableName, form }, method: 'post' })
export const deleteMyOpinion = (tableName, No) => request({ url: '/deleteMyOpinion', params: { tableName, No } })
export const modifyMyOpinion = (tableName, form) => request({ url: '/modifyMyOpinion', data: { tableName, form }, method: 'post' })
export const searchMyOpinion = (tableName, keywords, pageNo) => request({ url: '/searchMyOpinion', params: { tableName, keywords, pageNo } })
export const detailMyOpinion = (tableName, No) => request({ url: '/detailMyOpinion', params: { No, tableName } })
export const variousOpinions = (tableName, Landlord_ID) => request({ url: '/variousOpinions', params: { tableName, Landlord_ID } })
// 合同
export const allContracts = (ID, pageNo) => request({ url: '/allContracts', params: { ID, pageNo } })
export const newContract = (ID, form) => request({ url: '/newContract', method: 'post', data: { ID, form } })
export const terminateContract = (ID, No, Room, RoomType) => request({ url: '/terminateContract', method: 'post', data: { ID, No, Room, RoomType } })
export const deleteContract = (ID, No) => request({ url: '/deleteContract', params: { ID, No } })
export const searchContract = (tableName, keywords, pageNo) => request({ url: '/searchContract', params: { tableName, keywords, pageNo } })
export const detailContract = (tableName, No) => request({ url: '/detailContract', params: { No, tableName } })
export const getRoomList = (tableName) => request({ url: '/getRoomList', params: { tableName } })
// 租客
export const allTenants = (ID, pageNo) => request({ url: '/allTenants', params: { ID, pageNo } })
export const deleteTenant = (ID, No) => request({ url: '/deleteTenant', params: { ID, No } })
export const searchTenant = (tableName, keywords, pageNo) => request({ url: '/searchTenant', params: { tableName, keywords, pageNo } })
export const detailTenant = (tableName, No) => request({ url: '/detailTenant', params: { No, tableName } })
export const modifyTenant = (ID, form) => request({ url: '/modifyTenant', method: 'post', data: { ID, form } })
export const newTenant = (tableName, form) => request({ url: '/newTenant', method: 'post', data: { tableName, form } })
export const reportTenant = (Landlord_ID, LandlordName, staff) => request({ url: '/reportTenant', method: 'post', data: { Landlord_ID, LandlordName, staff } })
export const toBeReport = (tableName) => request({ url: '/toBeReport', params: { tableName } })
// 月租     
export const allRents = (ID, pageNo) => request({ url: '/allRents', params: { ID, pageNo } })
export const searchRent = (tableName, keywords, pageNo) => request({ url: '/searchRent', params: { tableName, keywords, pageNo } })
export const detailRent = (tableName, No) => request({ url: '/detailRent', params: { No, tableName } })
export const modifyRent = (ID, form) => request({ url: '/modifyRent', method: 'post', data: { ID, form } })
export const deleteRent = (ID, No) => request({ url: '/deleteRent', params: { ID, No } })
export const getMonthsList = (ID, ContractNo) => request({ url: '/getMonthsList', params: { ID, ContractNo } })
export const newRent = (tableName, form) => request({ url: '/newRent', method: 'post', data: { tableName, form } })
// 首页     and     顶部
export const rentedOut = (tableName) => request({ url: '/rentedOut', params: { tableName } })
export const getIncompleteRent = (tableName) => request({ url: '/getIncompleteRent', params: { tableName } })
export const getIncompleteTenant = (tableName) => request({ url: '/getIncompleteTenant', params: { tableName } })
export const roomtypeBarChart = (tableName) => request({ url: '/roomtypeBarChart', params: { tableName } })


// website用        
// 村庄
export const getVillageList = () => request({ url: '/getVillageList', method: 'get' })
export const changeVillage = (AreaID) => request.post('/changeVillage', { AreaID })
export const getCurrentVillage = () => request.get('/CurrentVillage')
export const getVillageInfoByID = (ID) => request({ url: '/villageInfoByID', method: 'get', params: { ID } })
export const ModifyVillageInfo = (form) => request({ url: '/ModifyVillageInfo', method: 'post', data: { form } })
// 出租屋       
export const getHouseList = (AreaID) => request({ url: '/getHouseList', method: 'get', params: { AreaID } })
export const changeHouse = (AreaID, Landlord_ID) => request({ method: 'post', url: '/changeHouse', data: { AreaID, Landlord_ID } })
export const getCurrentHouse = (AreaID) => request({ url: '/CurrentHouse', params: { AreaID }, method: 'get' })
export const getHouseInfoByID = (ID) => request({ url: '/getHouseInfoByID', params: { ID } })
export const modifyHouseInfo = (form) => request({ url: '/ModifyHouseInfo', method: 'post', data: { form } })
export const uploadCover = (url, ID, coverSeq) => request({ url: '/Cover', method: 'post', data: { url, ID, coverSeq } })
export const roomtypeList = (tableName) => request({ url: '/roomtypeList', params: { tableName } })