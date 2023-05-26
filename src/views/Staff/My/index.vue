<template>
  <div id="my">
     <header>
      <Breadcrumb  :routes='routes'/>
    </header>
    <div class="userInfo">
      <!-- 左上 上传头像 -->
      <div class="left">
        <div class="avatar">
          <div class="up">
            <div class="img" :style='{backgroundImage:`url(${avatar})`}'></div>
          </div>
        <div class="bottom">
            <h4>用户头像</h4>
            <p @click="uploadVisible=true">重新上传</p>  
        </div>        
      </div>
      <!-- 修改按钮 -->
      <div class="operations">        
        <el-button type="primary" round @click="info">修改信息</el-button>
        <el-button type="primary" round @click="password">修改密码</el-button>
      </div>
    </div>

      <!-- 描述列表  展示我的信息    direction="vertical" -->
      <el-descriptions :column="4" border label-class-name="my-label" :colon='true'>
        <el-descriptions-item label="名字"  content-class-name="my-content" :span='3'>{{userInfo.Name}}</el-descriptions-item>
        <el-descriptions-item label="角色" :span='1' >{{userInfo.Role === 'staff'?'工作人员':'房东'}}</el-descriptions-item>
        <el-descriptions-item label="管理员ID" :span='4'>{{userInfo.Admin_ID}}</el-descriptions-item>
        <el-descriptions-item label="账号" :span='4'>{{userInfo.UserName}}</el-descriptions-item>
        <el-descriptions-item label="密码" :span='4' >***</el-descriptions-item>
        <el-descriptions-item label="区域" :span='3'>{{userInfo.Area}}</el-descriptions-item>
        <el-descriptions-item label="区域ID" :span='1'>{{userInfo.AreaID}}</el-descriptions-item>
        <el-descriptions-item label="电话"  :span='3' label-class-name="my-label" content-class-name="my-content">{{userInfo.Tel}}</el-descriptions-item>
        <el-descriptions-item label="性别" :span='2'>{{userInfo.Gender}}</el-descriptions-item>
        <el-descriptions-item label="备注"  :span='4'>{{userInfo.Note}}</el-descriptions-item>
      </el-descriptions>
    </div>

    <!-- 上传头像 -->
    <el-dialog
      width="30%"
      title="上传头像"
      :visible.sync="uploadVisible"
      center
      class="upload"
      top="30vh"
      append-to-body
    >
       <el-upload
          class="upload-demo"
          ref="upload"
          action="#"
          :auto-upload="false"
          :before-upload="beforeAvatarUpload"
          :multiple='false'
          :show-file-list='false'
          :http-request="upload"
        >
          <el-button slot="trigger" size="small" type="primary">选择图片</el-button>
          <el-button
            style="margin-left: 50px"
            size="small"
            type="success"
            @click="submitUpload"
            >确定</el-button
          >
        </el-upload>
        <el-progress v-if="showProgress" :percentage="percentage" />
    </el-dialog>

    <!-- 密码 -->
    <el-dialog
      title="修改密码"
      :visible.sync="MyPwdVisible"
      width="35%"
      center
    >
      <el-form
        :model="ruleForm"
        status-icon
        ref="ruleForm"
        label-width="100px"
        class="demo-ruleForm"
      >      
        <el-form-item label="旧密码" prop="oldpwd">
          <el-input v-model="ruleForm.oldpwd" type="password"
            autocomplete="off" class=""></el-input>
        </el-form-item>
        <el-form-item label="新密码" prop="newpwd">
          <el-input
            type="password"
            v-model="ruleForm.newpwd"
            autocomplete="off"
          ></el-input>
        </el-form-item>
        <el-form-item label="重复密码" prop="checkPass">
          <el-input
            type="password"
            v-model="ruleForm.checkPass"
            autocomplete="off"
          ></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="resetForm('ruleForm')">重置</el-button>
        <el-button type="primary" @click="submitForm('ruleForm')"
          >确 定</el-button
        >
      </span>
    </el-dialog>

      <!-- 我的信息 -->
     <el-dialog
      title="我的信息"
      :visible.sync="MyInfoVisible"
      width="35%"
      center
      :lock-scroll='true'
    >
      <el-form
        :model="myInfo"
        status-icon
        ref="myInfo"
        label-width="100px"
        class="demo-ruleForm"
      >      
        <el-form-item label="名字" prop="Name">
          <el-input v-model="myInfo.Name"
            autocomplete="off" class=""></el-input>
        </el-form-item>
        <el-form-item label="账号" prop="UserName">
          <el-input
            v-model="myInfo.UserName"
            autocomplete="off"
          ></el-input>
        </el-form-item>
        <el-form-item label="电话" prop="Tel">
          <el-input
            v-model="myInfo.Tel"
            autocomplete="off"
          ></el-input>
        </el-form-item>
        <el-form-item label="性别" prop="Gender">
          <el-select v-model="myInfo.Gender" clearable placeholder="请选择" class="small">
              <el-option label="男" value="男"></el-option>
              <el-option label="女" value="女"></el-option>
            </el-select>
        </el-form-item>
        <el-form-item label="备注" prop="Note">
          <el-input
            v-model="myInfo.Note"
            autocomplete="off"
          ></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitMyInfo('myInfo')"
          >确 定</el-button
        >
      </span>
    </el-dialog>
    
  </div>
