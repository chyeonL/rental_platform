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
  // console.log(req.body);
  let { No, newPwd, oldpwd } = req.body
  connection.query(`select UserPassword from administrator where No = ${No}`, (e0, r0) => {
    // console.log(e0, r0);
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
  // console.log(req.body);
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
  // console.log(req.body);
  let { url, No } = req.body
  connection.query(`update administrator set Avatar = '${url}' where No = ${No}`, (e, r) => {
    // console.log(e, r);
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


module.exports = router;
