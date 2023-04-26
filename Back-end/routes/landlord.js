var express = require("express");
var router = express.Router();
var connection = require("../database/connection");

// 判断出租状态--修改房型表
var updateRoomtype = function (Original_RentStatus, RentStatus, tableName_roomtype, RoomType) {
  let AvailableRoomsQuantity
  let status
  if (Original_RentStatus === RentStatus) return
  else {
    connection.query('select AvailableRoomsQuantity from `' + tableName_roomtype + '`  where Type = "' + RoomType + '"', (e1, r1) => {
      if (Original_RentStatus === '已出租' && RentStatus === '未出租')    // 出租状态   未出租--已出租
      { AvailableRoomsQuantity = r1[0].AvailableRoomsQuantity + 1; status = '已出租--未出租' }
      else if (Original_RentStatus === '未出租' && RentStatus === '已出租')    // 出租状态   已出租--未出租
      { AvailableRoomsQuantity = r1[0].AvailableRoomsQuantity - 1; status = '未出租--已出租' }
      connection.query('update `' + tableName_roomtype + '` set AvailableRoomsQuantity="' + AvailableRoomsQuantity + '" where Type = "' + RoomType + '"', (e2, r2) => {
        // console.log(e2,r2);
        if (r2.affectedRows > 0) {
          console.log(`${status} 修改 可出租房间数量 成功`);
        } else {
          console.log(`${status}  修改 可出租房间数 失败`);
        }
      })
    })
  }
}
// 新增 或 修改 租客记录
var TenantRecordHandler = function (tableName_tenant, ContractNo, RoomNumber, Name, ID, Tel, StartDate, Term) {
  connection.query('select * from `' + tableName_tenant + '` where ID = "' + ID + '"', (e, r) => {
    if (r && r.length > 0) {
      connection.query('update `' + tableName_tenant + '` set Status="待完善",ContractNo="' + ContractNo + '",RoomNumber="' + RoomNumber + '",Name="' + Name + '",Tel="' + Tel + '",StartDate="' + StartDate + '",Term="' + Term + '",ContractStage="租约中" where  ID = "' + ID + '"', (e1, r1) => {
        // console.log(e1, r1);
        if (r1.affectedRows > 0) { console.log(`${tableName_tenant}表 修改相同${ID}的租客记录`); return true }
        else { console.log(`${tableName_tenant}表 修改失败`); return false }
      })
    }
    else {
      connection.query('insert into `' + tableName_tenant + '`(Status,ContractNo,RoomNumber,Name,ID,Tel,StartDate,Term,ContractStage,ReportStatus) values("待完善","' + ContractNo + '","' + RoomNumber + '","' + Name + '","' + ID + '","' + Tel + '","' + StartDate + '","' + Term + '","租约中","未报备")', (e1, r1) => {
        // console.log(e1, r1);
        if (r1.affectedRows > 0) { console.log(`${tableName_tenant}表 新增${ID}租客成功`); return true }
        else { console.log(`${tableName_tenant}表 新增失败`); return false }
      })
    }
  })
}
// 自动新增 租金记录
var NewRentRecord = function (tableName_rent, Month, ContractNo, RoomNumber, ID, Name, CollectionDate, MonthlyRent, HygieneFee, NetworkFee, UnitWaterFee, UnitElectrictyFee) {
  connection.query('insert into `' + tableName_rent + '`(Stage,Status,Month, ContractNo, RoomNumber, ID, Name, CollectionDate, MonthlyRent, HygieneFee, NetworkFee, UnitWaterFee, UnitElectrictyFee,ContractStage,WaterMeterDegree,ElectricityMeterDegree) values("未收","待完善","' + Month + '","' + ContractNo + '","' + RoomNumber + '","' + ID + '","' + Name + '","' + CollectionDate + '","' + MonthlyRent + '","' + HygieneFee + '","' + NetworkFee + '","' + UnitWaterFee + '","' + UnitElectrictyFee + '","租约中","0","0")', (e1, r1) => {
    // console.log(e1, r1);
    if (r1.affectedRows > 0) { console.log(`${tableName_rent}表 新增${ID}租金记录成功`); return true }
    else { console.log(`${tableName_rent}表 新增失败`); return false }
  })
}

// 首页
router.get('/getIncompleteTenant', (req, res) => {    // 顶部待完善租户记录
  let { tableName } = req.query
  connection.query('select No from `' + tableName + '` where Status="待完善" and ContractStage="租约中"', (e, r) => {
    // console.log(e, r);
    if (r) {
      if (r.length > 0) {
        res.send({
          code: 200,
          success: true,
          msg: '查询待完善的租户信息数目',
          data: r.length
        })
      } else {
        res.send({
          code: 200,
          success: true,
          msg: '没有待完善的租户信息',
          data: 0
        })
      }
    } else {
      res.send({
        code: 205,
        success: false,
        msg: '查询待完善的租户信息失败'
      })
    }
  })
})
router.get('/getIncompleteRent', (req, res) => {      // 顶部待完善 月租记录
  let { tableName } = req.query
  connection.query('select No from `' + tableName + '` where Status="待完善" and ContractStage="租约中"', (e, r) => {
    // console.log(e, r);
    if (r) {
      if (r.length > 0) {
        res.send({
          code: 200,
          success: true,
          msg: '查询待完善的月租记录数目',
          data: r.length
        })
      } else {
        res.send({
          code: 200,
          success: true,
          msg: '没有待完善的月租记录',
          data: 0
        })
      }
    } else {
      res.send({
        code: 205,
        success: false,
        msg: '查询待完善的月租记录失败'
      })
    }
  })
})
router.get('/rentedOut', (req, res) => {              // 已出租的房间数量
  // console.log(req.query);
  let { tableName } = req.query
  connection.query('select No,RoomType from `' + tableName + '`', (e, r0) => {
    let all = r0.length
    connection.query('select No,RoomType from `' + tableName + '` where RentStatus="已出租"', (e, r1) => {
      // console.log(e, r1);
      if (r1.length > 0) {
        res.send({
          code: 200,
          success: true,
          msg: `${tableName}目前已出租的房间数量为${r1.length}`,
          data: r1.length,
          all: all
        })
      } else {
        res.send({
          code: 203,
          success: true,
          msg: `${tableName}目前没有已出租的房间`,
          data: 0,
          all: all
        });
      }
    })
  })
})
router.get('/roomtypeBarChart', (req, res) => {       // 已出租房间的房型 柱状图
  // console.log(req.query);
  let { tableName } = req.query
  connection.query('select Type,Amount,AvailableRoomsQuantity from `' + tableName + '`', (e, r) => {
    // console.log(e, r);
    var dataValue = []
    var dataName = []
    var data = []
    r.map(item => {
      let obj = { name: '', value: '' }
      obj.name = item.Type
      obj.value = item.Amount - item.AvailableRoomsQuantity
      data.push(obj)
      dataValue.push(obj.value)
      dataName.push(item.Type)
    })
    res.send({
      code: 200,
      success: true,
      msg: '已出租房间的房型占比',
      data,
      dataValue,
      dataName
    })
  })
})
router.get('/variousOpinions', (req, res) => {        //  我的意见 状态饼图
  // console.log(req.query);
  let { tableName, Landlord_ID } = req.query
  connection.query('select Status from `' + tableName + '` where Landlord_ID="' + Landlord_ID + '"', (e, r) => {
    // console.log(e, r);
    let data = [{ name: '等待反馈', value: 0 }, { name: '处理中', value: 0 }, { name: '接纳意见', value: 0 }, { name: '否决意见', value: 0 }]
    if (r.length > 0) {
      r.map(item => {
        data.map(v => {
          if (item.Status == v.name) {
            ++v.value
          }
        })
      })
      // console.log(data);
      res.send({
        code: 200,
        success: true,
        data
      })
    }
  })
})



