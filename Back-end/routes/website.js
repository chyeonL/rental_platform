var express = require("express");
var router = express.Router();
var connection = require("../database/connection");

// 村庄资讯
router.get('/villageInfoByID', (req, res) => {    // By ID
  let { ID } = req.query
  console.log(ID);
  connection.query(`select * from website_staff where Staff_ID='${ID}'`, (e, r) => {
    // console.log(e, r);
    if (r.length > 0) {
      res.send({
        code: 200,
        success: true,
        msg: '成功获取村庄资讯By Staff_ID',
        data: r
      })
    } else {
      res.send({
        code: 205,
        success: false,
        msg: '获取村庄资讯失败'
      })
    }
  })
})
router.post('/ModifyVillageInfo', (req, res) => {   // 修改
  let { No, Location, Contact, Area, AreaID, Brief, Office } = req.body.form
  // console.log(No, Location, Contact, Area, AreaID, Brief, Office);
  // 修改区域内出租屋数量
  let sql = `select No from house where AreaID = '${AreaID}'`
  // console.log(sql);
  connection.query(sql, (e0, r0) => {
    // console.log(e0, r0);
    let count = r0.length > 0 ? r0.length : 0
    connection.query(`update website_staff set Location='${Location}',Contact='${Contact}',Area='${Area}',Brief='${Brief}',Office='${Office}',HouseCount='${count}' where No='${No}'`, (e1, r1) => {
      // console.log(e1, r1);
      if (r1.affectedRows > 0) {
        res.send({
          code: 200,
          success: true,
          msg: '成功修改村庄资讯'
        })
      } else {
        res.send({
          code: 205,
          success: false,
          msg: '修改失败'
        })
      }
    })
  })
})
router.get('/getVillageList', (req, res) => {       // 获取 村庄list
  connection.query(`select Area,AreaID,IsCurrent from website_staff`, (e, r) => {
    // console.log(e,r);
    res.send({
      code: 200,
      success: true,
      data: r,
      msg: '获取村庄list成功'
    })
  })
})
router.post('/changeVillage', (req, res) => {           // 切换村庄
  console.log(req.body);
  let { AreaID } = req.body
  connection.query(`update website_staff set IsCurrent = 0`, (e0, r0) => {
    // console.log(e0, r0);
    connection.query(`update website_staff set IsCurrent = 1 where AreaID = '${AreaID}'`, (e1, r1) => {
      // console.log(e1, r1);
      res.send({
        code: 200,
        success: true,
        msg: `成功切换到区域ID为 ${AreaID} 的村庄`
      })
    })
  })
})
router.get('/CurrentVillage', (req, res) => {     // 获取村庄资讯     当前     IsCurrent = 1
  connection.query(`select * from website_staff where IsCurrent = 1`, (e3, r3) => {
    // console.log(e3, r3);
    if (e3) {
      res.send({
        code: 205,
        success: false,
        msg: '获取村庄资讯失败'
      })
    }
    else {
      res.send({
        code: 200,
        success: true,
        msg: '获取当前村庄资讯',
        data: r3
      })
    }
  })
})

// 出租屋资讯
// 房型
router.post('/changeHouse', (req, res) => {             // 切换出租屋
  console.log(req.body);
  let { AreaID, Landlord_ID } = req.body
  connection.query(`update website_landlord set IsCurrent = 0 where AreaID = '${AreaID}'`, (e0, r0) => {
    // console.log(e0, r0);
    connection.query(`update website_landlord set IsCurrent = 1 where Landlord_ID = '${Landlord_ID}'`, (e1, r1) => {
      // console.log(e1, r1);
      res.send({
        code: 200,
        success: true,
        msg: `成功切换到房东ID为 ${Landlord_ID} 的出租屋`
      })
    })
  })
})
router.get('/CurrentHouse', (req, res) => {        // 获取 current出租屋 
  let { AreaID } = req.query
  // console.log(req.query);
  connection.query(`select * from website_landlord where IsCurrent = 1 and AreaID = '${AreaID}'`, (e3, r3) => {
    // console.log(e3, r3);
    if (e3) {
      res.send({
        code: 205,
        success: false,
        msg: '获取出租屋资讯失败'
      })
    }
    else {
      res.send({
        code: 200,
        success: true,
        msg: '获取当前出租屋资讯',
        data: r3
      })
    }
  })
})
router.get('/getHouseList', (req, res) => {        // 出租屋list
  let { AreaID } = req.query
  // console.log(req.query);
  connection.query(`select HouseNumber,Landlord_ID,IsCurrent,AreaID from website_landlord where AreaID = '${AreaID}'`, (e, r) => {
    // console.log(e,r);
    res.send({
      code: 200,
      success: true,
      data: r,
      msg: '获取出租屋list成功'
    })
  })
})
router.get('/getHouseInfoByID', (req, res) => {         // 出租资讯
  let { ID } = req.query
  // console.log(req.query);
  connection.query(`select * from website_landlord where Landlord_ID = '${ID}'`, (e, r) => {
    // console.log(e, r);
    if (r.length > 0) {
      res.send({
        code: 200,
        success: true,
        msg: '成功获取出租资讯',
        data: r
      })
    } else {
      res.send({
        code: 205,
        success: false,
        msg: '获取出租资讯失败',
        data: r
      })
    }
  })
})
router.post('/ModifyHouseInfo', (req, res) => {       // 修改 
  let { No, HouseNumber, Contact, LandlordName, More, Brief } = req.body.form
  // console.log(No, HouseNumber, Contact, LandlordName, More, Brief);
  connection.query(`update website_landlord set HouseNumber='${HouseNumber}',Contact='${Contact}',LandlordName='${LandlordName}',Brief='${Brief}',More='${More}' where No='${No}'`, (e1, r1) => {
    // console.log(e1, r1);
    if (r1.affectedRows > 0) {
      res.send({
        code: 200,
        success: true,
        msg: '成功修改出租屋资讯'
      })
    } else {
      res.send({
        code: 205,
        success: false,
        msg: '修改失败'
      })
    }
  })
})
router.post('/Cover', (req, res) => {
  // console.log(req.body);
  let { url, ID, coverSeq } = req.body
  connection.query(`update website_landlord set ${coverSeq}='${url}' where Landlord_ID ='${ID}'`, (e, r) => {
    // console.log(e, r);
    if (r.affectedRows > 0) {
      res.send({
        code: 200,
        success: true,
        msg: `成功上传图片${coverSeq}`
      })
    } else {
      res.send({
        code: 205,
        success: false,
        msg: `上传失败`
      })
    }
  })
})
router.get('/roomtypeList', (req, res) => {          // 房型列表
  // console.log(req.query);
  let { tableName } = req.query
  connection.query('select * from `' + tableName + '`', (e, r) => {
    // console.log(e, r);
    if (r.length > 0) {
      res.send({
        code: 200,
        success: true,
        msg: `获取${tableName}房型列表`,
        data: r,
      });
    } else {
      res.send({
        code: 205,
        success: false,
        msg: `获取${tableName}房型列表失败`,
        data: r,
      });
    }
  })
})



module.exports = router;