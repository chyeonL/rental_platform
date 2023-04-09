<template>
  <div id="LWebsite">
    <header>
      <Breadcrumb  :routes='routes'/>
    </header>

    <div class="main">
        <div class="left">
            <!-- 描述列表  展示我的信息    direction="vertical" -->
            <el-descriptions :column="4" border label-class-name="my-label" :colon='true'>
                <el-descriptions-item label="门牌号" :span='2' >{{HouseInfo.HouseNumber}}</el-descriptions-item>
                <el-descriptions-item label="房东姓名" :span='2'>{{HouseInfo.LandlordName}}</el-descriptions-item>
                <el-descriptions-item label="村庄"  :span='2'>{{HouseInfo.Area}}</el-descriptions-item>
                <el-descriptions-item label="村庄ID" :span='2' >{{HouseInfo.AreaID}}</el-descriptions-item>
                <el-descriptions-item label="房东ID"  :span='4'>{{HouseInfo.Landlord_ID}}</el-descriptions-item>
                <el-descriptions-item label="联系电话" :span='4'>{{HouseInfo.Contact}}</el-descriptions-item>
                <el-descriptions-item label="更多资讯" :span='4' >{{HouseInfo.More}}</el-descriptions-item>
                <el-descriptions-item label="出租屋简介"  :span='4'>{{HouseInfo.Brief}}</el-descriptions-item>
            </el-descriptions>
            <!-- 编辑 -->
            <el-button icon="el-icon-edit" @click="Visible=true">修改网站资讯</el-button>     
        </div>      
      <div class="right">
        <!-- 出租屋banner -->
        <div class="cover">
          <div class="houseCover" @click="zoomin(HouseInfo.Cover1)">
            <div class="img" :style='{backgroundImage:`url(${HouseInfo.Cover1})`}'></div>
          </div>
          <div class="reload"><span @click='uploadHandler("Cover1")'>重新上传</span></div>
        </div>
        <div class="cover">
          <div class="houseCover"><div class="img" :style='{backgroundImage:`url(${HouseInfo.Cover2})`}'></div></div>
          <div class="reload"><span @click='uploadHandler("Cover2")'>重新上传</span></div>
        </div>
        <div class="cover">
          <div class="houseCover"><div class="img" :style='{backgroundImage:`url(${HouseInfo.Cover3})`}'></div></div>
          <div class="reload"><span @click='uploadHandler("Cover3")'>重新上传</span></div>
        </div>
        <div class="cover">
          <div class="houseCover"><div class="img" :style='{backgroundImage:`url(${HouseInfo.Cover4})`}'></div></div>
          <div class="reload"><span @click='uploadHandler("Cover4")'>重新上传</span></div>
        </div>
      </div>
    </div>

    <!-- 查看大图 -->
    <el-dialog :visible.sync="dialogVisible">
      <img width="100%" :src="dialogImageUrl" alt="">
    </el-dialog>

     <!-- 上传 -->
    <el-dialog
      width="30%"
      title="上传出租屋图片"
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


    <!-- 修改 -->
     <el-dialog
      title="出租资讯"
      :visible.sync="Visible"
      width="35%"
      center
      :lock-scroll='true'
    >
      <el-form
        :model="Info"
        status-icon
        ref="Info"
        label-width="100px"
        class="demo-ruleForm"
      >      
        <el-form-item label="门牌号" prop="HouseNumber">
          <el-input v-model="Info.HouseNumber"
            autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="房东姓名" prop="LandlordName">
          <el-input
            v-model="Info.LandlordName"
            autocomplete="off"
          ></el-input>
        </el-form-item>
        <el-form-item label="联系电话" prop="Contact">
          <el-input
            v-model="Info.Contact"
            autocomplete="off"
          ></el-input>
        </el-form-item>
        <el-form-item label="出租简介" prop="Brief">
          <el-input
            v-model="Info.Brief"
            autocomplete="off"
            type="textarea"
          ></el-input>
        </el-form-item>
        <el-form-item label="更多资讯" prop="More">
          <el-input
            v-model="Info.More"
            autocomplete="off"
            type="textarea"
          ></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitInfo('Info')"
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
import Breadcrumb from "@/components/common/Breadcrumb.vue";
import { mapState } from "vuex";
export default {
  name: "LWebsite",
  components: { Breadcrumb },
  data() {
    return {
      routes: {
        nav: "网站管理",
        parent: "出租资讯",
      },
      HouseInfo: {},
      Visible: false,
      Info: {
        // 修改的form
        HouseNumber: "",
        Contact: "",
        More: "",
        LandlordName: "",
        Brief: "",
      },
      dialogImageUrl: "",
      dialogVisible: false,
      uploadVisible: false,
      showProgress: false,
      percentage: 0,
      coverSeq: "", // 暂存要上传到的数据库表中的cover字段名
    };
  },
  computed: {
    ...mapState({
      userInfo: (state) => state.Administrator.userInfo,
      house: (state) => state.Website.house,
    }),
  },
  mounted() {
    this.$store
      .dispatch("GetHouseInfoByID", this.userInfo.Admin_ID)
      .then((res) => {
        this.HouseInfo = this.house;
        this.Info.No = this.house.No;
        this.Info.More = this.house.More;
        this.Info.Contact = this.house.Contact;
        this.Info.HouseNumber = this.house.HouseNumber;
        this.Info.Brief = this.house.Brief;
        this.Info.LandlordName = this.house.LandlordName;
      });
  },
  methods: {
    submitInfo(formName) {
      this.$refs[formName].validate((valid) => {
        console.log(this.Info);
        if (valid) {
          this.$confirm("确认修改出租屋资讯?", "确认修改", {
            confirmButtonText: "确定",
            cancelButtonText: "取消",
            center: true,
          })
            .then(() => {
              this.$store.dispatch("ModifyHouseInfo", this.Info).then(() => {
                this.Visible = true;
                this.$router.go(0);
              });
            })
            .catch(() => {});
        }
      });
    },
    uploadHandler(coverSeq) {
      this.uploadVisible = true;
      this.coverSeq = coverSeq;
    },
    // 上传图片
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
            console.log("上传的进度", JSON.stringify(progressData));
            this.percentage = progressData.percent * 100;
          },
        },
        (err, data) => {
          console.log(err);
          console.log(data);
          this.showProgress = false;
          // 上传成功之后
          if (data.statusCode === 200) {
            this.imgUrl = `https:${data.Location}`;
            console.log(this.imgUrl);
            this.$store
              .dispatch("UploadCover", {
                url: this.imgUrl,
                ID: this.userInfo.Admin_ID,
                coverSeq: this.coverSeq,
              })
              .then((res) => {
                this.$store
                  .dispatch("Login", {
                    // 重新登录，以获得更新的cover url
                    account: this.userInfo.UserName,
                    password: this.userInfo.UserPassword,
                  })
                  .then((res) => {
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
        this.$message.error("上传图片大小不能超过 5MB!");
      }
      return isJPG && isLt5M;
    },
    zoomin(src) {
      this.dialogImageUrl = src;
      this.dialogVisible = true;
    },
  },
};
</script>

<style lang="scss" scoped>
header {
  display: flex;
  align-items: center;
  justify-content: start;
  margin-bottom: 20px;
}
.main {
  width: 100%;
  display: flex;
  justify-content: space-between;
  margin-top: 50px;
  padding: 0 30px;
  .left {
    width: 50%;
    text-align: center;
    .el-descriptions {
      width: 100%;
      font-size: 15px;
      ::v-deep .my-label {
        width: 100px;
        color: #ffd04b;
        background-color: #24292e;
        text-align: center;
      }
    }
    ::v-deep .el-descriptions {
      border: 1px solid rgb(210, 210, 210);
    }
    .el-button {
      color: #ffd04b;
      background-color: #24292e;
      padding: 15px 25px;
      margin-top: 30px;
      border-radius: 15px;
      font-weight: 700;
      i {
        color: #1fa0ff;
        width: 100px;
      }
    }
  }
}
.right {
  width: 50%;
  height: 400px;
  display: flex;
  justify-content: space-around;
  margin: 0 30px;
  flex-wrap: wrap;
  .cover {
    width: 40%;
    text-align: center;
    background-color: #fff;
    margin-bottom: 30px;
    box-shadow: 0px 0px 20px 0px rgba(217, 212, 212, 0.5);
    .houseCover {
      width: 100%;
      height: 160px;
      position: relative;
      overflow: hidden;
      .img {
        width: 100%;
        height: 100%;
        position: absolute;
        top: 0;
        left: 0;
        background-position: 50%;
        background-size: cover;
      }
    }
    .reload {
      text-align: center;
      padding: 10px 0 5px 0;
      span {
        font-size: 12px;
        color: #3392f7;
      }
      span:hover {
        cursor: pointer;
      }
    }
  }
}
::v-deep .el-descriptions-row {
  height: 60px;
}
.houseCover:hover {
  cursor: pointer;
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
</style>