// 房型
router.get('/allRoomType', (req, res) => {    // 获取   所有房型
  let pageSize = 5; // 页面默认展示 5 条数据，不可更改
  // console.log(req.query);
  let { pageNo, tableName } = req.query
  connection.query('select * from `' + tableName + '`', (e, r) => {
    // console.log(e, r);
    let n = (pageNo - 1) * pageSize;
    if (r.length > 0) {
      connection.query(
        'select * from `' + tableName + '` order by No limit ' + n + ', ' + pageSize,   // 从第n条数据开始，取pageSize条数据
        (e, r1) => {
          // console.log(e, r1);
          res.send({
            code: 200,
            success: true,
            msg: `获取 ${tableName} 的所有房型`,
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
        msg: "无房型",
        total: 0,
        pageSize,
        pageNo,
      });
    }
  })
})
router.post('/newRoomType', (req, res) => {    // 新增     房型
  console.log(req.body);
  let { tableName } = req.body
  let { Type, Amount, Furnishment, RoomNumber, Square, Price, MortgageCash, MortgageMethod, Picture, AvailableRoomsQuantity } = req.body.form
  connection.query('insert into `' + tableName + '`(Type, Amount, Furnishment, RoomNumber, Square, Price, MortgageCash, MortgageMethod,Picture,AvailableRoomsQuantity) values("' + Type + '","' + Amount + '","' + Furnishment + '","' + RoomNumber + '","' + Square + '","' + Price + '","' + MortgageCash + '","' + MortgageMethod + '","' + Picture + '","' + AvailableRoomsQuantity + '")', (e, r) => {
    console.log(e, r);
    res.send({
      code: 200,
      success: true,
      msg: `${tableName} 新增房型成功`
    })
  })
})
router.get('/DetailRoomType', (req, res) => {    // 获取   所有房型
  // console.log(req.query);
  let { No, tableName } = req.query
  connection.query('select * from `' + tableName + '` where No = "' + No + '"', (e, r) => {
    // console.log(e, r);
    res.send({
      code: 200,
      success: true,
      msg: `获取 ${tableName} 的 ${No} 房型`,
      data: r
    })
  })
})
router.post('/roomTypePicture', (req, res) => {     // 上传房型图片
  console.log(req.body);
  let { url, No, tableName } = req.body
  connection.query('update `' + tableName + '` set Picture="' + url + '" where No = "' + No + '"', (e, r) => {
    console.log(e, r);
    if (r.affectedRows > 0) {
      res.send({
        code: 200,
        success: true,
        msg: `成功上传房型图片 ${tableName}`
      })
    } else {
      res.send({
        code: 205,
        success: false,
        msg: `房型图片上传失败`
      })
    }
  })
})
router.post('/modifyRoomtype', (req, res) => {    // 修改 房型
  console.log(req.body);
  let { Type, Amount, RoomNumber, Furnishment, Square, Price, MortgageCash, MortgageMethod, AvailableRoomsQuantity, No } = req.body.form
  let { tableName } = req.body
  connection.query('update `' + tableName + '` set Type="' + Type + '",Amount="' + Amount + '",RoomNumber="' + RoomNumber + '",Furnishment="' + Furnishment + '",Square="' + Square + '",Price="' + Price + '",MortgageCash="' + MortgageCash + '",MortgageMethod="' + MortgageMethod + '",AvailableRoomsQuantity="' + AvailableRoomsQuantity + '" where No = "' + No + '"', (e, r) => {
    console.log(e, r);
    if (r.affectedRows > 0) {
      res.send({
        code: 200,
        success: true,
        msg: `成功修改房型信息 ${tableName}`
      })
    } else {
      res.send({
        code: 205,
        success: false,
        msg: `修改失败`
      })
    }
  })
})
router.get('/deleteRoomtype', (req, res) => {       // 删除
  console.log(req.query);
  let { tableName, No } = req.query
  connection.query('delete from `' + tableName + '` where No = "' + No + '"', (e, r) => {
    console.log(e, r);
    if (r.affectedRows > 0) {
      res.send({
        code: 200,
        success: true,
        msg: "删除房型成功",
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
router.get("/searchRoomtype", (req, res) => {  // 搜索
  let searchParams = req.query.keywords;
  let pageNo = req.query.pageNo;
  let pageSize = 5;
  let n = (pageNo - 1) * pageSize;
  let tableName = req.query.tableName
  console.log(req.query);
  let sql1 =
    "select * from `" + tableName + "` where concat(`Type`,`Furnishment`,`RoomNumber`,`Square`,`No`,`MortgageCash`,`MortgageMethod`) like '%" +
    searchParams +
    "%'";
  let sql2 =
    "select * from `" + tableName + "` where concat(`Type`,`Furnishment`,`RoomNumber`,`Square`,`No`,`MortgageCash`,`MortgageMethod`) like '%" +
    searchParams +
    "%' limit " +
    n +
    "," +
    pageSize;
  console.log(sql1);
  console.log(sql2);
  connection.query(sql1, (e0, r0) => {
    // 能搜到相关数据
    console.log(e0, r0);
    if (r0.length > 0) {
      connection.query(sql2, (e1, r1) => {
        console.log(e1, r1);
        res.send({
          code: 200,
          msg: "模糊搜索房型",
          success: true,
          data: r1,
          allData: r0,
          total: r0.length,
          pageNo,
          pageSize,
        });
      });
    } else {
      // 搜不到
      res.send({
        code: 205,
        msg: "暂无相关房型",
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


// 房间      
router.get('/allRoom', (req, res) => {      // 所有房间
  let pageSize = 5; // 页面默认展示 5 条数据，不可更改
  // console.log(req.query);
  let { pageNo, tableName } = req.query
  connection.query('select * from `' + tableName + '`', (e, r) => {
    // console.log(e, r);
    let n = (pageNo - 1) * pageSize;
    if (r.length > 0) {
      connection.query(
        'select * from `' + tableName + '` order by RoomNumber limit ' + n + ', ' + pageSize,   // 从第n条数据开始，取pageSize条数据
        (e, r1) => {
          // console.log(e, r1);
          res.send({
            code: 200,
            success: true,
            msg: `获取 ${tableName} 出租屋的所有房间`,
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
        msg: "没有出租房间",
        total: 0,
        pageSize,
        pageNo,
      });
    }
  })
})
router.post('/newRoom', (req, res) => {    // 新增  房间
  // console.log(req.body);
  let { tableName_room, tableName_roomtype } = req.body
  let { RoomType, Rent, RoomNumber, Square, IsFurnished, MortgageCash, MortgageMethod, MinimunPeriod, RentStatus, Note } = req.body.form
  connection.query('insert into `' + tableName_room + '`( RoomType, Rent, RoomNumber, Square, IsFurnished, MortgageCash,MortgageMethod,MinimunPeriod ,RentStatus,ContractNo,TenantName,TenantIDCard,Note) values("' + RoomType + '","' + Rent + '","' + RoomNumber + '","' + Square + '","' + IsFurnished + '","' + MortgageCash + '","' + MortgageMethod + '","' + MinimunPeriod + '","' + RentStatus + '","","","","' + Note + '")', (e, r) => {
    // console.log(e, r);
    if (r.affectedRows > 0) {
      connection.query('select * from `' + tableName_roomtype + '` where Type="' + RoomType + '"', (e0, r0) => {
        // console.log(e0,r0);
        let { Amount, AvailableRoomsQuantity, No } = r0[0]
        let RoomNumber_type = r0[0].RoomNumber
        let newAmount = Amount + 1
        let newAvailableRoomsQuantity = AvailableRoomsQuantity + 1
        let newV = RoomNumber_type.length == 0 ? RoomNumber : RoomNumber_type + ',' + RoomNumber
        console.log(newAmount, newAvailableRoomsQuantity, newV);
        connection.query('update `' + tableName_roomtype + '` set Amount="' + newAmount + '",AvailableRoomsQuantity="' + newAvailableRoomsQuantity + '",RoomNumber="' + newV + '" where No = "' + No + '"', (e2, r2) => {
          // console.log(e2,r2);
          if (r2.affectedRows > 0) {
            res.send({
              code: 200,
              success: true,
              msg: `${tableName_room} 新增房间成功，自动更新也成功`
            })
          } else {
            res.send({
              code: 205,
              success: false,
              msg: `${tableName_room} 新增房间成功但自动更新房型失败`
            })
          }
        })
      })
    } else {
      res.send({
        code: 205,
        success: false,
        msg: `${tableName} 新增失败`
      })
    }
  })
})
router.get('/typeList', (req, res) => {       // 房型列表 and 按押方式
  // console.log(req);
  let { tableName } = req.query
  connection.query('select MortgageMethod,Price,Type from `' + tableName + '`', (e0, r0) => {
    // console.log(e0, r0);
    res.send({
      code: 200,
      success: true,
      msg: `获取${tableName}的所有房型`,
      data: r0
    })
  })
})
router.get('/contractList', (req, res) => {       // 合同列表 and  租客姓名、身份证
  // console.log(req.query);
  let { tableName } = req.query
  connection.query('select * from `' + tableName + '` where Stage="租约中" ', (e0, r0) => {
    // console.log(e0, r0);
    res.send({
      code: 200,
      success: true,
      msg: `获取${tableName} 所有合同`,
      data: r0
    })
  })
})
router.get('/deleteRoom', (req, res) => {       // 删除
  // console.log(req.query);
  let { tableName_room, tableName_roomtype, No, RoomType, RoomNumber } = req.query
  connection.query('delete from `' + tableName_room + '` where No = "' + No + '"', (e, r) => {
    // console.log(e, r);
    if (r.affectedRows > 0) {
      connection.query('select * from `' + tableName_roomtype + '` where Type="' + RoomType + '"', (e0, r0) => {
        // console.log(e0,r0);
        let { Amount, AvailableRoomsQuantity, No } = r0[0]
        let RoomNumber_type = r0[0].RoomNumber
        let newAmount = Amount == 0 ? 0 : Amount - 1
        let newAvailableRoomsQuantity = AvailableRoomsQuantity == 0 ? 0 : AvailableRoomsQuantity - 1
        var arr = []
        RoomNumber_type.split(',').map((item, index) => {
          if (item != RoomNumber) arr.push(item)
        })
        var newV = arr.join(',')
        // console.log(newAmount, newAvailableRoomsQuantity, newV);
        connection.query('update `' + tableName_roomtype + '` set Amount="' + newAmount + '",AvailableRoomsQuantity="' + newAvailableRoomsQuantity + '",RoomNumber="' + newV + '" where No = "' + No + '"', (e2, r2) => {
          // console.log(e2,r2);
          if (r2.affectedRows > 0) {
            res.send({
              code: 200,
              success: true,
              msg: `${tableName_room} 删除房间成功，自动更新也成功`
            })
          } else {
            res.send({
              code: 205,
              success: false,
              msg: `${tableName_room} 删除成功，但自动更新房型失败`
            })
          }
        })
      })
      // res.send({
      //   code: 200,
      //   success: true,
      //   msg: "删除房间成功",
      // });
    } else {
      res.send({
        code: 205,
        success: false,
        msg: "删除失败",
      });
    }
  })
})
router.get("/searchRoom", (req, res) => {       // 搜索
  let { RentStatus, tableName, keywords, pageNo } = req.query
  let pageSize = 5;
  let n = (pageNo - 1) * pageSize;
  let sql1 = ''
  let sql2 = ''
  if (RentStatus === '') {
    sql1 =
      "select * from `" + tableName + "` where concat(`RoomNumber`,`RoomType`,`Rent`,`No`,MinimunPeriod) like '%" +
      keywords +
      "%'";
    sql2 =
      "select * from `" + tableName + "` where concat(`RoomNumber`,`RoomType`,`Rent`,`No`,MinimunPeriod) like '%" +
      keywords +
      "%' limit " +
      n +
      "," +
      pageSize;
  } else {
    sql1 =
      "select * from `" + tableName + "` where RentStatus='" + RentStatus + "' and concat(`RoomNumber`,`RoomType`,`Rent`,`No`,MinimunPeriod) like '%" +
      keywords +
      "%'";
    sql2 =
      "select * from `" + tableName + "` where RentStatus='" + RentStatus + "' and concat(`RoomNumber`,`RoomType`,`Rent`,`No`,MinimunPeriod) like '%" +
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
          msg: "模糊搜索房间",
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
        msg: "暂无相关房间",
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
router.get('/detailRoom', (req, res) => {    // 获取
  // console.log(req.query);
  let { No, tableName } = req.query
  connection.query('select * from `' + tableName + '` where No = "' + No + '"', (e, r) => {
    // console.log(e, r);
    res.send({
      code: 200,
      success: true,
      msg: `获取 ${tableName} 的 ${No} 房间`,
      data: r
    })
  })
})
router.post('/modifyRoom', (req, res) => {       // 修改 
  // console.log(req.body);
  let { RoomType, Rent, RoomNumber, Square, IsFurnished, MortgageCash, MinimunPeriod, RentStatus, ContractNo, TenantName, TenantIDCard, Note, No } = req.body.form
  let { tableName_room, tableName_roomtype } = req.body
  connection.query('select RoomNumber,RentStatus,No from `' + tableName_room + '` where No = "' + No + '"', (e, r) => {
    // console.log(e, r);
    let Original_RoomNumber = r[0].RoomNumber   // 原来的 房间号
    let Original_RentStatus = r[0].RentStatus   // 原来的 出租状态
    updateRoomtype(Original_RentStatus, RentStatus, tableName_roomtype, RoomType)   // 判断出租状态--修改房型表
    if (Original_RoomNumber != RoomNumber) {         // 房间号 判断变更
      connection.query('select RoomNumber from `' + tableName_roomtype + '`  where Type = "' + RoomType + '"', (e1, r1) => {
        let RoomNumber_type = r1[0].RoomNumber
        var arr = []
        RoomNumber_type.split(',').map((item, index) => {
          if (item != Original_RoomNumber) {
            arr.push(item)
          } else {
            arr.push(RoomNumber)
          }
        })
        var newV = arr.join(',')
        // console.log(newV);
        connection.query('update `' + tableName_roomtype + '` set RoomNumber="' + newV + '" where Type = "' + RoomType + '"', (e2, r2) => {
          // console.log(e2,r2);
          if (r2.affectedRows > 0) {
            console.log(`${tableName_roomtype}修改 房间号 成功`);
          } else {
            console.log(`${tableName_roomtype}修改 房间号 失败`);
          }
        })
      })
    }
    // 最后修改
    connection.query('update `' + tableName_room + '` set RoomType="' + RoomType + '",Rent="' + Rent + '",RoomNumber="' + RoomNumber + '",IsFurnished="' + IsFurnished + '",Square="' + Square + '",MinimunPeriod="' + MinimunPeriod + '",MortgageCash="' + MortgageCash + '",RentStatus="' + RentStatus + '",ContractNo="' + ContractNo + '",TenantName="' + TenantName + '",TenantIDCard="' + TenantIDCard + '",Note="' + Note + '" where No = "' + No + '"', (ee, rr) => {
      if (rr.affectedRows > 0) {
        res.send({
          code: 200,
          success: true,
          msg: `修改${tableName_room} ${No} 房间信息`
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


// 上报意见 
router.get('/getMyOpinion', (req, res) => {           //  获取我的意见
  // console.log(req.query);
  let { pageNo, tableName, Landlord_ID } = req.query
  let pageSize = 5; // 页面默认展示 5 条数据，不可更改
  connection.query('select * from `' + tableName + '` where Landlord_ID = "' + Landlord_ID + '"', (e, r) => {
    // console.log(e, r);
    let n = (pageNo - 1) * pageSize;
    if (r.length > 0) {
      connection.query(
        'select * from `' + tableName + '` where Landlord_ID = "' + Landlord_ID + '" order by No limit ' + n + ', ' + pageSize,   // 从第n条数据开始，取pageSize条数据
        (e, r1) => {
          console.log(e, r1);
          res.send({
            code: 200,
            success: true,
            msg: `获取 ${tableName}  ${Landlord_ID} 的意见`,
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
        msg: `没有 ${tableName}  ${Landlord_ID} 的相关意见`,
        total: 0,
        pageSize,
        pageNo,
      });
    }
  })
})
router.post('/newMyOpinion', (req, res) => {         //   新增意见
  // console.log(req.body);
  let { tableName } = req.body
  let { Title, Category, Detail, LandlordName, Landlord_ID, SubmitTime, Status, StaffName, Staff_ID, Area, AreaID } = req.body.form
  let insert = 'insert into `' + tableName + '`(  Title, Category, Detail, LandlordName, Landlord_ID, SubmitTime, Status, StaffName, Staff_ID, Area, AreaID ) values("' + Title + '","' + Category + '","' + Detail + '","' + LandlordName + '","' + Landlord_ID + '","' + SubmitTime + '","' + Status + '","' + StaffName + '","' + Staff_ID + '","' + Area + '","' + AreaID + '")'
  // console.log(insert);
  connection.query(insert, (e, r) => {
    // console.log(e, r);
    res.send({
      code: 200,
      success: true,
      msg: `${tableName} 新增意见成功`
    })
  })
})
router.get('/deleteMyOpinion', (req, res) => {       // 删除
  // console.log(req.query);
  let { tableName, No } = req.query
  connection.query('delete from `' + tableName + '` where No = "' + No + '"', (e, r) => {
    // console.log(e, r);
    if (r.affectedRows > 0) {
      res.send({
        code: 200,
        success: true,
        msg: "成功删除意见",
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
router.post('/modifyMyOpinion', (req, res) => {      // 修改  
  // console.log(req.body);
  let { Title, Category, Detail, Status, No } = req.body.form
  let { tableName } = req.body
  connection.query('update `' + tableName + '` set Title="' + Title + '",Category="' + Category + '",Detail="' + Detail + '",Status="' + Status + '" where No = "' + No + '"', (e, r) => {
    // console.log(e, r);
    if (r.affectedRows > 0) {
      res.send({
        code: 200,
        success: true,
        msg: `成功修改我的意见 ${tableName}`
      })
    } else {
      res.send({
        code: 205,
        success: false,
        msg: `修改失败`
      })
    }
  })
})
router.get("/searchMyOpinion", (req, res) => {       // 搜索
  // console.log(req.query);
  let { tableName, keywords, pageNo, Status } = req.query
  let pageSize = 5;
  let n = (pageNo - 1) * pageSize;
  let sql1 = ''
  let sql2 = ''
  if (Status === '') {
    sql1 =
      "select * from `" + tableName + "` where concat(`Title`,`Category`,`Detail`,`LandlordName`,`No`,`Response`) like '%" +
      keywords +
      "%'";
    sql2 =
      "select * from `" + tableName + "` where concat(`Title`,`Category`,`Detail`,`LandlordName`,`No`,`Response`) like '%" +
      keywords +
      "%' limit " +
      n +
      "," +
      pageSize;
  } else {
    sql1 =
      "select * from `" + tableName + "` where Status='" + Status + "' and concat(`Title`,`Category`,`Detail`,`LandlordName`,`No`,`Response`) like '%" +
      keywords +
      "%'";
    sql2 =
      "select * from `" + tableName + "` where Status='" + Status + "' and concat(`Title`,`Category`,`Detail`,`LandlordName`,`No`,`Response`) like '%" +
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
          msg: "模糊搜索我的意见",
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
        msg: "暂无相关意见",
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
router.get('/detailMyOpinion', (req, res) => {      // 获取详情
  // console.log(req.query);
  let { No, tableName } = req.query
  connection.query('select * from `' + tableName + '` where No = "' + No + '"', (e, r) => {
    // console.log(e, r);
    res.send({
      code: 200,
      success: true,
      msg: `获取 ${tableName} 的 ${No} 意见`,
      data: r
    })
  })
})


// 合同
router.get('/allContracts', (req, res) => {             //  所有
  // console.log(req.query);
  let { pageNo, ID } = req.query
  let tableName = 'contract_' + ID
  let pageSize = 5; // 页面默认展示 5 条数据，不可更改
  connection.query('select * from `' + tableName + '`', (e, r) => {
    // console.log(e, r);
    let n = (pageNo - 1) * pageSize;
    if (r.length > 0) {
      connection.query(
        'select * from `' + tableName + '` order by No limit ' + n + ', ' + pageSize,   // 从第n条数据开始，取pageSize条数据
        (e, r1) => {
          // console.log(e, r1);
          res.send({
            code: 200,
            success: true,
            msg: `获取 ${tableName} 所有合同`,
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
        msg: `${tableName} 没有合同`,
        total: 0,
        pageSize,
        pageNo,
      });
    }
  })
})
router.post('/newContract', (req, res) => {         //   新增
  // console.log(req.body);
  let { ID } = req.body
  let tableName_contract = 'contract_' + ID
  let tableName_room = 'room_' + ID
  let tableName_roomtype = 'roomtype_' + ID
  let tableName_tenant = 'tenant_' + ID
  let tableName_rent = 'rent_' + ID
  let { Room, RoomType, TenantID, TenantName, Population, StartDate, Term, Rent, MortgageCash, MortgageMethod, CollectionDate, UnitWaterFee, UnitElectricityCharge, PublicCleanFee, NetworkFee, Stage, Tel, Note } = req.body.form
  let insert = 'insert into `' + tableName_contract + '`(  Room, RoomType,TenantID, TenantName, Population, StartDate, Term, Rent, MortgageCash, MortgageMethod, CollectionDate, UnitWaterFee, UnitElectricityCharge,PublicCleanFee, NetworkFee, Stage, Tel, Note  ) values("' + Room + '","' + RoomType + '","' + TenantID + '","' + TenantName + '","' + Population + '","' + StartDate + '","' + Term + '","' + Rent + '","' + MortgageCash + '","' + MortgageMethod + '","' + CollectionDate + '","' + UnitWaterFee + '","' + UnitElectricityCharge + '","' + PublicCleanFee + '","' + NetworkFee + '","' + Stage + '","' + Tel + '","' + Note + '")'
  // console.log(insert);
  // 先插入记录，成功后 ---- 修改对应房间号的出租状态 --- 修改房型表对应房型的可出租数量
  connection.query(insert, (e0, r0) => {
    // console.log(r0.insertId);   // 返回的主键
    if (r0.affectedRows > 0) {
      // 用编号修改  对应房间信息
      connection.query('update `' + tableName_room + '` set RentStatus="已出租",ContractNo = "' + r0.insertId + '",TenantName = "' + TenantName + '",TenantIDCard = "' + TenantID + '" where RoomNumber = "' + Room + '"', (e, r) => {
        // 修改 对应房型信息
        updateRoomtype('未出租', '已出租', tableName_roomtype, RoomType)
        // 新增 或 修改 租客记录
        TenantRecordHandler(tableName_tenant, r0.insertId, Room, TenantName, TenantID, Tel, StartDate, Term)
        // 新增租金记录
        let Month = StartDate.slice(5, 7) + '月'
        if (Month.startsWith('0'))
          Month = Month.slice(1)
        NewRentRecord(tableName_rent, Month, r0.insertId, Room, TenantID, TenantName, CollectionDate, Rent, PublicCleanFee, NetworkFee, UnitWaterFee, UnitElectricityCharge)
        res.send({
          code: 200,
          success: true,
          msg: `${tableName_contract} 新增合同成功`
        })
      })
    }
  })
})
router.get('/deleteContract', (req, res) => {       // 删除合同
  // console.log(req.query);
  let { ID, No } = req.query
  let tableName_contract = 'contract_' + ID
  let tableName_tenant = 'tenant_' + ID
  let tableName_rent = 'rent_' + ID
  let updateValue = No + '(已删除)'
  connection.query('delete from `' + tableName_contract + '` where No = "' + No + '"', (e, r) => {
    // console.log(e, r);
    if (r.affectedRows > 0) {
      // 修改tenant 数据
      connection.query('update `' + tableName_tenant + '` set ContractNo = "' + updateValue + '",Status="X" where ContractNo = "' + No + '"', (e1, r1) => {
        if (r1.affectedRows > 0) {
          // 删除 rent记录
          connection.query('select  No from `' + tableName_rent + '` where ContractNo = "' + No + '"', (e2, r2) => {
            console.log(e2, r2);
            if (r2.length > 0) {
              var rowsArr = []
              r2.map(item => {
                rowsArr.push(item.No)
              })
              var rows = rowsArr.join(',')
              console.log(rows);
              connection.query('delete from `' + tableName_rent + '` where No in (' + rows + ')', (e3, r3) => {
                console.log(e3, r3);
                if (r3.affectedRows > 0) {
                  res.send({
                    code: 200,
                    success: true,
                    msg: "成功删除合同",
                  });
                }
              })
            } else {
              res.send({
                code: 200,
                success: true,
                msg: "成功删除合同",
              });
            }
          })
        }
      })
    } else {
      res.send({
        code: 205,
        success: false,
        msg: "删除失败",
      });
    }
  })
})
router.post('/terminateContract', (req, res) => {      // 终止合同 
  // console.log(req.body);
  let { ID, No, Room, RoomType } = req.body
  let tableName_contract = 'contract_' + ID
  let tableName_room = 'room_' + ID
  let tableName_roomtype = 'roomtype_' + ID
  let tableName_tenant = 'tenant_' + ID
  let tableName_rent = 'rent_' + ID
  // 1、修改合同状态
  connection.query('update `' + tableName_contract + '` set Stage="租约结束" where No="' + No + '"', (e1, r1) => {
    // 2、修改room表 -- RentStatus,ContractNo,TenantName.TenantIDCard（where 房间号）
    connection.query('update `' + tableName_room + '` set RentStatus="未出租",ContractNo="",TenantName="",TenantIDCard="" where RoomNumber="' + Room + '"', (e2, r2) => {
      // 3、修改roomtype表 --- AvailableRoomsQuantity（where 房型） -- 首先得获取这个房型的原可出租数量
      connection.query('select AvailableRoomsQuantity from `' + tableName_roomtype + '` where Type="' + RoomType + '"', (e31, r31) => {
        let AvailableRoomsQuantity = r31[0].AvailableRoomsQuantity + 1
        connection.query('update `' + tableName_roomtype + '` set AvailableRoomsQuantity="' + AvailableRoomsQuantity + '" where Type="' + RoomType + '"', (e32, r32) => {
          // 4、修改rent表 --- ContractStage （where 合同编号）
          connection.query('update `' + tableName_rent + '` set ContractStage="租约结束" where ContractNo="' + No + '"', (e4, r4) => {
            console.log(e4, r4);
            // 5、修改tenant表 -- ContractStage （where 合同编号）
            connection.query('update `' + tableName_tenant + '` set ContractStage="租约结束" where ContractNo="' + No + '"', (e4, r4) => {
              res.send({
                code: 200,
                success: true,
                msg: `终止合同 ${tableName_contract}的${No}合同`
              })
            })
          })
        })
      })
    })
  })
})
router.get("/searchContract", (req, res) => {       // 搜索
  // console.log(req.query);
  let { tableName, keywords, pageNo, Stage } = req.query
  let pageSize = 5;
  let n = (pageNo - 1) * pageSize;
  let sql1 = ''
  let sql2 = ''
  if (Stage === '') {
    sql1 =
      "select * from `" + tableName + "` where concat(`Room`,`TenantName`,`No`,`Term`) like '%" +
      keywords +
      "%'";
    sql2 =
      "select * from `" + tableName + "` where concat(`Room`,`TenantName`,`No`,`Term`) like '%" +
      keywords +
      "%' limit " +
      n +
      "," +
      pageSize;
  } else {
    sql1 =
      "select * from `" + tableName + "` where Stage='" + Stage + "' and concat(`Room`,`TenantName`,`No`,`Term`) like '%" +
      keywords +
      "%'";
    sql2 =
      "select * from `" + tableName + "` where Stage='" + Stage + "' and concat(`Room`,`TenantName`,`No`,`Term`) like '%" +
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
          msg: "模糊搜索合同",
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
        msg: "暂无相关合同",
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
router.get('/detailContract', (req, res) => {      // 获取详情
  // console.log(req.query);
  let { No, tableName } = req.query
  connection.query('select * from `' + tableName + '` where No = "' + No + '"', (e, r) => {
    // console.log(e, r);
    res.send({
      code: 200,
      success: true,
      msg: `获取 ${tableName} 的 ${No} 合同`,
      data: r
    })
  })
})
router.get('/getRoomList', (req, res) => {      // 获取未出租的房间列表
  // console.log(req.query);
  let { tableName } = req.query
  connection.query('select RoomNumber,RoomType,Rent,MortgageCash,MortgageMethod from `' + tableName + '` where RentStatus ="未出租"', (e, r) => {
    // console.log(e, r);
    if (r.length > 0) {
      res.send({
        code: 200,
        success: true,
        data: r,
        msg: `获取${tableName} 未出租的房间列表`
      })
    } else {
      res.send({
        code: 205,
        success: false,
        data: r,
        msg: `获取${tableName} 房间列表失败`
      })
    }
  })
})

// 租客
router.get('/allTenants', (req, res) => {
  let { pageNo, ID } = req.query
  let tableName = 'tenant_' + ID
  let pageSize = 5; // 页面默认展示 5 条数据，不可更改
  connection.query('select * from `' + tableName + '`', (e, r) => {
    let n = (pageNo - 1) * pageSize;
    if (r.length > 0) {
      connection.query(
        'select * from `' + tableName + '` order by No limit ' + n + ', ' + pageSize,   // 从第n条数据开始，取pageSize条数据
        (e, r1) => {
          res.send({
            code: 200,
            success: true,
            msg: `获取 ${tableName} 所有租客`,
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
        msg: `${tableName} 没有租客`,
        total: 0,
        pageSize,
        pageNo,
      });
    }
  })
})
router.get('/deleteTenant', (req, res) => {       // 删除
  // console.log(req.query);
  let { ID, No } = req.query
  let tableName_tenant = 'tenant_' + ID
  connection.query('delete from `' + tableName_tenant + '` where No = "' + No + '"', (e, r) => {
    if (r.affectedRows > 0) {
      res.send({
        code: 200,
        success: true,
        msg: `成功删除${tableName_tenant} 的${No} 月租记录 `,
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
router.get("/searchTenant", (req, res) => {           // 搜索
  let { tableName, keywords, pageNo, Status } = req.query
  let pageSize = 5;
  let n = (pageNo - 1) * pageSize;
  let sql1 = ''
  let sql2 = ''
  if (Status === '') {
    sql1 =
      "select * from `" + tableName + "` where concat(`ID`,`ContractNo`,`ContractStage`,`RoomNumber`,`Name`,`ReportStatus`) like '%" +
      keywords +
      "%'";
    sql2 =
      "select * from `" + tableName + "` where concat(`ID`,`ContractNo`,`ContractStage`,`RoomNumber`,`Name`,`ReportStatus`) like '%" +
      keywords +
      "%' limit " +
      n +
      "," +
      pageSize;
  } else {
    sql1 =
      "select * from `" + tableName + "` where Status='" + Status + "' and concat(`ID`,`ContractNo`,`ContractStage`,`RoomNumber`,`Name`,`ReportStatus`) like '%" +
      keywords +
      "%'";
    sql2 =
      "select * from `" + tableName + "` where Status='" + Status + "' and concat(`ID`,`ContractNo`,`ContractStage`,`RoomNumber`,`Name`,`ReportStatus`) like '%" +
      keywords +
      "%' limit " +
      n +
      "," +
      pageSize;
  }
  // console.log(sql1);
  // console.log(sql2);
  connection.query(sql1, (e0, r0) => {
    if (r0.length > 0) {
      connection.query(sql2, (e1, r1) => {
        res.send({
          code: 200,
          msg: `模糊搜索${tableName}租户表 ${keywords}`,
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
        msg: `暂无与${keywords}相关的租户记录`,
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
router.get('/detailTenant', (req, res) => {       // 获取详情
  let { No, tableName } = req.query
  connection.query('select * from `' + tableName + '` where No = "' + No + '"', (e, r) => {
    res.send({
      code: 200,
      success: true,
      msg: `获取 ${tableName} 的 ${No} 租户记录`,
      data: r
    })
  })
})
router.post('/modifyTenant', (req, res) => {
  // console.log(req.body);
  let { ID } = req.body
  let { No, Gender, Marriage, Origin, Note, ReportStatus, StartDate } = req.body.form
  let teantID = req.body.form.ID
  let tableName = 'tenant_' + ID
  // 先修改租户记录
  connection.query('update `' + tableName + '` set Gender="' + Gender + '",Marriage="' + Marriage + '",Origin="' + Origin + '",Note="' + Note + '",Status="√" where No = "' + No + '"', (e, r) => {
    // console.log(e, r);
    if (r.affectedRows > 0) {
      // 若 已报备，还需修改migrant表的记录
      if (ReportStatus == '√') {
        var a = 'update migrant set Gender="' + Gender + '",Marriage="' + Marriage + '",Origin="' + Origin + '",Note="' + Note + '" where StartDate = "' + StartDate + '"  and ID = "' + teantID + '"'
        // console.log(a);
        connection.query(a, (e1, r1) => {
          // console.log(e1, r1);
          if (r1.affectedRows > 0) {
            res.send({
              code: 200,
              success: true,
              msg: `修改${tableName} ${No} 租户信息 成功`
            })
          } else {
            res.send({
              code: 205,
              success: false,
              msg: `修改${tableName} ${No} 租户信息 失败`
            })
          }
        })
      }
      else
        res.send({
          code: 200,
          success: true,
          msg: `修改${tableName} ${No} 租户信息 成功`
        })
    } else {
      res.send({
        code: 205,
        success: false,
        msg: `修改${tableName} ${No} 租户信息 失败`
      })
    }
  })
})
router.post('/reportTenant', (req, res) => {    // 一键报备
  // console.log(req.body);
  let { Landlord_ID, LandlordName } = req.body
  let { Staff_ID, StaffName, Area, AreaID } = req.body.staff
  let table_tenant = 'tenant_' + Landlord_ID
  // 先获取 所有符合报备条件的 记录   未报备、信息完整
  connection.query('select * from `' + table_tenant + '` where ReportStatus="未报备" and Status="√" and ContractStage="租约中"', (e0, r0) => {
    // console.log(e0, r0);
    let NoArr = []  // tenant的报备记录 数组No
    let NoStr = ''  // No拼接后的string
    if (r0.length > 0) {
      // 批量插入migrant表    租户信息  房东ID,name   工作人员ID,name   （后2 vuex里的userInfo都有--administrator表有存）
      r0.forEach(element => {
        let { Name, ID, Gender, StartDate, Term, ContractStage, Tel, Marriage, Origin, Note } = element
        let insert = 'insert into migrant(Name,ID,Gender,StartDate,Term,ContractStage,Area,AreaID,Tel,Marriage,Origin,Note, Landlord_ID,LandlordName,Staff_ID,StaffName) values("' + Name + '","' + ID + '","' + Gender + '","' + StartDate + '","' + Term + '","' + ContractStage + '","' + Area + '","' + AreaID + '","' + Tel + '","' + Marriage + '","' + Origin + '","' + Note + '","' + Landlord_ID + '","' + LandlordName + '","' + Staff_ID + '","' + StaffName + '")'
        connection.query(insert, (e1, r1) => {
          if (r1.affectedRows > 0) {
            // console.log(e1, r1.insertId);
          } else {
            res.send({
              code: 205,
              success: false,
              msg: '插入migrant表失败'
            })
          }
        })
        // 拼接 tenant记录的编号
        NoArr.push(element.No)
        // console.log(NoArr);
      });
      NoStr = NoArr.join(',')
      // console.log(NoStr);
      // 成功 -- 修改这些记录的报备状态
      connection.query('update `' + table_tenant + '` set ReportStatus = "√" where No in (' + NoStr + ')', (e2, r2) => {
        // console.log(e2, r2);
        if (r2.affectedRows > 0) {
          res.send({
            code: 200,
            success: true,
            msg: '报备成功',
            data: {
              NoStr,
              number: NoArr.length,
              StaffName
            }
          })
        } else {
          res.send({
            code: 205,
            success: false,
            msg: '修改租户报备状态失败'
          })
        }
      })
    } else {
      res.send({
        code: 203,
        success: true,
        msg: '没有符合报备条件的租户记录'
      })
    }
  })
})
router.get('/toBeReport', (req, res) => {       // 可以报备的租户数量 -- 信息完整、未上报
  // console.log(req.query);
  let { tableName } = req.query
  connection.query('select No from `' + tableName + '` where ReportStatus="未报备" and Status="√" and ContractStage="租约中"', (e, r) => {
    // console.log(e, r);
    if (r.length > 0) {
      res.send({
        code: 200,
        success: true,
        msg: '查询可报备的租户数目',
        data: r.length
      })
    } else {
      res.send({
        code: 200,
        success: true,
        msg: '没有可报备的租户数目',
        data: 0
      })
    }
  })
})


// 月租 
router.get('/allRents', (req, res) => {             // 所有
  // console.log(req.query);
  let { pageNo, ID } = req.query
  let tableName = 'rent_' + ID
  let pageSize = 5; // 页面默认展示 5 条数据，不可更改
  connection.query('select * from `' + tableName + '`', (e, r) => {
    // console.log(e, r);
    let n = (pageNo - 1) * pageSize;
    if (r.length > 0) {
      connection.query(
        'select * from `' + tableName + '` order by No limit ' + n + ', ' + pageSize,   // 从第n条数据开始，取pageSize条数据
        (e, r1) => {
          // console.log(e, r1);
          res.send({
            code: 200,
            success: true,
            msg: `获取 ${tableName} 所有租金记录`,
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
        msg: `${tableName} 没有租金记录`,
        total: 0,
        pageSize,
        pageNo,
      });
    }
  })
})
router.get("/searchRent", (req, res) => {           // 搜索
  // console.log(req.query);
  let { tableName, keywords, pageNo, Status } = req.query
  let pageSize = 5;
  let n = (pageNo - 1) * pageSize;
  let sql1 = ''
  let sql2 = ''
  if (Status === '') {
    sql1 =
      "select * from `" + tableName + "` where concat(`Month`,`ContractNo`,`ContractStage`,`RoomNumber`,`Name`,`Stage`,`Status`) like '%" +
      keywords +
      "%'";
    sql2 =
      "select * from `" + tableName + "` where concat(`Month`,`ContractNo`,`ContractStage`,`RoomNumber`,`Name`,`Stage`,`Status`) like '%" +
      keywords +
      "%' limit " +
      n +
      "," +
      pageSize;
  } else {
    sql1 =
      "select * from `" + tableName + "` where Status='" + Status + "' and concat(`Month`,`ContractNo`,`ContractStage`,`RoomNumber`,`Name`,`Stage`,`Status`) like '%" +
      keywords +
      "%'";
    sql2 =
      "select * from `" + tableName + "` where Status='" + Status + "' and concat(`Month`,`ContractNo`,`ContractStage`,`RoomNumber`,`Name`,`Stage`,`Status`) like '%" +
      keywords +
      "%' limit " +
      n +
      "," +
      pageSize;
  }
  // let sql1 =
  //   "select * from `" + tableName + "` where concat(`Month`,`ContractNo`,`ContractStage`,`RoomNumber`,`Name`,`Stage`,`Status`) like '%" +
  //   keywords +
  //   "%'";
  // let sql2 =
  //   "select * from `" + tableName + "` where concat(`Month`,`ContractNo`,`ContractStage`,`RoomNumber`,`Name`,`Stage`,`Status`) like '%" +
  //   keywords +
  //   "%' limit " +
  //   n +
  //   "," +
  //   pageSize;
  // console.log(sql1);
  // console.log(sql2);
  connection.query(sql1, (e0, r0) => {
    // console.log(e0, r0);
    if (r0.length > 0) {
      connection.query(sql2, (e1, r1) => {
        // console.log(e1, r1);
        res.send({
          code: 200,
          msg: `模糊搜索${tableName}月租表 ${keywords}`,
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
        msg: `暂无与${keywords}相关的月租记录`,
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
router.get('/detailRent', (req, res) => {       // 获取详情
  // console.log(req.query);
  let { No, tableName } = req.query
  connection.query('select * from `' + tableName + '` where No = "' + No + '"', (e, r) => {
    console.log(e, r);
    res.send({
      code: 200,
      success: true,
      msg: `获取 ${tableName} 的 ${No} 月租记录`,
      data: r
    })
  })
})
router.post('/modifyRent', (req, res) => {
  console.log(req.body);
  let { ID } = req.body
  let { No, ActualAmount, ToalAmount, WaterFee, ElectricityFee, WaterMeterDegree, ElectricityMeterDegree, Stage } = req.body.form
  let tableName_rent = 'rent_' + ID
  if (ActualAmount == 'null' || typeof ActualAmount == 'undefined') ActualAmount = ''
  connection.query('update `' + tableName_rent + '` set Status="√",ActualAmount="' + ActualAmount + '",ToalAmount="' + ToalAmount + '",WaterFee="' + WaterFee + '",ElectricityFee="' + ElectricityFee + '",Stage="' + Stage + '",WaterMeterDegree="' + WaterMeterDegree + '",ElectricityMeterDegree="' + ElectricityMeterDegree + '" where No="' + No + '"', (e0, r0) => {
    console.log(e0, r0);
    if (r0.affectedRows > 0) {
      res.send({
        code: 200,
        success: true,
        msg: `成功修改 ${tableName_rent} 的 ${No} 月租记录`,
        // data: r
      })
    } else {
      res.send({
        code: 205,
        success: false,
        msg: `修改 ${tableName_rent} 的 ${No} 月租记录失败`,
        // data: r
      })
    }
  })
})
router.get('/deleteRent', (req, res) => {       // 删除
  // console.log(req.query);
  let { ID, No } = req.query
  let tableName_rent = 'rent_' + ID
  connection.query('delete from `' + tableName_rent + '` where No = "' + No + '"', (e, r) => {
    // console.log(e, r);
    if (r.affectedRows > 0) {
      res.send({
        code: 200,
        success: true,
        msg: `成功删除${tableName_rent} 的${No} 月租记录 `,
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
router.get('/getMonthsList', (req, res) => {
  // console.log(req.query);
  let { ID, ContractNo } = req.query
  let tableName_rent = 'rent_' + ID
  connection.query('select Month from `' + tableName_rent + '` where ContractNo = "' + ContractNo + '"', (e, r) => {
    // console.log(e, r);
    if (r.length > 0) {
      let months = []
      r.map(item => {
        months.push(item.Month)
      })
      // console.log(months);
      let allMonths = ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月']
      for (let i = 0; i < allMonths.length; i++) {
        for (let j = 0; j < months.length; j++) {
          if (allMonths[i] === months[j]) {
            allMonths.splice(i, 1);
            i--;
            break;
          }
        }
      }
      // console.log(allMonths);
      res.send({
        code: 200,
        msg: `获取${tableName_rent}的${ContractNo}相关的月租记录（可新增记录的月份）`,
        data: allMonths,
        success: true
      })
    } else {
      res.send({
        code: 205,
        msg: `获取 （可新增记录的月份）失败`,
        success: false
      })
    }
  })
})
router.post('/newRent', (req, res) => {
  console.log(req.body);
  let { tableName } = req.body
  let { Month, ContractNo, ContractStage, RoomNumber, ID, Name, CollectionDate, Stage, ToalAmount, ActualAmount, MonthlyRent, WaterFee, ElectricityFee, HygieneFee, NetworkFee, UnitWaterFee, UnitElectrictyFee, WaterMeterDegree, ElectricityMeterDegree, Note } = req.body.form
  connection.query('insert into `' + tableName + '`(Month, ContractNo, ContractStage, RoomNumber, ID, Name, CollectionDate, Status, Stage, ToalAmount, ActualAmount, MonthlyRent, WaterFee, ElectricityFee, HygieneFee, NetworkFee, UnitWaterFee, UnitElectrictyFee, WaterMeterDegree, ElectricityMeterDegree, Note) values("' + Month + '","' + ContractNo + '","' + ContractStage + '","' + RoomNumber + '","' + ID + '","' + Name + '","' + CollectionDate + '","√","' + Stage + '","' + ToalAmount + '","' + ActualAmount + '","' + MonthlyRent + '","' + WaterFee + '","' + ElectricityFee + '","' + HygieneFee + '","' + NetworkFee + '","' + UnitWaterFee + '","' + UnitElectrictyFee + '","' + WaterMeterDegree + '","' + ElectricityMeterDegree + '","' + Note + '")', (e, r) => {
    console.log(e, r);
    if (r.affectedRows > 0) {
      res.send({
        code: 200,
        success: true,
        msg: `成功新增${tableName} 的${r.insertId} 月租记录 `,
      });
    } else {
      res.send({
        code: 205,
        msg: `新增失败`,
        success: false
      })
    }
  })
})


module.exports = router;