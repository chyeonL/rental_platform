<template>
  <div id="login">
    <el-button type="primary" @click='goWebsite' class="goWebsite">
      <!-- <i class="'iconfont icon-guanfangwangzhan"></i> -->
      <&nbsp;&nbsp;前台网站
    </el-button>
    <h1 class="title">乡村数字化出租屋管理平台</h1>
    <div class="login">
      <el-form
        :model="ruleForm"
        :rules="rules"
        ref="ruleForm"
        label-width="50px"
        class="demo-ruleForm"
      >
        <h2 style="font-weight: normal; font-size: 18px">登录</h2>
        <el-form-item label="账号" prop="account">
          <el-input
            type="text"
            v-model="ruleForm.account"
            placeholder="请输入账号/管理员ID/手机号"
            @keyup.enter.native="submitForm()"
          ></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input
            type="password"
            placeholder="请输入密码"
            v-model="ruleForm.password"
            @keyup.enter.native="submitForm()"
          ></el-input>
        </el-form-item>
        <el-form-item class="buttons">
          <el-button @click="resetForm()">重置</el-button>
          <el-button type="primary" @click="submitForm()" class="goLogin">
            登录
          </el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
export default {
  name: "Login",
  data() {
    var validateaccount = (rule, value, callback) => {
      if (value === "") {
        callback(new Error("请输入账号/管理员ID/手机号"));
      } else {
        callback();
      }
    };
    var validatePassword = (rule, value, callback) => {
      if (value === "") {
        callback(new Error("请输入密码"));
      } else {
        callback();
      }
    };
    return {
      // 用户对象
      ruleForm: {
        account: "",
        password: "",
      },
      // 验证方法
      rules: {
        account: [{ validator: validateaccount, trigger: "blur" }],
        password: [{ validator: validatePassword, trigger: "blur" }],
      },
    };
  },
  methods: {
    submitForm() {
      this.$refs["ruleForm"].validate((valid) => {
        if (valid) {
          // 登陆验证
          this.$store.dispatch("Login", this.ruleForm).then((res) => {
            console.log(res);
            // 登陆成功
            if (res.code == 200) {
              this.$message.success(res.msg);
              console.log(this.$store.state.Administrator.role);
              // 跳转到被拦截的页面
              if (this.$route.query.redirect) {
                console.log(this.$route.query.redirect);
                this.$router.replace(`${this.$route.query.redirect}`);
              } else if (this.$store.state.Administrator.role) {
                this.$router.replace(this.$store.state.Administrator.role);
              } else {
                this.$router.replace("/");
                // this.$router.go(0)
              }
              // this.$router.go(0);
            } else if (res.code == 203) {
              // 密码错误
              this.$message.error(res.msg);
              this.resetForm();
            } else if (res.code == 205) {
              // 哪有这个账号
              this.$message.error(res.msg);
              this.resetForm();
            }
          });
        } else {
          this.$message.error("请完整输入");
          return false;
        }
      });
    },

    // 重置
    resetForm() {
      this.ruleForm = {
        account: "",
        password: "",
      };
    },

    // 前台网站
    goWebsite(){
      this.$router.replace("/")
      this.$router.go(0)
    }
  },
};
</script>

<style scoped lang="scss">
#login {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  width: 100vw;
  height: 100vh;
  min-height: 550px;
  background-color: #24292e;
}

.title {
  color: #ffe452;
  margin-bottom: 50px;
  font-size: 40px;
}

.login {
  display: flex;
  justify-content: center;
  align-items: center;
}

.demo-ruleForm {
  display: flex;
  flex-direction: column;
  justify-content: space-evenly;
  align-items: center;
  width: 400px;
  height: 300px;
  background-color: white;
  border-radius: 20px;

  .el-form-item {
    text-align: center;
    margin: 0 auto;
    font-size: 15px;
  }

  .buttons {
    .el-button {
      margin-right: 30px;
    }
  }

  .goLogin {
    color: #fff;
    background-color: #24292e;
  }
}
.goWebsite {
  position: absolute;
  top: 17px;
  left: 30px;
  margin: 15px;
  padding: 15px 30px;
  color: #000;
  background-color: #fff;
  padding: 12px 25px;
  margin-left: 30px;
  border-radius: 15px;
  font-weight: 700;
  border: none;
  i {
    color: #000;
    // width: 100px;
  }
}
</style>