</template>

<script>
var COS = require("cos-js-sdk-v5");
var cos = new COS({
  SecretId: "AKIDGJ6ezIQO8dssd8MPGsOfjdIhrmTvHPLL", // 腾讯云份识别ID自己扫码查询
  SecretKey: "q9PRDl5NWUFnqnY5NQEyb7Ys2ziAKEsH", // 身份秘钥
});
import { mapState } from "vuex";
import Breadcrumb from "@/components/common/Breadcrumb.vue";
export default {
  name: "my",
  components: { Breadcrumb },
  data() {
    return {
      MyInfoVisible: false,
      MyPwdVisible: false,
      uploadVisible: false,
      routes: {
        nav: "设置",
        parent: "我的信息",
      },
      ruleForm: {
        // 密码
        oldpwd: "",
        checkPass: "",
        newpwd: "",
      },
      myInfo: {
        // 我的信息
        Name: "",
        Note: "",
        Tel: "",
        Gender: "",
        UserName: "",
      },
      imgUrl: "",
      avatar: "",
      showProgress: false,
      percentage: 20, // 上传进度条
    };
  },
  computed: {
    ...mapState({
      userInfo: (state) => state.Administrator.userInfo,
    }),
  },
  mounted() {
    this.myInfo.Name = this.userInfo.Name;
    this.myInfo.UserName = this.userInfo.UserName;
    this.myInfo.Tel = this.userInfo.Tel;
    this.myInfo.Note = this.userInfo.Note;
    this.myInfo.Gender = this.userInfo.Gender;
    this.avatar = this.userInfo.Avatar || "./NoAvatar.png";
  },
  methods: {
    upload(res) {
      console.log("上传的文件是", res.file);
      if (!res.file) {
        return;
      }
      this.showProgress = true; // 显示进度条
      // 1. 把图片上传到腾讯云COS
      // 执行上传操作
      cos.putObject(
        {
          Bucket: "liangchaoyan-1317602792" /* 存储桶 */,
          Region: "ap-guangzhou" /* 存储桶所在地域，必须字段 */,
          Key: res.file.name /* 文件名 */,
          StorageClass: "STANDARD", // 上传模式, 标准模式
          Body: res.file, // 上传文件对象
          onProgress: (progressData) => {
            // console.log("上传的进度", JSON.stringify(progressData));
            this.percentage = progressData.percent * 100;
          },
        },
        (err, data) => {
          // console.log(err);
          // console.log(data);
          this.showProgress = false;
          // 上传成功之后
          if (data.statusCode === 200) {
            this.imgUrl = `https:${data.Location}`;
            // console.log(this.imgUrl);
            this.$store
              .dispatch("uploadAvatar", {
                url: this.imgUrl,
                No: this.userInfo.No,
              })
              .then(() => {
                // console.log(res);
                this.$store
                  .dispatch("Login", {
                    account: this.userInfo.UserName,
                    password: this.userInfo.UserPassword,
                  })
                  .then(() => {
                    this.uploadVisible = false;
                    this.$router.go(0);
                  });
              });
          }
          this.showProgress = false;
        }
      );
    },
    // 触发 上传
    submitUpload() {
      this.$refs.upload.submit();
    },

    // 上传前检查
    beforeAvatarUpload(file) {
      let isJPG;
      if (
        file.type == "image/jpg" ||
        file.type == "image/jpeg" ||
        file.type == "image/png"
      )
        isJPG = true;
      const isLt5M = file.size / 1024 / 1024 < 5;

      if (!isJPG) {
        this.$message.error("请选择图片");
      }
      if (!isLt5M) {
        this.$message.error("上传头像图片大小不能超过 5MB!");
      }
      return isJPG && isLt5M;
    },

    // 点击出现 修改我的信息 弹窗
    info() {
      this.resetMyInfo();
      this.MyInfoVisible = true;
    },

    // 重置 我的信息
    resetMyInfo() {
      this.myInfo = {
        Name: this.userInfo.Name,
        UserName: this.userInfo.UserName,
        Tel: this.userInfo.Tel,
        Note: this.userInfo.Note,
        Gender: this.userInfo.Gender,
      };
    },

    // 提交 修改
    submitMyInfo() {
      // console.log(this.myInfo);
      if (
        !this.myInfo.Name ||
        !this.myInfo.UserName ||
        !this.myInfo.Tel ||
        !this.myInfo.Gender
      )
        return this.$message.error("请完整输入");
      else {
        this.$confirm("确认修改我的信息", "确认修改", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          center: true,
        })
          .then(() => {
            this.$store
              .dispatch("modifyInfo", {
                Name: this.myInfo.Name,
                UserName: this.myInfo.UserName,
                Tel: this.myInfo.Tel,
                Gender: this.myInfo.Gender,
                No: this.userInfo.No,
                Note: this.myInfo.Note,
              })
              .then((res) => {
                if (res.success) {
                  this.$store.dispatch("Login", {
                    account: this.userInfo.UserName,
                    password: this.userInfo.UserPassword,
                  });
                } else {
                  this.$message({
                    type: "error",
                    message: res.msg,
                  });
                }
                this.MyInfoVisible = false;
              });
          })
          .catch(() => {});
      }
    },

    // 修改密码
    password() {
      this.resetForm();
      this.MyPwdVisible = true;
    },

    resetForm() {
      this.ruleForm = {
        oldpwd: "",
        checkPass: "",
        newpwd: "",
      };
    },

    // 修改密码
    submitForm() {
      // console.log(this.ruleForm);
      if (
        !this.ruleForm.checkPass ||
        !this.ruleForm.newpwd ||
        !this.ruleForm.oldpwd
      )
        return this.$message.error("请完整输入");
      else {
        if (this.ruleForm.checkPass == this.ruleForm.newpwd) {
          // 发请求
          // console.log(this.ruleForm);
          let No = this.userInfo.No;
          let oldpwd = this.ruleForm.oldpwd;
          let newPwd = this.ruleForm.newpwd;
          this.$confirm("确认修改密码？", "确认修改", {
            confirmButtonText: "确定",
            cancelButtonText: "取消",
            center: true,
          })
            .then(() => {
              this.$store
                .dispatch("modifyPwd", { No, newPwd, oldpwd })
                .then((res) => {
                  this.MyPwdVisible = false;
                  if (res.success) {
                    setTimeout(() => {
                      this.$store.dispatch("Logout").then(() => {
                        this.$router.go(0);
                      });
                      this.$message({
                        type: "success",
                        message: res.msg + ",需要重新登录",
                      });
                    }, 1000);
                  } else {
                    this.$message({
                      type: "error",
                      message: res.msg,
                    });
                  }
                });
            })
            .catch(() => {});
        } else {
          return this.$message.error("两次输入的新密码不相同");
        }
      }
    },
  },
};
</script>

