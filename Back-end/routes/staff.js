var express = require("express");
var router = express.Router();
var connection = require("../database/connection");

// 出租屋 
router.get("/allHouse", (req, res) => {           // 所有
  let pageSize = 5; // 页面默认展示 5 条数据，不可更改
  let pageNo = req.query.pageNo; // 默认 第一页
  let currentStaff_ID = req.query.ID
  let sql = `select * from house where Staff_ID = '${currentStaff_ID}'`
  connection.query(sql, (err, r0) => {
    let n = (pageNo - 1) * pageSize;
    if (r0.length > 0) {
      connection.query(
        `select * from house where Staff_ID = '${currentStaff_ID}' order by 'No' limit ${n},${pageSize}`,
        (e, r1) => {
          res.send({
            code: 200,
            success: true,
            msg: "获取所有出租屋信息",
            data: r1,
            total: r0.length,
            allData: r0,
            pageSize,
            pageNo,
          });
        }
      );
    } else {
      res.send({
        code: 200,
        success: true,
        msg: "无出租屋信息",
        // data: r1,
        total: r0.length,
        allData: r0,
        pageSize,
        pageNo,
      });
    }
  });
});
router.get("/searchHouse", (req, res) => {        // 搜索
  let searchParams = req.query.keywords;
  let pageNo = req.query.pageNo;
  let pageSize = 5;
  let n = (pageNo - 1) * pageSize; // 返回 pageSize 条 数据
  let currentStaff_ID = req.query.ID
  let sql1 =
    "select * from house where concat(`HouseNumber`,`OwnerID`,`OwnerName`,`StaffName`,`Area`,`No`,`LastInspectedTime`,`OverallSafetySituation`) like '%" +
    searchParams +
    "%' and Staff_ID = '" + currentStaff_ID + "'";
  let sql2 =
    "select * from house where concat(`HouseNumber`,`OwnerID`,`OwnerName`,`StaffName`,`Area`,`No`,`LastInspectedTime`,`OverallSafetySituation`)  like '%" +
    searchParams +
    "%' and Staff_ID = '" + currentStaff_ID + "' limit " +
    n +
    "," +
    pageSize;
  connection.query(sql1, (e0, r0) => {
    if (r0.length > 0) {
      connection.query(sql2, (e1, r1) => {
        res.send({
          code: 200,
          msg: "模糊搜索出租屋",
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
        msg: "暂无相关的出租屋数据",
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
router.post("/deleteHouse", (req, res) => {      // 删除
  let No = req.body.No;
  connection.query(`delete from house where No = ${No}`, (e, r) => {
    if (r.affectedRows > 0) {
      res.send({
        code: 200,
        success: true,
        msg: "删除成功",
      });
    } else {
      res.send({
        code: 205,
        success: false,
        msg: "删除失败",
      });
    }
  });
});
router.get("/HouseDetail", (req, res) => {       // 详情
  let No = req.query.No;
  connection.query(
    `select * from house where No = ${No}`,
    function (error, result) {
      res.send({
        code: 200,
        data: result,
        success: true,
        msg: `获取出租屋No：${No}的详情`,
      });
    }
  );
});
router.post("/updateHouse", (req, res) => {      // 编辑
  let { No, HouseNumber, OwnerName, Landlord_ID, OwnerID, OverallSafetySituation, LastInspectedTime, Square, CompletionTime, Height, Floors, AvailableRooms, Note } = req.body;
  let sql = `update house set HouseNumber='${HouseNumber}',OwnerName='${OwnerName}',Landlord_ID='${Landlord_ID}',Square='${Square}', OwnerID='${OwnerID}',OwnerName='${OwnerName}',OverallSafetySituation='${OverallSafetySituation}', LastInspectedTime='${LastInspectedTime}',CompletionTime='${CompletionTime}',Floors='${Floors}', AvailableRooms='${AvailableRooms}',Note='${Note}',Height='${Height}'   where No = ${No}  `;
  connection.query(`select * from house where No = ${No}`, (e, r0) => {
    if (r0.length > 0) {
      connection.query(sql, (e, r1) => {
        if (r1.affectedRows > 0) {
          res.send({
            code: 200,
            success: true,
            msg: "编辑出租屋信息成功",
          });
        } else {
          res.send({
            code: 205,
            success: false,
            msg: "编辑出租屋信息失败",
          });
        }
      });
    } else {
      res.send({
        code: 205,
        success: false,
        msg: '没有该编号的出租屋记录'
      })
    }
  });
});
router.post("/addHouse", (req, res) => {         // 添加
  let { StaffName, StaffID } = req.body.staff
  let { HouseNumber, OwnerName, Landlord_ID, OwnerID, OverallSafetySituation, LastInspectedTime, Area, CompletionTime, Height, Floors, AvailableRooms, Note, AreaID } = req.body.houseForm;
  let sql = `insert into house(HouseNumber,OwnerName,Landlord_ID,OwnerID,OverallSafetySituation,LastInspectedTime,StaffName,Staff_ID,Area,AreaID,CompletionTime,Height,Floors,AvailableRooms,Note)  values('${HouseNumber}','${OwnerName}','${Landlord_ID}','${OwnerID}','${OverallSafetySituation}','${LastInspectedTime}','${StaffName}','${StaffID}','${Area}','${AreaID}','${CompletionTime}','${Height}','${Floors}','${AvailableRooms}','${Note}')`;
  connection.query(sql, (e, r) => {
    if (r.affectedRows > 0) {
      res.send({
        code: 200,
        success: true,
        msg: "成功新增一条出租屋记录",
        data: {
          No: r.insertId,
        },
      });
    } else {
      res.send({
        code: 205,
        success: false,
        msg: "失败新增",
      });
    }
  });
});
router.get('/getLandlordID', (req, res) => {     // 获取administrator中的管理员ID
  let AreaID = req.query.AreaID
  connection.query(`select Admin_ID,Name from administrator where Role = "landlord" and AreaID = ${AreaID} `, (e0, r0) => {
    let data = []
    r0.forEach(item => {
      let option = {}
      option.value = item.Admin_ID
      option.label = item.Name
      data.push(option)
    })
    res.send({
      code: 200,
      msg: "获取管理员ID列表",
      success: true,
      data,
    })
  })
})
// 流动人员
router.get("/allMigrants", (req, res) => {       // 所有
  let pageSize = 5; // 页面默认展示 5 条数据，不可更改
  let pageNo = req.query.pageNo; // 默认 第一页
  let currentStaff_ID = req.query.ID
  connection.query(`select * from migrant where Staff_ID = '${currentStaff_ID}'`, (err, r0) => {
    let n = (pageNo - 1) * pageSize;
    if (r0.length > 0) {
      connection.query(
        `select * from migrant where Staff_ID = '${currentStaff_ID}' order by 'No' limit ${n},${pageSize}`,   // 从第n条数据开始，取pageSize条数据
        (e, r1) => {
          res.send({
            code: 200,
            success: true,
            msg: "获取所有流动人员信息",
            data: r1,
            total: r0.length,
            allData: r0,
            pageSize,
            pageNo,
          });
        }
      );
    } else {
      res.send({
        code: 203,
        success: true,
        msg: "无流动人员",
        total: r0.length,
        pageSize,
        pageNo,
      });
    }
  });
});
router.get("/searchMigrant", (req, res) => {     // 搜索
  let { pageNo, keywords } = req.query
  let pageSize = 5;
  let n = (pageNo - 1) * pageSize;
  let currentStaff_ID = req.query.ID
  let sql1 =
    "select * from migrant where concat(`Name`,`ID`,`LandlordName`,`Marriage`,`StartDate`,`Landlord_ID`,`Origin`,`Gender`) like '%" +
    keywords +
    "%' and Staff_ID = '" + currentStaff_ID + "'";
  let sql2 =
    "select * from migrant where concat(`Name`,`ID`,`LandlordName`,`Marriage`,`StartDate`,`Landlord_ID`,`Origin`,`Gender`) like '%" +
    keywords +
    "%' and Staff_ID = '" + currentStaff_ID + "' limit " +
    n +
    "," +
    pageSize;
  // console.log(sql1);
  // console.log(sql2);
  connection.query(sql1, (e0, r0) => {
    // 能搜到相关数据
    // console.log(e0, r0);
    if (r0.length > 0) {
      connection.query(sql2, (e1, r1) => {
        // console.log(e1, r1);
        res.send({
          code: 200,
          msg: "模糊搜索流动人员",
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
        msg: "暂无相关流动人员的数据",
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
router.post("/addMigrant", (req, res) => {       // 添加
  // console.log(req.body.staff);
  console.log(req.body);
  let { StaffName, StaffID } = req.body.staff
  // console.log(req.body.form);
  let { StartDate, ID, Marriage, LandlordName, Name, Origin, Tel, Note, Gender, Area, AreaID } = req.body.form;
  let lookup = `select Admin_ID from Administrator where Name = '${LandlordName}'`
  connection.query(lookup, (e0, r0) => {
    console.log(e0, r0);
    if (r0.length > 0) {
      let Landlord_ID = r0[0].Admin_ID
      // console.log(Landlord_ID);
      // console.log(r0[0].Admin_ID);
      let sql = `insert into migrant(Name,ID,Landlord_ID,LandlordName,Marriage,StartDate,StaffName,Staff_ID,Area,AreaID,Tel,Origin,Gender,Note)  values('${Name}','${ID}','${Landlord_ID}','${LandlordName}','${Marriage}','${StartDate}','${StaffName}','${StaffID}','${Area}','${AreaID}','${Tel}','${Origin}','${Gender}','${Note}')`;
      console.log(sql);
      connection.query(sql, (e1, r1) => {
        console.log(e1, r1);
        if (r1.affectedRows > 0) {
          res.send({
            code: 200,
            success: true,
            msg: "成功新增记录",
            data: {
              No: r1.insertId,
            },
          });
        } else {
          res.send({
            code: 205,
            success: false,
            msg: "失败新增",
          });
        }
      })
    }
  });
});
router.get("/migrantDetail", (req, res) => {     // 详情
  let No = req.query.No;
  connection.query(
    `select * from migrant where No = ${No}`,
    function (error, result) {
      res.send({
        code: 200,
        data: result,
        success: true,
        msg: `获取流动人员No：${No}的详情`,
      });
    }
  );
});
router.post("/updateMigrant", (req, res) => {    // 编辑
  let { No, StartDate, ID, Marriage, LandlordName, Name, Origin, Tel, Note, Gender } = req.body.form;
  // let { StaffName, StaffID } = req.body.staff  // 不变的
  let lookup = `select Admin_ID from Administrator where Name = '${LandlordName}'`
  connection.query(lookup, (e, r0) => {
    if (r0.length > 0) {
      let landlordID = r0[0].Admin_ID
      let update = `update migrant set StartDate='${StartDate}',ID='${ID}', Marriage='${Marriage}',LandlordName='${LandlordName}',Name='${Name}', Origin='${Origin}',Tel='${Tel}',Landlord_ID='${landlordID}',Note='${Note}',Gender='${Gender}'   where No = ${No}  `;
      connection.query(update, (e, r1) => {
        if (r1.affectedRows > 0) {
          res.send({
            code: 200,
            success: true,
            msg: "编辑流动人员信息成功",
          });
        } else {
          res.send({
            code: 205,
            success: false,
            msg: "编辑失败",
          });
        }
      });
    }
  });
});
// 巡视记录
router.get("/allInspectation", (req, res) => {    // 所有
  let pageSize = 5; // 页面默认展示 5 条数据，不可更改
  let pageNo = req.query.pageNo; // 默认 第一页
  let tableName = req.query.tableName
  connection.query('select * from `' + tableName + '`', (err, r0) => {
    let n = (pageNo - 1) * pageSize;
    if (r0.length > 0) {
      connection.query(
        'select * from `' + tableName + '` order by No limit ' + n + ', ' + pageSize,   // 从第n条数据开始，取pageSize条数据
        (e, r1) => {
          res.send({
            code: 200,
            success: true,
            msg: "获取所有巡视记录",
            data: r1,
            total: r0.length,
            allData: r0,
            pageSize,
            pageNo,
          });
        }
      );
    } else {
      res.send({
        code: 203,
        success: true,
        msg: "无巡视记录",
        total: r0.length,
        pageSize,
        pageNo,
      });
    }
  });
});
router.get("/searchInspectation", (req, res) => {  // 搜索
  console.log(req.query);
  let searchParams = req.query.keywords;
  let pageNo = req.query.pageNo;
  let Overall = req.query.Overall
  let pageSize = 5;
  let n = (pageNo - 1) * pageSize;
  let tableName = req.query.tableName
  let sql1 = ''
  let sql2 = ''
  if (Overall === '') {
    sql1 =
      "select * from `" + tableName + "` where concat(`Title`,`Time`,`Owner`,`HouseNumber`,`No`,`Overall`,`FailReason`) like '%" +
      searchParams +
      "%'";
    sql2 =
      "select * from `" + tableName + "` where concat(`Title`,`Time`,`Owner`,`HouseNumber`,`No`,`Overall`,`FailReason`) like '%" +
      searchParams +
      "%' limit " +
      n +
      "," +
      pageSize;
  } else {
    sql1 =
      "select * from `" + tableName + "` where Overall='" + Overall + "' and concat(`Title`,`Time`,`Owner`,`HouseNumber`,`No`,`Overall`,`FailReason`) like '%" +
      searchParams +
      "%'";
    sql2 =
      "select * from `" + tableName + "` where Overall='" + Overall + "' and concat(`Title`,`Time`,`Owner`,`HouseNumber`,`No`,`Overall`,`FailReason`) like '%" +
      searchParams +
      "%' limit " +
      n +
      "," +
      pageSize;
  }
  // let sql1 =
  //   "select * from `" + tableName + "` where concat(`Title`,`Time`,`Owner`,`HouseNumber`,`No`,`Overall`,`FailReason`) like '%" +
  //   searchParams +
  //   "%'";
  // let sql2 =
  //   "select * from `" + tableName + "` where concat(`Title`,`Time`,`Owner`,`HouseNumber`,`No`,`Overall`,`FailReason`) like '%" +
  //   searchParams +
  //   "%' limit " +
  //   n +
  //   "," +
  //   pageSize;
  connection.query(sql1, (e0, r0) => {
    // 能搜到相关数据
    console.log(e0, r0);
    if (r0.length > 0) {
      connection.query(sql2, (e1, r1) => {
        res.send({
          code: 200,
          msg: "模糊搜索巡视记录",
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
        msg: "暂无相关巡视记录",
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
router.post("/newInspectation", (req, res) => {   // 添加
  let { Area, HouseNumber, ServeillanceSystem, EntranceGuard, FireSafety, Time, StaffName, Owner, Staff_ID, Sanitry, Other, Structural, Circuit, FailReason, Overall, Title } = req.body.form;
  let tableName = req.body.tableName
  let sql = "insert into `" + tableName + "`(Area, HouseNumber, ServeillanceSystem, EntranceGuard, FireSafety, Time, StaffName, Owner, Staff_ID, Sanitry, Other, Structural,Circuit, FailReason, Overall, Title,Note)  values('" + Area + "','" + HouseNumber + "','" + ServeillanceSystem + "','" + EntranceGuard + "','" + FireSafety + "','" + Time + "','" + StaffName + "','" + Owner + "','" + Staff_ID + "','" + Sanitry + "','" + Other + "','" + Structural + "','" + Circuit + "','" + FailReason + "','" + Overall + "','" + Title + "','')";
  connection.query(sql, (e1, r1) => {
    if (r1.affectedRows > 0) {
      res.send({
        code: 200,
        success: true,
        msg: "成功新增记录",
      });
    } else {
      res.send({
        code: 205,
        success: false,
        msg: "失败新增",
      });
    }
  })
});
router.get("/inspectationDetail", (req, res) => {  // 详情
  let No = req.query.No;
  let tableName = req.query.tableName
  connection.query(
    'select * from `' + tableName + '` where No = ' + No + '',
    function (error, result) {
      res.send({
        code: 200,
        data: result,
        success: true,
        msg: `获取No：${No}的巡视记录`,
      });
    }
  );
});
router.post("/updateInspectation", (req, res) => { // 编辑
  let { Area, Note, HouseNumber, ServeillanceSystem, EntranceGuard, FireSafety, Time, StaffName, Owner, Staff_ID, Sanitry, Other, Structural, Circuit, FailReason, Overall, Title, No } = req.body.form;
  let tableName = req.body.tableName
  let update = "update `" + tableName + "` set Note='" + Note + "',HouseNumber='" + HouseNumber + "',ServeillanceSystem='" + ServeillanceSystem + "',EntranceGuard='" + EntranceGuard + "',FireSafety='" + FireSafety + "',Time='" + Time + "',Owner='" + Owner + "',Sanitry='" + Sanitry + "',Other='" + Other + "',Structural='" + Structural + "',Circuit='" + Circuit + "',FailReason='" + FailReason + "',Overall='" + Overall + "',Title='" + Title + "' where No = " + No + "";
  connection.query(update, (e, r1) => {
    if (r1.affectedRows > 0) {
      res.send({
        code: 200,
        success: true,
        msg: "编辑巡视记录成功",
      });
    } else {
      res.send({
        code: 205,
        success: false,
        msg: "编辑失败",
      });
    }
  });
});
router.post("/deleteInspectation", (req, res) => { // 删除
  let No = req.body.No;
  let tableName = req.body.tableName
  connection.query('delete from `' + tableName + '` where No = ' + No + '', (e, r) => {
    if (r.affectedRows > 0) {
      res.send({
        code: 200,
        success: true,
        msg: "删除成功",
      });
    } else {
      res.send({
        code: 205,
        success: false,
        msg: "删除失败",
      });
    }
  });
});
router.get('/getLandlordList', (req, res) => {    // 获取房东列表
  let AreaID = req.query.AreaID
  connection.query(`select * from house where AreaID = ${AreaID} `, (e0, r0) => {
    res.send({
      code: 200,
      msg: `获取区域ID为${AreaID}的房东列表`,
      success: true,
      data: r0,
    })
  })
})
// 群众意见     opinion   
router.get("/allOpinions", (req, res) => {         // 所有 
  let pageSize = 5; // 页面默认展示 5 条数据，不可更改
  let { tableName, pageNo } = req.query
  connection.query('select * from `' + tableName + '`', (e0, r0) => {
    let n = (pageNo - 1) * pageSize;
    if (r0.length > 0) {
      connection.query(
        'select * from `' + tableName + '` order by "No" limit ' + n + ',' + pageSize + '',
        (e1, r1) => {
          res.send({
            code: 200,
            success: true,
            msg: "获取所有群众意见",
            data: r1,
            total: r0.length,
            allData: r0,
            pageSize,
            pageNo,
          });
        }
      );
    } else {
      res.send({
        code: 203,
        success: true,
        msg: "无群众意见",
        total: r0.length,
        pageSize,
        pageNo,
      });
    }
  });
});
router.get("/searchOpinions", (req, res) => {     // 搜索  
  let { tableName, keywords, pageNo, Status } = req.query
  let pageSize = 5;
  let n = (pageNo - 1) * pageSize;
  let sql1 = ''
  let sql2 = ''
  if (Status === '') {
    sql1 =
      "select * from `" + tableName + "` where concat(`Title`,`Category`,`Detail`,`LandlordName`,`No`,`Status`) like '%" +
      keywords +
      "%'";
    sql2 =
      "select * from `" + tableName + "` where concat(`Title`,`Category`,`Detail`,`LandlordName`,`No`,`Status`) like '%" +
      keywords +
      "%' limit " +
      n +
      "," +
      pageSize;
  } else {
    sql1 =
      "select * from `" + tableName + "` where Status='" + Status + "' and concat(`Title`,`Category`,`Detail`,`LandlordName`,`No`,`Status`) like '%" +
      keywords +
      "%'";
    sql2 =
      "select * from `" + tableName + "` where Status='" + Status + "' and concat(`Title`,`Category`,`Detail`,`LandlordName`,`No`,`Status`) like '%" +
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
          msg: `模糊搜索${tableName}群众意见`,
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
        msg: `暂无${tableName} 相关群众意见`,
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
router.get("/opinionDetail", (req, res) => {      // 详情
  let { tableName, No } = req.query
  connection.query(
    'select * from `' + tableName + '` where No = ' + No,
    function (error, result) {
      res.send({
        code: 200,
        data: result,
        success: true,
        msg: `获取群众意见No：${No}的详情`,
      });
    }
  );
});
router.post("/updateOpinion", (req, res) => {     // 编辑
  let { tableName } = req.body
  let { Response, No, Status } = req.body.form;
  let update = 'update `' + tableName + '` set Response="' + Response + '",Status="' + Status + '" where No = "' + No + '"'
  connection.query(update, (e, r1) => {
    if (r1.affectedRows > 0) {
      res.send({
        code: 200,
        success: true,
        msg: "编辑群众意见成功",
      });
    } else {
      res.send({
        code: 205,
        success: false,
        msg: "编辑失败",
      });
    }
  });
});
router.post("/deleteOpinion", (req, res) => {     // 删除
  let { tableName, No } = req.body
  connection.query('delete from `' + tableName + '` where No = ' + No, (e, r) => {
    if (r.affectedRows > 0) {
      res.send({
        code: 200,
        success: true,
        msg: `从${tableName}删除成功`,
      });
    } else {
      res.send({
        code: 205,
        success: false,
        msg: `从${tableName}删除失败`,
      });
    }
  });
});

// 首页
router.get('/getFeedbackNumber', (req, res) => {
  let { tableName } = req.query
  connection.query('select No from `' + tableName + '` where Status="等待反馈"', (e, r) => {
    if (r) {
      if (r.length > 0) {
        res.send({
          code: 200,
          success: true,
          msg: '查询等待反馈的群众意见数目',
          data: r.length
        })
      } else {
        res.send({
          code: 200,
          success: true,
          msg: '没有等待反馈的群众意见',
          data: 0
        })
      }
    } else {
      res.send({
        code: 205,
        success: false,
        msg: '查询等待反馈的群众意见失败'
      })
    }
  })
})


module.exports = router;