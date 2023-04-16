<template>
  <div id="Inspectation_detail">
    <header>
      <Breadcrumb  :routes='routes'/>
      <el-button icon="el-icon-edit" @click="EditHandler" v-show="IsEdit">编辑模式</el-button> 
      <el-button icon="el-icon-tickets" @click="EditHandler" v-show="!IsEdit">查阅模式</el-button>     
    </header>    

    <div class="form">
      <el-form :model="form"
        label-position="left" 
        ref="form" 
        :status-icon='true'
        :rules='rules'
        :disabled='IsEdit===true?true:false'
      >            
        <el-form-item  prop='Type'>
           <label>房间类型</label>
          <el-input v-model="form.Type"></el-input>
        </el-form-item>      

       <el-form-item prop='Amount'>
           <label>房间总数</label>  
          <el-input v-model.number="form.Amount" disabled></el-input>
        </el-form-item>    

       <el-form-item prop='AvailableRoomsQuantity'>
           <label>未出租的房间数量</label>  
          <el-input v-model.number="form.AvailableRoomsQuantity" disabled></el-input>
        </el-form-item>  

       <el-form-item prop='Furnishment'>
           <label>房间配置</label>
          <el-input v-model="form.Furnishment"></el-input>
        </el-form-item>
        
        <el-form-item prop='RoomNumber'>
           <label>房间列表</label>
          <el-input v-model="form.RoomNumber" placeholder="通过新增/修改房间修改" disabled></el-input>
        </el-form-item>

        <el-form-item prop='Square'>
           <label>房型面积</label>
          <el-input v-model.number="form.Square"></el-input>
        </el-form-item>  

        <el-form-item prop='Price'>
           <label>房租</label>
          <el-input v-model="form.Price"></el-input>
        </el-form-item>

        <el-form-item prop='MortgageMethod'>
           <label>按押方式</label>
          <el-input v-model="form.MortgageMethod"></el-input>
        </el-form-item>
        
        <el-form-item prop='Picture' class="picture">
           <label>房型图片</label>
          <div class="imgWrapper" @click="dialogVisible = true">
            <div class="img" :style='{backgroundImage:`url(${form.Picture})`}'></div>
          </div>
          <div class="reload" @click="uploadVisible = true" v-show="!IsEdit">重新上传</div>
        </el-form-item>

        <el-form-item class="btns">
          <el-button type="success" @click="submitForm('form')" size="medium">提交</el-button>
        </el-form-item>
      </el-form>
      
        <!-- 查看大图 -->
        <el-dialog :visible.sync="dialogVisible">
          <img width="100%" :src="form.Picture" alt="">
        </el-dialog>
        
        <!-- 上传 -->
        <el-dialog
          width="30%"
          title="上传房型图片"
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
    </div>
  </div>
</template>