<style scoped lang='scss'>
header {
  display: flex;
  align-items: center;
  justify-content: start;
  margin-bottom: 20px;
}
.userInfo {
  display: flex;
  justify-content: space-around;
  margin: 30px;
}

.left {
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 280px;
}

.avatar {
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  align-items: center;
  width: 280px;
  height: 350px;
  box-shadow: 0px 0px 30px 0px rgba(0, 0, 0, 0.5);
  .up {
    position: relative;
    overflow: hidden;
    width: 100%;
    height: 300px;
  }
  .img {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-position: 50%;
    background-size: cover;
  }
  .bottom {
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 100%;
    padding: 15px 20px;
    box-sizing: border-box;
    h4 {
      font-weight: normal;
      padding-left: 90px;
    }
    p {
      font-size: 12px;
      color: #3392f7;
    }
    p:hover {
      cursor: pointer;
    }
  }
}

.operations {
  display: flex;
  align-items: center;
  margin-top: 50px;
  .el-button {
    margin: 15px;
    padding: 15px 30px;
    color: #ffd04b;
    background-color: #24292e;
    padding: 12px 25px;
    margin-left: 30px;
    border-radius: 15px;
    font-weight: 700;
    border: none;
    i {
      color: #66ff1f;
      width: 100px;
    }
  }
}

.el-descriptions {
  width: 55%;
  border-radius: 40px;
  ::v-deep .my-label {
    width: 90px;
    text-align: center;
    color: rgb(241, 208, 75);
    font-weight: 700;
    background-color: rgb(36, 41, 46);
  }
}

.el-dialog {
  border-radius: 40px;
}
.demo-ruleForm {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: space-around;
  padding-top: 20px;
  .el-input,
  .el-select {
    width: 200px;
    margin-left: 20px;
  }
}
.dialog-footer {
  .el-button {
    color: #ffd04b;
    background-color: #24292e;
    padding: 12px 25px;
    margin-left: 30px;
    border-radius: 15px;
    font-weight: 700;
    i {
      color: #1fa0ff;
      width: 100px;
    }
  }
}
::v-deep .el-dialog--center {
  text-align: center;
  border-radius: 15px;
}
.upload-demo {
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 30px;
}

::v-deep .el-dialog__body {
  padding: 30px;
}
::v-deep .el-dialog__footer {
  display: flex;
  align-items: center;
  justify-content: center;
}
::v-deep .el-descriptions-row {
  height: 60px;
}
</style>