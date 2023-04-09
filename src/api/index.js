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
export const goAddMigrant = (data) => request({ url: '/addMigrant', data, method: 'post' })
export const goDeletehMigrant = (data) => request({ url: '/deleteMigrant', data, method: 'post' })
export const goSearchMigrant = (params) => request({ url: '/searchMigrant', params })
// 巡视记录 
export const getAllInspectations = (params) => request({ url: '/allInspectation', params, method: 'get' })      // all
export const goAddInspectation = (data) => request({ url: '/newInspectation', data, method: 'post' })           // add
export const goDeletehInspectation = (data) => request({ url: '/deleteInspectation', data, method: 'post' })    // delete
export const getInspectationDetail = (params) => request({ url: '/inspectationDetail', method: 'get', params }) // detail
export const goModifyInspectation = (data) => request({ url: '/updateInspectation', data, method: 'post' })     // modify
export const goSearchInspectation = (params) => request({ url: '/searchInspectation', params })                 // search
// 群众意见         
export const getAllOpinions = (pageNo, ID) => request({ url: '/allOpinions', params: { pageNo, ID } })
export const goSearchOpinions = (params) => request({ url: '/searchOpinions', params })
export const goAddOpinion = (data) => request({ url: '/addOpinion', data, method: 'post' })
export const getOpinionDetail = (No) => request({ url: '/opinionDetail', method: 'get', params: { No } })
export const goModifyOpinion = (data) => request({ url: '/updateOpinion', data, method: 'post' })
export const goDeletehOpinion = (data) => request({ url: '/deleteOpinion', data, method: 'post' })
// 问题报告         Problem     
export const getAllProblems = (pageNo, ID) => request({ url: '/allProblems', params: { pageNo, ID } })
export const goAddProblem = (data) => request({ url: '/newProblem', data, method: 'post' })           // add
export const getOwnerNameList = (AreaID) => request({ url: '/getOwnerName', params: { AreaID: AreaID }, method: 'get' })
export const goSearchProblem = (keywords, pageNo, ID) => request({ url: '/searchProblems', params: { keywords, pageNo, ID } })                 // search
export const goDeletehProblem = (data) => request({ url: '/deleteProblem', data, method: 'post' })    // delete
export const getProblemDetail = (No) => request({ url: '/problemDetail', method: 'get', params: { No } })
export const goModifyProblem = (data) => request({ url: '/ModifyProblem', data, method: 'post' })


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
export const newRoom = (form, tableName) => request({ url: '/newRoom', data: { form, tableName }, method: 'post' })
export const typeList = (tableName) => request({ url: '/typeList', params: { tableName } })
export const contractList = (tableName) => request({ url: '/contractList', params: { tableName } })
export const deleteRoom = (No, tableName) => request({ url: '/deleteRoom', params: { tableName, No }, method: 'get' })
export const searchRoom = (keywords, pageNo, tableName) => request({ url: '/searchRoom', params: { keywords, pageNo, tableName }, method: 'get' })
export const detailRoom = (No, tableName) => request({ url: '/detailRoom', params: { tableName, No }, method: 'get' })
export const modifyRoom = (form, tableName) => request({ url: '/modifyRoom', method: 'post', data: { form, tableName } })
// 意见
export const getMyOpinion = (pageNo, tableName, Landlord_ID) => request({ url: '/getMyOpinion', params: { pageNo, tableName, Landlord_ID } })
export const newMyOpinion = (tableName, form) => request({ url: '/newMyOpinion', data: { tableName, form }, method: 'post' })
export const deleteMyOpinion = (tableName, No) => request({ url: '/deleteMyOpinion', params: { tableName, No } })
export const modifyMyOpinion = (tableName, form) => request({ url: '/modifyMyOpinion', data: { tableName, form },method:'post' })
export const searchMyOpinion = (tableName, keywords, pageNo) => request({ url: '/searchMyOpinion', params: { tableName, keywords, pageNo } })
export const detailMyOpinion = (tableName, No) => request({ url: '/detailMyOpinion', params: { No, tableName } })







// website用        getHouseList
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