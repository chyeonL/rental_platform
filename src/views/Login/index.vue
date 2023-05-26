<template>
  <div id="login">
    <el-button type="primary" @click='goWebsite' class="goWebsite">
      <&nbsp;&nbsp;前台网站
    </el-button>
    <h1 class="title">乡村数字化出租屋管理平台</h1>
    <!-- 登录、注册 不共用，通过点击判断使用那个表单 -->
    <div class="login">
      <el-form
        :model="IsRegister?registerForm:ruleForm"
        :rules="IsRegister?rules2:rules"
        ref="form"
        label-width="60px"
        class="demo-ruleForm"
      >
        <h2 style="font-weight: normal; font-size: 18px">{{title}}</h2>
        <!-- 点击 修改文字 -->
        <span class="noAccount" @click="toggle">{{str}}</span>
        <!-- 注册 -->
        <el-form-item label="昵称" prop="name" v-show="IsRegister">
          <el-input
            type="text"
            placeholder="请输入昵称"
            v-model="registerForm.name"
            @keyup.enter.native="register()"
          ></el-input>
        </el-form-item>
        <el-form-item label="手机号" prop="tel" v-show="IsRegister">
          <el-input
            type="text"
            placeholder="请输入手机号"
            v-model="registerForm.tel"
            @keyup.enter.native="register()"
          ></el-input>
        </el-form-item>
        <el-form-item label="账号" prop="account" v-show="IsRegister">
          <el-input
            type="text"
            v-model="registerForm.account"
            placeholder="请输入账号/管理员ID/手机号"
            @keyup.enter.native="register()"
          ></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="password" v-show="IsRegister">
          <el-input
            type="password"
            placeholder="请输入密码"
            v-model="registerForm.password"
            @keyup.enter.native="register()"
          ></el-input>
        </el-form-item>
        <!-- 登录 -->
        <el-form-item label="账号" prop="account" v-show="!IsRegister">
          <el-input
            type="text"
            v-model="ruleForm.account"
            placeholder="请输入账号/管理员ID/手机号"
            @keyup.enter.native="submitForm()"
          ></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="password" v-show="!IsRegister">
          <el-input
            type="password"
            placeholder="请输入密码"
            v-model="ruleForm.password"
            @keyup.enter.native="submitForm()"
          ></el-input>
        </el-form-item>
        <el-form-item class="buttons">
          <el-button @click="resetForm()">重置</el-button>
          <el-button type="primary" class="goRegister" @click="register()" v-show="IsRegister">注册</el-button>
          <el-button type="primary" @click="submitForm()" class="goLogin" v-show="!IsRegister">
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
    var reg_tel =
      /^(13[0-9]|14[01456879]|15[0-35-9]|16[2567]|17[0-8]|18[0-9]|19[0-35-9])\d{8}$/; // 匹配中国大陆地区手机号码
    var reg_accpwd = /^(?=.*[A-Z])(?=.*\d).{6,15}$/;
    var validateaccount = (rule, value, callback) => {
      if (value === "") {
        callback(new Error("请输入账号"));
      } else if (!reg_accpwd.test(value)) {
        callback(
          new Error(
            "请输入6-15位账号，必须包含大写字母和阿拉伯数字"
          )
        );
      } else {
        callback();
      }
    };
    var validatePassword = (rule, value, callback) => {
      if (value === "") {
        callback(new Error("请输入密码"));
      } else if (!reg_accpwd.test(value)) {
        callback(
          new Error(
            "请输入6-15位密码，必须包含大写字母和阿拉伯数字"
          )
        );
      } else {
        callback();
      }
    };
    var validateTel = (rule, value, callback) => {
      if (value === "") {
        callback(new Error("请输入手机号"));
      } else if (!reg_tel.test(value)) {
        callback(new Error("请输入11位中国大陆地区的手机号码"));
      } else {
        callback();
      }
    };
    var validateName = (rule, value, callback) => {
      if (value === "") {
        callback(new Error("请输入昵称"));
      } else if (value.length < 3 || value.length > 8) {
        callback(new Error("请输入3-8位昵称"));
      } else {
        callback();
      }
    };
    return {
      ruleForm: {
        account: "",
        password: "",
        name: "",
        tel: "",
      },
      rules: {
        account: [{ validator: validateaccount, trigger: "blur" }],
        password: [{ validator: validatePassword, trigger: "blur" }],
      },
      IsRegister: false, // 是否注册
      registerForm: {
        account: "",
        password: "",
        name: "",
        tel: "",
      },
      rules2: {
        account: [{ validator: validateaccount, trigger: "change" }],
        password: [{ validator: validatePassword, trigger: "change" }],
        name: [{ validator: validateName, trigger: "change" }],
        tel: [{ validator: validateTel, trigger: "change" }],
      },
      str: "没有账号，先去注册(访客)",
      title:'登录'
    };
  },
  mounted() {
    this.$refs.form.clearValidate();
  },
  methods: {
    // 登录
    submitForm() {
      this.$refs["form"].validate((valid) => {
        if (valid) {
          // 登陆验证
          this.$store.dispatch("Login", this.ruleForm).then((res) => {
            // console.log(res);
            // 登陆成功
            if (res.code == 200) {
              this.$notify({
                title: "成功",
                offset: 60,
                duration: 2000,
                type: "success",
                message: "登陆成功！",
              });
              // console.log(this.$store.state.Administrator.role);
              // 跳转到被拦截的页面
              if (this.$route.query.redirect) {
                // console.log(this.$route.query.redirect);
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
              this.$notify({
                title: "错误提醒",
                offset: 60,
                duration: 2000,
                type: "error",
                message: res.msg,
              });
              this.resetForm();
            } else if (res.code == 205) {
              // 哪有这个账号
              this.$notify({
                title: "错误提醒",
                offset: 60,
                duration: 2000,
                type: "error",
                message: res.msg,
              });
              this.resetForm();
            }
          });
        } else {
          this.$notify({
            title: "错误提醒",
            offset: 60,
            duration: 2000,
            type: "error",
            message: "请完整输入",
          });
          return false;
        }
      });
    },

    // 注册
    register() {
      this.$refs["form"].validate((valid) => {
        console.log(this.registerForm);
        if (valid) {
          console.log(this.registerForm);
          this.$store.dispatch("register", this.registerForm).then((res) => {
            if (res.code == 200) {
              this.$notify({
                title: "成功",
                offset: 60,
                duration: 2000,
                type: "success",
                message: "注册成功！请登录...",
              });
              this.IsRegister = false;
            }
          });
        } else {
          this.$notify({
            title: "错误提醒",
            offset: 60,
            duration: 2000,
            type: "error",
            message: "请完整输入",
          });
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
      this.registerForm = {
        account: "",
        password: "",
        name: "",
        tel: "",
      };
    },

    // 前台网站
    goWebsite() {
      this.$router.replace("/");
    },

    toggle() {
      this.IsRegister = !this.IsRegister;
      this.str = this.IsRegister
        ? "已注册，前往登录"
        : "没有账号，先去注册(访客)";
      this.title = this.IsRegister
        ? "注册"
        : "登录";
      this.$refs.form.clearValidate();
    },
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
  position: relative;
  display: flex;
  flex-direction: column;
  justify-content: space-evenly;
  align-items: center;
  background-color: white;
  border-radius: 20px;
  h2 {
    width: 400px;
    padding: 20px 0;
    text-align: center;
  }

  .el-form-item {
    text-align: center;
    margin: 0 auto;
    font-size: 15px;
    padding: 20px 50px;
  }

  .buttons {
    .el-button {
      margin-right: 30px;
    }
  }

  .goLogin,
  .goRegister {
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
.noAccount {
  position: absolute;
  top: 37px;
  right: 14px;
  font-size: 12px;
  color: #dba000;
  border-bottom: 1px solid;
  &:hover {
    cursor: pointer;
  }
}
</style>
