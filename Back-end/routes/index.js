var express = require("express");
var router = express.Router();
var connection = require("../database/connection");


// administrator
// 登录
router.post("/login", (req, res) => {
  // account 可以是UserName/Admin_ID/Tel
  let { account, password } = req.body;
  // console.log(req.body);
  // 先查询有没有 这个 Account   有 -> 拿到 No. 字段
  connection.query(
    `select * from administrator where UserName = '${account}' or Admin_ID = '${account}' or Tel = '${account}'`,
    (e, r) => {
      // console.log(r);
      if (r.length > 0) {
        let { id, UserPassword } = r[0];
        if (UserPassword == password) {
          res.send({
            code: 200,
            success: true,
            msg: "登录成功",
            data: r[0],
          });
        } else {
          res.send({
            code: 203,
            success: false,
            msg: "登陆失败，密码错误！",
          });
        }
        /* connection.query(`select * from administrator where id=${id}`, (er, result) => {
          // console.log(result);
          // 都有id了，肯定就要密码，所以就不判断了
          let pwd = result[0].password;
          // 判断密码
          if (pwd == password) {
            // 重新生成token
            let token = produceToken({ username, password });
            console.log(token);
            let sql = `update user set token = '${token}' where id=${id}`;
            connection.query(sql, () => {
              // 返回修改之后的数据
              connection.query(
                `select * from user where id = ${id}`,
                (ee, rr) => {
                  res.send({
                    code: 200,
                    success: true,
                    msg: "登录成功",
                    data: rr[0],
                  });
                }
              );
            });
          } else {
            res.send({
              code: 203,
              success: false,
              msg: "登陆失败，密码错误！",
            });
          }
        }); */
      } else {
        res.send({
          code: 205,
          success: false,
          msg: "登陆失败，没有该用户！",
        });
      }
    }
  );
});
// 修改密码   
router.post('/changePassword', (req, res) => {
  console.log(req.body);
  let { No, newPwd, oldpwd } = req.body
  connection.query(`select UserPassword from administrator where No = ${No}`, (e0, r0) => {
    console.log(e0, r0);
    if (r0[0].UserPassword === oldpwd) {
      connection.query(`update administrator set UserPassword = '${newPwd}' where No = ${No}`, (e1, r1) => {
        res.send({
          code: 200,
          success: true,
          msg: '成功修改密码'
        })
      })
    } else {
      res.send({
        code: 205,
        success: false,
        msg: '原密码错误'
      })
    }
  })
})
// 修改我的信息   
router.post('/changeInfo', (req, res) => {
  console.log(req.body);
  let { Name, UserName, Tel, Gender, No, Note } = req.body
  connection.query(`update administrator set Name = '${Name}',Note = '${Note}',UserName = '${UserName}',Tel = '${Tel}',Gender = '${Gender}' where No = ${No}`, (e1, r1) => {
    if (r1.affectedRows > 0)
      res.send({
        code: 200,
        success: true,
        msg: '成功修改我的信息'
      })
    else
      res.send({
        code: 205,
        success: false,
        msg: '修改失败'
      })
  })
})
// 存储头像
router.post('/avatar', (req, res) => {
  console.log(req.body);
  let { url, No } = req.body
  connection.query(`update administrator set Avatar = '${url}' where No = ${No}`, (e, r) => {
    console.log(e, r);
    if (r.affectedRows > 0)
      res.send({
        code: 200,
        success: true,
        msg: '存储头像成功'
      })
    else
      res.send({
        code: 205,
        success: false,
        msg: '上传失败'
      })
  })
})