<script>
var COS = require("cos-js-sdk-v5");
var cos = new COS({
  SecretId: "AKIDGJ6ezIQO8dssd8MPGsOfjdIhrmTvHPLL", // 腾讯云份识别ID自己扫码查询
  SecretKey: "q9PRDl5NWUFnqnY5NQEyb7Ys2ziAKEsH", // 身份秘钥
});
import Breadcrumb from "@/components/common/Breadcrumb.vue";
export default {
  name: "Inspectation_detail",
  components: { Breadcrumb },
  data() {
    return {
      IsEdit: true,
      dialogVisible: false,
      uploadVisible: false,
      showProgress: false,
      percentage: 0,
      routes: {
        nav: "出租房",
        parent: "房间类型",
        parentRoute: "all",
        children: "具体记录",
      },
      form: {
        Type: "",
        Amount: 0,
        RoomNumber: "",
        Furnishment: "",
        Square: "",
        Price: "",
        MortgageCash: "",
        MortgageMethod: "",
        Picture: "",
        AvailableRoomsQuantity: 0,
      },
      rules: {
        Type: [{ required: true, message: "请输入房型", trigger: "change" }],
        // Amount: [
        //   { required: true, message: "请输入房间总数", trigger: "change" },
        // ],
        // AvailableRoomsQuantity: [
        //   { required: true, message: "请输入未出租的房间数量", trigger: "change" },
        // ],
        // RoomNumber: [
        //   { required: true, message: "请输入房间号", trigger: "change" },
        // ],
        Furnishment: [
          { required: true, message: "请输入配置", trigger: "change" },
        ],
        Square: [
          { required: true, message: "请输入房间面积", trigger: "change" },
        ],
        Price: [{ required: true, message: "请输入房租", trigger: "change" }],
        MortgageMethod: [
          { required: true, message: "请输入按押方式", trigger: "change" },
        ],
        Picture: [{ required: true, message: "请上传图片", trigger: "blur" }],
      },
    };
  },
  created() {
    this.getDetail();
  },
  mounted() {
    this.$refs.form.clearValidate();
    this.$notify({
      title: "限制",
      offset: 60,
      duration: 4000,
      type: "warning",
      message: "无法直接修改与房间号相关的信息",
    });
  },
  methods: {
    EditHandler() {
      this.IsEdit = !this.IsEdit;
      if (this.IsEdit) this.getDetail();
    },

    getDetail() {
      this.$store
        .dispatch("RoomTypeDetail", this.$route.query.No)
        .then((res) => {
          this.form = res;
        });
    },

    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          this.$confirm("确认编辑房间类型?", "确认编辑", {
            confirmButtonText: "确定",
            cancelButtonText: "取消",
            center: true,
          })
            .then(() => {
              this.$store.dispatch("ModifyRoomtype", this.form).then(() => {
                this.EditHandler();
              });
            })
            .catch(() => {});
        }
      });
    },

    // 上传图片
    upload(res) {
      // console.log("上传的文件是", res.file);
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
            this.form.Picture = `https:${data.Location}`;
            // console.log(this.form.Picture);
            this.$store
              .dispatch("TypePicture", {
                url: this.form.Picture,
                No: this.form.No,
              })
              .then(() => {
                this.uploadVisible = false;
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
  },
};
</script>

<style lang="scss" scoped>
header {
  display: flex;
  align-items: center;
  justify-content: start;
  .el-button {
    color: #ffd04b;
    background-color: #24292e;
    padding: 15px 25px;
    margin-left: 70px;
    margin-right: 200px;
    border-radius: 15px;
    font-weight: 700;
    i {
      color: #1fa0ff;
      width: 100px;
    }
  }
}

.form {
  margin: 30px 50px;
  border: 2px dotted black;
  background-color: white;
  border-radius: 50px;
  .el-form {
    display: flex;
    flex-wrap: wrap;
  }
  .el-form-item {
    display: flex;
    align-items: center;
    justify-content: start;
    box-sizing: border-box;
    width: 50%;
    padding-left: 70px;
    margin-top: 30px;
    .el-form-item__content {
      width: 100%;
      height: 100%;
      display: flex;
      justify-content: center;
      align-items: center;
    }
    label {
      display: inline-block;
      width: 140px;
      color: #1fa0ff;
      font-weight: 700;
      font-size: 15px;
    }
    .el-input {
      width: 200px;
    }
    .safety,
    .small {
      width: 130px;
    }
  }
  .try {
    width: 340px;
  }
  .btns {
    width: 100%;
    justify-content: space-between;
    .el-button {
      margin: 30px;
      padding: 15px 30px;
      font-size: 16px;
      border-radius: 4px;
    }
  }
}

.picture {
  height: 100px;
  ::v-deep .el-form-item__content {
    display: flex;
  }
  .imgWrapper {
    position: relative;
    width: 180px;
    height: 100px;
    overflow: hidden;
    box-shadow: 0px 0px 20px 0px rgba(217, 212, 212, 0.5);
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
  .reload {
    height: 20%;
    margin-left: 20px;
    font-size: 14px;
    color: #ffd04b;
    background-color: #24292e;
    padding: 0px 10px;
    border-radius: 15px;
    font-weight: 700;
  }
  .reload:hover {
    cursor: pointer;
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
</style>