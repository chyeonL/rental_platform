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
  let { tableName } = req.query
  connection.query('select * from `' + tableName + '`', (e, r) => {
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

// 预约
router.post('/newBooking', (req, res) => {
  let { Staff_ID, Area, Landlord_ID, Landlord_Name, BookingStatus, Name, Contact, Gender, Time, Roomtype, Requirement, Note } = req.body
  connection.query(`insert into booking(Staff_ID, Area, Landlord_ID, Landlord_Name, BookingStatus, Name, Contact, Gender, Time, Roomtype, Requirement) values('${Staff_ID}', '${Area}', '${Landlord_ID}', '${Landlord_Name}', '${BookingStatus}', '${Name}', '${Contact}', '${Gender}', '${Time}', '${Roomtype}', '${Requirement}')`, (e, r) => {
    if (r.affectedRows > 0) {
      res.send({
        code: 200,
        success: true,
        msg: `${Name}成功预约`,
        data: r.insertId
      })
    } else {
      res.send({
        code: 205,
        success: false,
        msg: `${Name}预约失败`
      })
    }
  })
})
router.get('/allBooking', (req, res) => {
  let { pageNo, Landlord_ID } = req.query
  let pageSize = 5;
  connection.query('select * from booking where Landlord_ID="' + Landlord_ID + '"', (e, r) => {
    let n = (pageNo - 1) * pageSize;
    if (r.length > 0) {
      connection.query(
        'select * from booking where Landlord_ID="' + Landlord_ID + '" order by No limit ' + n + ', ' + pageSize,
        (e, r1) => {
          res.send({
            code: 200,
            success: true,
            msg: `获取所有访客预约`,
            data: r1,
            total: r.length,
            allData: r,
            pageSize,
            pageNo,
          });
        }
      );
    } else {
      res.send({
        code: 203,
        success: true,
        msg: `没有预约`,
        total: 0,
        pageSize,
        pageNo,
      });
    }
  })
})
router.get('/deleteBooking', (req, res) => {       // 删除
  let { No } = req.query
  connection.query('delete from booking where No = "' + No + '"', (e, r) => {
    if (r.affectedRows > 0) {
      res.send({
        code: 200,
        success: true,
        msg: `成功删除${No} 预约记录 `,
      });
    } else {
      res.send({
        code: 205,
        success: false,
        msg: "删除失败",
      });
    }
  })
})
router.get("/searchBooking", (req, res) => {           // 搜索
  console.log(req.query);
  let { Landlord_ID, keywords, pageNo, BookingStatus } = req.query
  let pageSize = 5;
  let n = (pageNo - 1) * pageSize;
  let sql1 = ''
  let sql2 = ''
  if (BookingStatus === '') {
    sql1 =
      "select * from booking where Landlord_ID='" + Landlord_ID + "' and concat(`BookingStatus`,`No`,`Roomtype`,`Name`,`Requirement`,`Gender`) like '%" +
      keywords +
      "%'";
    sql2 =
      "select * from booking where Landlord_ID='" + Landlord_ID + "' and concat(`BookingStatus`,`No`,`Roomtype`,`Name`,`Requirement`,`Gender`) like '%" +
      keywords +
      "%' limit " +
      n +
      "," +
      pageSize;
  } else {
    sql1 =
      "select * from booking where Landlord_ID='" + Landlord_ID + "' and BookingStatus='" + BookingStatus + "' and concat(`BookingStatus`,`No`,`Roomtype`,`Name`,`Requirement`,`Gender`) like '%" +
      keywords +
      "%'";
    sql2 =
      "select * from booking where Landlord_ID='" + Landlord_ID + "' and BookingStatus='" + BookingStatus + "' and concat(`BookingStatus`,`No`,`Roomtype`,`Name`,`Requirement`,`Gender`) like '%" +
      keywords +
      "%' limit " +
      n +
      "," +
      pageSize;
  }
  connection.query(sql1, (e0, r0) => {
    if (r0.length > 0) {
      connection.query(sql2, (e1, r1) => {
        res.send({
          code: 200,
          msg: `模糊搜索访客预约`,
          success: true,
          data: r1,
          allData: r0,
          total: r0.length,
          pageNo,
          pageSize,
        });
      });
    } else {
      res.send({
        code: 205,
        msg: `暂无访客预约`,
        success: false,
        data: [],
        allData: [],
        pageNo: 1,
        pageSize: 5,
        total: 0,
      });
    }
  });
});
router.get('/detailBooking', (req, res) => {       // 获取详情
  let { No } = req.query
  connection.query('select * from booking where No = "' + No + '"', (e, r) => {
    res.send({
      code: 200,
      success: true,
      msg: `获取${No} 预约记录`,
      data: r
    })
  })
})
router.post('/updateBookingStatus', (req, res) => {
  let { No, BookingStatus } = req.body
  connection.query(`update booking set BookingStatus='${BookingStatus}' where No = ${No}`, (e, r) => {
    if (r.affectedRows > 0) {
      res.send({
        code: 200,
        success: true,
        msg: `成功修改${No}预约状态`
      })
    } else {
      res.send({
        code: 205,
        success: false,
        msg: `修改${No}预约状态失败`
      })
    }
  })
})
router.get('/toBeConfirm', (req, res) => {
  let { Landlord_ID } = req.query
  connection.query('select * from booking where Landlord_ID="' + Landlord_ID + '" and BookingStatus="提交预约"', (e, r) => {
    if (r.length > 0) {
      res.send({
        code: 200,
        success: true,
        msg: '查询待确认的预约访客数目',
        data: r.length
      })
    } else {
      res.send({
        code: 200,
        success: true,
        msg: '没有待确认的预约访客数目',
        data: 0
      })
    }
  })
})
router.get('/viewHistory', (req, res) => {
  let { pageNo, Name, Contact } = req.query
  let pageSize = 5;
  connection.query('select * from booking where Contact="' + Contact + '" and Name="' + Name + '"', (e, r) => {
    let n = (pageNo - 1) * pageSize;
    if (r.length > 0) {
      connection.query(
        'select * from booking where Contact="' + Contact + '" and Name="' + Name + '" order by No limit ' + n + ', ' + pageSize,
        (e, r1) => {
          res.send({
            code: 200,
            success: true,
            msg: `获取预约历史`,
            data: r1,
            total: r.length,
            allData: r,
            pageSize,
            pageNo,
          });
        }
      );
    } else {
      res.send({
        code: 203,
        success: true,
        msg: `没有预约记录`,
        total: 0,
        pageSize,
        pageNo,
      });
    }
  })
})
router.post('/rescheduleBooking', (req, res) => {
  let { No, Time } = req.body
  connection.query(`update booking set Time='${Time}' where No = ${No}`, (e, r) => {
    if (r.affectedRows > 0) {
      res.send({
        code: 200,
        success: true,
        msg: `${No}成功修改预约时间`
      })
    } else {
      res.send({
        code: 205,
        success: false,
        msg: `修改时间失败`
      })
    }
  })
})


module.exports = router;