// staff 工作人员使用
// 出租屋 
router.get("/allHouse", (req, res) => { // 所有
  let pageSize = 5; // 页面默认展示 5 条数据，不可更改
  let pageNo = req.query.pageNo; // 默认 第一页
  let currentStaff_ID = req.query.ID
  // console.log(req.query);
  console.log(currentStaff_ID);
  let sql = `select * from house where Staff_ID = '${currentStaff_ID}'`
  console.log(sql);
  connection.query(sql, (err, r0) => {
    let n = (pageNo - 1) * pageSize;
    // console.log(err,r0);
    if (r0.length > 0) {
      connection.query(
        `select * from house where Staff_ID = '${currentStaff_ID}' order by 'No' limit ${n},${pageSize}`,
        (e, r1) => {
          // console.log(r1);
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
router.get("/searchHouse", (req, res) => {    // 搜索
  let searchParams = req.query.keywords;
  let pageNo = req.query.pageNo;
  let pageSize = 5;
  let n = (pageNo - 1) * pageSize; // 返回 pageSize 条 数据
  let currentStaff_ID = req.query.ID
  // console.log(req.query);
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
  // console.log(sql1);
  // console.log(sql2);
  connection.query(sql1, (e0, r0) => {
    // 能搜到相关数据
    // console.log(e0, r0);
    if (r0.length > 0) {
      connection.query(sql2, (e1, r1) => {
        // console.log(e1,r1);
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
      // 搜不到
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
router.post("/deleteHouse", (req, res) => {   // 删除
  let No = req.body.No;
  connection.query(`delete from house where No = ${No}`, (e, r) => {
    // console.log(r);
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
router.get("/HouseDetail", (req, res) => {    // 详情
  let No = req.query.No;
  // console.log(No);
  connection.query(
    `select * from house where No = ${No}`,
    function (error, result) {
      // console.log(error,result);
      res.send({
        code: 200,
        data: result,
        success: true,
        msg: `获取出租屋No：${No}的详情`,
      });
    }
  );
});
router.post("/updateHouse", (req, res) => {   // 编辑
  let { No, HouseNumber, OwnerName, Landlord_ID, OwnerID, OverallSafetySituation, LastInspectedTime, Square, CompletionTime, Height, Floors, AvailableRooms, Note } = req.body;
  // console.log(No, HouseNumber, OwnerName, Landlord_ID, OwnerID, OverallSafetySituation, LastInspectedTime,  CompletionTime, Height, Floors, AvailableRooms, Note);
  let sql = `update house set HouseNumber='${HouseNumber}',OwnerName='${OwnerName}',Landlord_ID='${Landlord_ID}',Square='${Square}', OwnerID='${OwnerID}',OwnerName='${OwnerName}',OverallSafetySituation='${OverallSafetySituation}', LastInspectedTime='${LastInspectedTime}',CompletionTime='${CompletionTime}',Floors='${Floors}', AvailableRooms='${AvailableRooms}',Note='${Note}',Height='${Height}'   where No = ${No}  `;
  console.log(sql);
  connection.query(`select * from house where No = ${No}`, (e, r0) => {
    console.log(e, r0);
    if (r0.length > 0) {
      connection.query(sql, (e, r1) => {
        console.log(e, r1);
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
router.post("/addHouse", (req, res) => {    // 添加
  // console.log(req.body.staff);
  // console.log(req.body.houseForm);
  let { StaffName, StaffID } = req.body.staff
  let { HouseNumber, OwnerName, Landlord_ID, OwnerID, OverallSafetySituation, LastInspectedTime, Area, CompletionTime, Height, Floors, AvailableRooms, Note, AreaID } = req.body.houseForm;
  let sql = `insert into house(HouseNumber,OwnerName,Landlord_ID,OwnerID,OverallSafetySituation,LastInspectedTime,StaffName,Staff_ID,Area,AreaID,CompletionTime,Height,Floors,AvailableRooms,Note)  values('${HouseNumber}','${OwnerName}','${Landlord_ID}','${OwnerID}','${OverallSafetySituation}','${LastInspectedTime}','${StaffName}','${StaffID}','${Area}','${AreaID}','${CompletionTime}','${Height}','${Floors}','${AvailableRooms}','${Note}')`;
  console.log(sql);
  connection.query(sql, (e, r) => {
    console.log(e, r);
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
router.get('/getLandlordID', (req, res) => {    // 获取administrator中的管理员ID
  let AreaID = req.query.AreaID
  connection.query(`select Admin_ID,Name from administrator where Role = "landlord" and AreaID = ${AreaID} `, (e0, r0) => {
    // console.log(r0);
    let data = []
    r0.forEach(item => {
      let option = {}
      option.value = item.Admin_ID
      option.label = item.Name
      data.push(option)
    })
    console.log(data);
    res.send({
      code: 200,
      msg: "获取管理员ID列表",
      success: true,
      data,
    })
  })
})
// 流动人员
router.get("/allMigrants", (req, res) => {  // 所有
  let pageSize = 5; // 页面默认展示 5 条数据，不可更改
  let pageNo = req.query.pageNo; // 默认 第一页
  let currentStaff_ID = req.query.ID
  console.log(req.query);
  connection.query(`select * from migrant where Staff_ID = '${currentStaff_ID}'`, (err, r0) => {
    // console.log(err, r0);
    let n = (pageNo - 1) * pageSize;
    if (r0.length > 0) {
      connection.query(
        `select * from migrant where Staff_ID = '${currentStaff_ID}' order by 'No' limit ${n},${pageSize}`,   // 从第n条数据开始，取pageSize条数据
        (e, r1) => {
          // console.log(e, r1);
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
router.get("/searchMigrant", (req, res) => {  // 搜索
  let searchParams = req.query.keywords;
  let pageNo = req.query.pageNo;
  let pageSize = 5;
  let n = (pageNo - 1) * pageSize;
  let currentStaff_ID = req.query.ID
  // console.log(req.query);
  let sql1 =
    "select * from migrant where concat(`Name`,`ID`,`LandlordName`,`Marriage`,`StartDate`,`EndDate`,`Landlord_ID`,`Origin`,`Gender`) like '%" +
    searchParams +
    "%' and Staff_ID = '" + currentStaff_ID + "'";
  let sql2 =
    "select * from migrant where concat(`Name`,`ID`,`LandlordName`,`Marriage`,`StartDate`,`EndDate`,`Landlord_ID`,`Origin`,`Gender`) like '%" +
    searchParams +
    "%' and Staff_ID = '" + currentStaff_ID + "' limit " +
    n +
    "," +
    pageSize;
  // console.log(sql1);
  // console.log(sql2);
  connection.query(sql1, (e0, r0) => {
    // 能搜到相关数据
    console.log(e0, r0);
    if (r0.length > 0) {
      connection.query(sql2, (e1, r1) => {
        console.log(e1, r1);
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
router.post("/addMigrant", (req, res) => {  // 添加
  // console.log(req.body.staff);
  console.log(req.body);
  let { StaffName, StaffID } = req.body.staff
  // console.log(req.body.form);
  let { Birth, EndDate, StartDate, ID, Marriage, LandlordName, Name, Origin, Tel, Note, Gender, Area, AreaID } = req.body.form;
  let lookup = `select Admin_ID from Administrator where Name = '${LandlordName}'`
  connection.query(lookup, (e0, r0) => {
    console.log(e0, r0);
    if (r0.length > 0) {
      let Landlord_ID = r0[0].Admin_ID
      // console.log(Landlord_ID);
      // console.log(r0[0].Admin_ID);
      let sql = `insert into migrant(Name,ID,Landlord_ID,LandlordName,Marriage,StartDate,EndDate,StaffName,Staff_ID,Area,AreaID,Tel,Origin,Gender,Note,Birth)  values('${Name}','${ID}','${Landlord_ID}','${LandlordName}','${Marriage}','${StartDate}','${EndDate}','${StaffName}','${StaffID}','${Area}','${AreaID}','${Tel}','${Origin}','${Gender}','${Note}','${Birth}')`;
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
router.get("/migrantDetail", (req, res) => {  // 详情
  let No = req.query.No;
  // console.log(No);
  connection.query(
    `select * from migrant where No = ${No}`,
    function (error, result) {
      // console.log(error,result);
      res.send({
        code: 200,
        data: result,
        success: true,
        msg: `获取流动人员No：${No}的详情`,
      });
    }
  );
});
router.post("/updateMigrant", (req, res) => { // 编辑
  console.log(req.body.form);
  let { No, Birth, EndDate, StartDate, ID, Marriage, LandlordName, Name, Origin, Tel, Note, Gender } = req.body.form;
  // let { StaffName, StaffID } = req.body.staff  // 不变的
  let lookup = `select Admin_ID from Administrator where Name = '${LandlordName}'`
  connection.query(lookup, (e, r0) => {
    console.log(e, r0);
    if (r0.length > 0) {
      let landlordID = r0[0].Admin_ID
      let update = `update migrant set Birth='${Birth}',EndDate='${EndDate}',StartDate='${StartDate}',ID='${ID}', Marriage='${Marriage}',LandlordName='${LandlordName}',Name='${Name}', Origin='${Origin}',Tel='${Tel}',Landlord_ID='${landlordID}',Note='${Note}',Gender='${Gender}'   where No = ${No}  `;
      console.log(update);
      connection.query(update, (e, r1) => {
        console.log(e, r1);
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
router.get('/getLandlordName', (req, res) => {  // 获取administrator中的landlord 姓名列
  let AreaID = req.query.AreaID
  connection.query(`select Name from administrator where Role = "landlord" and AreaID = ${AreaID} `, (e0, r0) => {
    // console.log(r0);
    res.send({
      code: 200,
      msg: "获取房东姓名列表",
      success: true,
      data: r0,
    })
  })
})
router.post("/deleteMigrant", (req, res) => { // 删除
  let No = req.body.No;
  connection.query(`delete from migrant where No = ${No}`, (e, r) => {
    // console.log(r);
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
// 巡视记录
router.get("/allInspectation", (req, res) => {  // 所有
  let pageSize = 5; // 页面默认展示 5 条数据，不可更改
  let pageNo = req.query.pageNo; // 默认 第一页
  let tableName = req.query.tableName
  // console.log(req.query);
  connection.query('select * from `' + tableName + '`', (err, r0) => {
    // console.log(err, r0);
    let n = (pageNo - 1) * pageSize;
    if (r0.length > 0) {
      connection.query(
        'select * from `' + tableName + '` order by No limit ' + n + ', ' + pageSize,   // 从第n条数据开始，取pageSize条数据
        (e, r1) => {
          // console.log(e, r1);
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
  let searchParams = req.query.keywords;
  let pageNo = req.query.pageNo;
  let pageSize = 5;
  let n = (pageNo - 1) * pageSize;
  let tableName = req.query.tableName
  // console.log(req.query);
  let sql1 =
    "select * from `" + tableName + "` where concat(`Title`,`Time`,`Owner`,`HouseNumber`,`No`,`Overall`,`FailReason`) like '%" +
    searchParams +
    "%'";
  let sql2 =
    "select * from `" + tableName + "` where concat(`Title`,`Time`,`Owner`,`HouseNumber`,`No`,`Overall`,`FailReason`) like '%" +
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
router.post("/newInspectation", (req, res) => {  // 添加
  console.log(req.body);
  // console.log(req.body.form);
  let { Area, HouseNumber, ServeillanceSystem, EntranceGuard, FireSafety, Time, StaffName, Owner, Staff_ID, Sanitry, Other, Structural, Circuit, FailReason, Overall, Title } = req.body.form;
  let tableName = req.body.tableName
  let sql = "insert into `" + tableName + "`(Area, HouseNumber, ServeillanceSystem, EntranceGuard, FireSafety, Time, StaffName, Owner, Staff_ID, Sanitry, Other, Structural,Circuit, FailReason, Overall, Title,Note)  values('" + Area + "','" + HouseNumber + "','" + ServeillanceSystem + "','" + EntranceGuard + "','" + FireSafety + "','" + Time + "','" + StaffName + "','" + Owner + "','" + Staff_ID + "','" + Sanitry + "','" + Other + "','" + Structural + "','" + Circuit + "','" + FailReason + "','" + Overall + "','" + Title + "','')";
  console.log(sql);
  connection.query(sql, (e1, r1) => {
    console.log(e1, r1);
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
      // console.log(error,result);
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
  console.log(req.body);
  let { Area, Note, HouseNumber, ServeillanceSystem, EntranceGuard, FireSafety, Time, StaffName, Owner, Staff_ID, Sanitry, Other, Structural, Circuit, FailReason, Overall, Title, No } = req.body.form;
  let tableName = req.body.tableName
  let update = "update `" + tableName + "` set Note='" + Note + "',HouseNumber='" + HouseNumber + "',ServeillanceSystem='" + ServeillanceSystem + "',EntranceGuard='" + EntranceGuard + "',FireSafety='" + FireSafety + "',Time='" + Time + "',Owner='" + Owner + "',Sanitry='" + Sanitry + "',Other='" + Other + "',Structural='" + Structural + "',Circuit='" + Circuit + "',FailReason='" + FailReason + "',Overall='" + Overall + "',Title='" + Title + "' where No = " + No + "";
  // console.log(update);
  connection.query(update, (e, r1) => {
    // console.log(e, r1);
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
    console.log(e, r);
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
// 群众意见     opinion
router.get("/allOpinions", (req, res) => {  // 所有
  let pageSize = 5; // 页面默认展示 5 条数据，不可更改
  let pageNo = req.query.pageNo; // 默认 第一页
  let currentStaff_ID = req.query.ID
  console.log(req.query);
  connection.query(`select * from opinion where Staff_ID = '${currentStaff_ID}'`, (err, r0) => {
    console.log(err, r0);
    let n = (pageNo - 1) * pageSize;
    if (r0.length > 0) {
      connection.query(
        `select * from opinion where Staff_ID = '${currentStaff_ID}' order by 'No' limit ${n},${pageSize}`,   // 从第n条数据开始，取pageSize条数据
        (e, r1) => {
          console.log(e, r1);
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
router.get("/searchOpinions", (req, res) => {  // 搜索
  let searchParams = req.query.keywords;
  let pageNo = req.query.pageNo;
  let pageSize = 5;
  let n = (pageNo - 1) * pageSize;
  let currentStaff_ID = req.query.ID
  console.log(req.query);
  let sql1 =
    "select * from opinion where concat(`Name`,`No`,`Title`,`Time`,`StaffName`,`Detail`,`Category`,`Area`,`Status`) like '%" +
    searchParams +
    "%' and Staff_ID = '" + currentStaff_ID + "'";
  let sql2 =
    "select * from opinion where concat(`Name`,`No`,`Title`,`Time`,`StaffName`,`Detail`,`Category`,`Area`,`Status`) like '%" +
    searchParams +
    "%' and Staff_ID = '" + currentStaff_ID + "' limit " +
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
          msg: "模糊搜索群众意见",
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
        msg: "暂无相关群众意见",
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
router.post("/addOpinion", (req, res) => {  // 添加
  // console.log(req.body.staff);
  console.log(req.body);
  let { StaffName, StaffID } = req.body.staff
  console.log(req.body.form);
  let { Title, Category, Detail, Name, Time, Note, Area, AreaID } = req.body.form;
  if (Name == '') Name = '匿名'
  let sql = `insert into opinion(Title, Category, Detail, Name, Time, Note, Area, AreaID,Status,StaffName, Staff_ID)  values('${Title}','${Category}','${Detail}','${Name}','${Time}','${Note}','${Area}','${AreaID}','已上报','${StaffName}','${StaffID}')`;
  console.log(sql);
  connection.query(sql, (e1, r1) => {
    // console.log(e1, r1);
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
});
router.get("/opinionDetail", (req, res) => {  // 详情
  let No = req.query.No;
  connection.query(
    `select * from opinion where No = ${No}`,
    function (error, result) {
      console.log(error, result);
      res.send({
        code: 200,
        data: result,
        success: true,
        msg: `获取群众意见No：${No}的详情`,
      });
    }
  );
});
router.post("/updateOpinion", (req, res) => { // 编辑
  console.log(req.body.form);
  let { Title, Category, Detail, Name, Time, Note, Area, AreaID, No, Status } = req.body.form;
  if (Name == '') Name = '匿名'
  let update = `update opinion set Title='${Title}',Category='${Category}',Name='${Name}',Time='${Time}', Detail='${Detail}',Area='${Area}',AreaID='${AreaID}', Status='${Status}',Note='${Note}' where No = ${No}  `;
  console.log(update);
  connection.query(update, (e, r1) => {
    console.log(e, r1);
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
router.post("/deleteOpinion", (req, res) => { // 删除
  let No = req.body.No;
  connection.query(`delete from opinion where No = ${No}`, (e, r) => {
    // console.log(r);
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
// 问题报告     problem   Problems
router.get("/allProblems", (req, res) => {  // 所有
  let pageSize = 5; // 页面默认展示 5 条数据，不可更改
  let pageNo = req.query.pageNo; // 默认 第一页
  let currentStaff_ID = req.query.ID
  console.log(req.query);
  connection.query(`select * from problem where Staff_ID = '${currentStaff_ID}'`, (err, r0) => {
    console.log(err, r0);
    let n = (pageNo - 1) * pageSize;
    if (r0.length > 0) {
      connection.query(
        `select * from problem where Staff_ID = '${currentStaff_ID}' order by 'No' limit ${n},${pageSize}`,   // 从第n条数据开始，取pageSize条数据
        (e, r1) => {
          console.log(e, r1);
          res.send({
            code: 200,
            success: true,
            msg: "获取所有问题报告",
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
        msg: "无问题报告",
        total: r0.length,
        pageSize,
        pageNo,
      });
    }
  });
});
router.get("/searchProblems", (req, res) => {  // 搜索
  let searchParams = req.query.keywords;
  let pageNo = req.query.pageNo;
  let pageSize = 5;
  let n = (pageNo - 1) * pageSize;
  let currentStaff_ID = req.query.ID
  console.log(req.query);
  let sql1 =
    "select * from problem where concat(`OwnerName`,`No`,`Title`,`Time`,`StaffName`,`Detail`,`Category`,`Area`,`Status`) like '%" +
    searchParams +
    "%' and Staff_ID = '" + currentStaff_ID + "'";
  let sql2 =
    "select * from problem where concat(`OwnerName`,`No`,`Title`,`Time`,`StaffName`,`Detail`,`Category`,`Area`,`Status`) like '%" +
    searchParams +
    "%' and Staff_ID = '" + currentStaff_ID + "' limit " +
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
          msg: "模糊搜索问题报告",
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
        msg: "暂无相关问题报告",
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
router.post("/newProblem", (req, res) => {  // 添加
  console.log(req.body);
  let { StaffName, StaffID } = req.body.staff
  // console.log(req.body.form);
  let { Title, Category, Detail, OwnerName, Time, HouseNumber, Note, Area, AreaID, Status, No } = req.body.form;
  let lookup = `select Admin_ID from Administrator where Name = '${OwnerName}'`
  // console.log(lookup);
  connection.query(lookup, (e0, r0) => {
    console.log(e0, r0);
    if (r0.length > 0) {
      let Landlord_ID = r0[0].Admin_ID
      // console.log(Landlord_ID);
      let sql = `insert into problem(Title, Category, Detail, HouseNumber,OwnerName, Time, Note, Area, AreaID,Status,StaffName, Staff_ID,Landlord_ID)  values('${Title}','${Category}','${Detail}','${HouseNumber}','${OwnerName}','${Time}','${Note}','${Area}','${AreaID}','已上报','${StaffName}','${StaffID}','${Landlord_ID}')`;
      console.log(sql);
      connection.query(sql, (e1, r1) => {
        // console.log(e1, r1);
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
router.post("/ModifyProblem", (req, res) => { // 编辑
  console.log(req.body.form);
  let { Title, Category, Detail, OwnerName, Time, HouseNumber, Note, Area, AreaID, Status, No } = req.body.form;
  let update = `update problem set Title='${Title}',Category='${Category}',Time='${Time}', Detail='${Detail}',HouseNumber='${HouseNumber}',OwnerName='${OwnerName}', Status='${Status}',Note='${Note}' where No = ${No}  `;
  console.log(update);
  connection.query(update, (e, r1) => {
    // console.log(e, r1);
    if (r1.affectedRows > 0) {
      res.send({
        code: 200,
        success: true,
        msg: "编辑问题报告成功",
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
router.get('/getOwnerName', (req, res) => {  // 获取administrator中的landlord 姓名列
  let AreaID = req.query.AreaID
  connection.query(`select Name from administrator where Role = "landlord" and AreaID = ${AreaID} `, (e0, r0) => {
    // console.log(r0);
    res.send({
      code: 200,
      msg: "获取屋主姓名列表",
      success: true,
      data: r0,
    })
  })
})
router.post("/deleteProblem", (req, res) => { // 删除
  let No = req.body.No;
  connection.query(`delete from problem where No = ${No}`, (e, r) => {
    // console.log(r);
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
router.get("/problemDetail", (req, res) => {  // 详情
  let No = req.query.No;
  connection.query(
    `select * from problem where No = ${No}`,
    function (error, result) {
      console.log(error, result);
      res.send({
        code: 200,
        data: result,
        success: true,
        msg: `获取问题报告No：${No}的详情`,
      });
    }
  );
});



// website
// 村庄资讯
router.get('/villageInfoByID', (req, res) => {    // By ID
  let { ID } = req.query
  console.log(ID);
  connection.query(`select * from website_staff where Staff_ID='${ID}'`, (e, r) => {
    console.log(e, r);
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
  console.log(No, Location, Contact, Area, AreaID, Brief, Office);
  // 修改区域内出租屋数量
  let sql = `select No from house where AreaID = '${AreaID}'`
  // console.log(sql);
  connection.query(sql, (e0, r0) => {
    console.log(e0, r0);
    let count = r0.length > 0 ? r0.length : 0
    connection.query(`update website_staff set Location='${Location}',Contact='${Contact}',Area='${Area}',Brief='${Brief}',Office='${Office}',HouseCount='${count}' where No='${No}'`, (e1, r1) => {
      console.log(e1, r1);
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
    console.log(e0, r0);
    connection.query(`update website_staff set IsCurrent = 1 where AreaID = '${AreaID}'`, (e1, r1) => {
      console.log(e1, r1);
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
    console.log(e3, r3);
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
    console.log(e0, r0);
    connection.query(`update website_landlord set IsCurrent = 1 where Landlord_ID = '${Landlord_ID}'`, (e1, r1) => {
      console.log(e1, r1);
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
  console.log(req.query);
  connection.query(`select * from website_landlord where IsCurrent = 1 and AreaID = '${AreaID}'`, (e3, r3) => {
    console.log(e3, r3);
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
  console.log(req.query);
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
  console.log(req.query);
  connection.query(`select * from website_landlord where Landlord_ID = '${ID}'`, (e, r) => {
    console.log(e, r);
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
  console.log(No, HouseNumber, Contact, LandlordName, More, Brief);
  connection.query(`update website_landlord set HouseNumber='${HouseNumber}',Contact='${Contact}',LandlordName='${LandlordName}',Brief='${Brief}',More='${More}' where No='${No}'`, (e1, r1) => {
    console.log(e1, r1);
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
  console.log(req.body);
  let { url, ID, coverSeq } = req.body
  connection.query(`update website_landlord set ${coverSeq}='${url}' where Landlord_ID ='${ID}'`, (e, r) => {
    console.log(e, r);
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
  console.log(req.query);
  let { tableName } = req.query
  connection.query('select * from `' + tableName + '`', (e, r) => {
    console.log(e, r);
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



// landlord 房东使用  
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
  let { Type, Amount, Furnishment, RoomNumber, Square, Price, MortgageCash, MortgageMethod, Picture } = req.body.form
  connection.query('insert into `' + tableName + '`(Type, Amount, Furnishment, RoomNumber, Square, Price, MortgageCash, MortgageMethod,Picture) values("' + Type + '","' + Amount + '","' + Furnishment + '","' + RoomNumber + '","' + Square + '","' + Price + '","' + MortgageCash + '","' + MortgageMethod + '","' + Picture + '")', (e, r) => {
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
  let { Type, Amount, RoomNumber, Furnishment, Square, Price, MortgageCash, MortgageMethod, No } = req.body.form
  let { tableName } = req.body
  connection.query('update `' + tableName + '` set Type="' + Type + '",Amount="' + Amount + '",RoomNumber="' + RoomNumber + '",Furnishment="' + Furnishment + '",Square="' + Square + '",Price="' + Price + '",MortgageCash="' + MortgageCash + '",MortgageMethod="' + MortgageMethod + '" where No = "' + No + '"', (e, r) => {
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
// 房间     let { tableName } = req.query   modifyRoom
router.get('/allRoom', (req, res) => {      // 所有房间
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
  console.log(req.body);
  let { tableName } = req.body
  let { RoomType, Rent, RoomNumber, Square, IsFurnished, MortgageCash, MinimunPeriod, RentStatus, ContractNo, TenantName, TenantIDCard, Note } = req.body.form
  connection.query('insert into `' + tableName + '`( RoomType, Rent, RoomNumber, Square, IsFurnished, MortgageCash,MinimunPeriod ,RentStatus,ContractNo,TenantName,TenantIDCard,Note) values("' + RoomType + '","' + Rent + '","' + RoomNumber + '","' + Square + '","' + IsFurnished + '","' + MortgageCash + '","' + MinimunPeriod + '","' + RentStatus + '","' + ContractNo + '","' + TenantName + '","' + TenantIDCard + '","' + Note + '")', (e, r) => {
    console.log(e, r);
    res.send({
      code: 200,
      success: true,
      msg: `${tableName} 新增房间成功`
    })
  })
})
router.get('/typeList', (req, res) => {       // 房型列表 and 按押方式
  console.log(req);
  let { tableName } = req.query
  connection.query('select MortgageMethod,Type from `' + tableName + '`', (e0, r0) => {
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
  console.log(req.query);
  let { tableName } = req.query
  connection.query('select No,TenantID,TenantName from `' + tableName + '`', (e0, r0) => {
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
  console.log(req.query);
  let { tableName, No } = req.query
  connection.query('delete from `' + tableName + '` where No = "' + No + '"', (e, r) => {
    console.log(e, r);
    if (r.affectedRows > 0) {
      res.send({
        code: 200,
        success: true,
        msg: "删除房间成功",
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
router.get("/searchRoom", (req, res) => {       // 搜索
  let searchParams = req.query.keywords;
  let pageNo = req.query.pageNo;
  let pageSize = 5;
  let n = (pageNo - 1) * pageSize;
  let tableName = req.query.tableName
  console.log(req.query);
  let sql1 =
    "select * from `" + tableName + "` where concat(`RoomNumber`,`RoomType`,`Rent`,`Square`,`No`,`MortgageCash`,`RentStatus`) like '%" +
    searchParams +
    "%'";
  let sql2 =
    "select * from `" + tableName + "` where concat(`RoomNumber`,`RoomType`,`Rent`,`Square`,`No`,`MortgageCash`,`RentStatus`) like '%" +
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
      // 搜不到
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
router.get('/detailRoom', (req, res) => {    // 获取   房型
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
router.post('/modifyRoom', (req, res) => {       // 修改 房型
  console.log(req.body);
  let { RoomType, Rent, RoomNumber, Square, IsFurnished, MortgageCash, MinimunPeriod, RentStatus, ContractNo, TenantName, TenantIDCard, Note, No } = req.body.form
  let { tableName } = req.body
  connection.query('update `' + tableName + '` set RoomType="' + RoomType + '",Rent="' + Rent + '",RoomNumber="' + RoomNumber + '",IsFurnished="' + IsFurnished + '",Square="' + Square + '",MinimunPeriod="' + MinimunPeriod + '",MortgageCash="' + MortgageCash + '",RentStatus="' + RentStatus + '",ContractNo="' + ContractNo + '",TenantName="' + TenantName + '",TenantIDCard="' + TenantIDCard + '",Note="' + Note + '" where No = "' + No + '"', (e, r) => {
    console.log(e, r);
    if (r.affectedRows > 0) {
      res.send({
        code: 200,
        success: true,
        msg: `成功修改房间信息 ${tableName}`
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
// 上报意见 
router.get('/getMyOpinion', (req, res) => {           //  获取我的意见
  console.log(req.query);
  let { pageNo, tableName, Landlord_ID } = req.query
  let pageSize = 5; // 页面默认展示 5 条数据，不可更改
  connection.query('select * from `' + tableName + '` where Landlord_ID = "' + Landlord_ID + '"', (e, r) => {
    console.log(e, r);
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
  console.log(req.body);
  let { tableName } = req.body
  let { Title, Category, Detail, LandlordName, Landlord_ID, SubmitTime, Status, StaffName, Staff_ID, Area, AreaID } = req.body.form
  let insert = 'insert into `' + tableName + '`(  Title, Category, Detail, LandlordName, Landlord_ID, SubmitTime, Status, StaffName, Staff_ID, Area, AreaID ) values("' + Title + '","' + Category + '","' + Detail + '","' + LandlordName + '","' + Landlord_ID + '","' + SubmitTime + '","' + Status + '","' + StaffName + '","' + Staff_ID + '","' + Area + '","' + AreaID + '")'
  console.log(insert);
  connection.query(insert, (e, r) => {
    console.log(e, r);
    res.send({
      code: 200,
      success: true,
      msg: `${tableName} 新增意见成功`
    })
  })
})
router.get('/deleteMyOpinion', (req, res) => {       // 删除
  console.log(req.query);
  let { tableName, No } = req.query
  connection.query('delete from `' + tableName + '` where No = "' + No + '"', (e, r) => {
    console.log(e, r);
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
  console.log(req.body);
  let { Title, Category, Detail, Status, No } = req.body.form
  let { tableName } = req.body
  connection.query('update `' + tableName + '` set Title="' + Title + '",Category="' + Category + '",Detail="' + Detail + '",Status="' + Status + '" where No = "' + No + '"', (e, r) => {
    console.log(e, r);
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
  console.log(req.query);
  let { tableName, keywords, pageNo } = req.query
  let pageSize = 5;
  let n = (pageNo - 1) * pageSize;
  let sql1 =
    "select * from `" + tableName + "` where concat(`Title`,`Category`,`Detail`,`LandlordName`,`No`,`SubmitTime`,`Status`,`Response`) like '%" +
    keywords +
    "%'";
  let sql2 =
    "select * from `" + tableName + "` where concat(`Title`,`Category`,`Detail`,`LandlordName`,`No`,`SubmitTime`,`Status`,`Response`) like '%" +
    keywords +
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
      // 搜不到
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
  console.log(req.query);
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


module.exports = router;
