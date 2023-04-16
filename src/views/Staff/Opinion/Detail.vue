<template>
  <div id="SOpinion_detail">
    <header>
      <Breadcrumb  :routes='routes'/>
      <el-button icon="el-icon-edit" @click="EditHandler" v-show="IsEdit">编辑模式</el-button> 
      <el-button icon="el-icon-tickets" @click="EditHandler" v-show="!IsEdit">查阅模式</el-button>     
    </header>    
    
     <div class="form">
       <el-form :model="form"
        label-position="left" 
        ref="form" 
        :disabled='IsEdit?true:false'
        :status-icon='true'
        :rules='rules'
      >
       <el-form-item prop='Title'>
           <label>标题</label>
          <el-input v-model="form.Title" placeholder="请输入标题" disabled></el-input>
        </el-form-item>

        <el-form-item  prop='Category'>
           <label>类别</label>
           <el-select v-model="form.Category" clearable placeholder="请选择" disabled>
              <el-option label="出租屋事务" value="出租屋事务"></el-option>
              <el-option label="相关管理" value="相关管理"></el-option>
              <el-option label="巡查工作" value="巡查工作"></el-option>
              <el-option label="流动人员" value="流动人员"></el-option>
              <el-option label="其他" value="其他"></el-option>
            </el-select>
        </el-form-item>

        <el-form-item prop='Area'>
           <label for="Area">区域</label>
          <el-input v-model="form.Area" disabled class="small"></el-input>
        </el-form-item>

        <el-form-item prop='StaffName'>
           <label for="StaffName">对接工作人员</label>
          <el-input v-model="form.StaffName" disabled class="small"></el-input>
        </el-form-item>   
        
        <el-form-item prop='LandlordName'>
           <label for="LandlordName">反馈人</label>
          <el-input v-model="form.LandlordName" disabled class="small"></el-input>
        </el-form-item> 

        <el-form-item prop='SubmitTime'>
            <label for="SubmitTime">反馈时间</label>
            <el-date-picker
              type="date"
              placeholder="选择日期"
              value-format='yyyy-MM-dd'
              v-model="form.SubmitTime"      
              disabled        
            ></el-date-picker>
        </el-form-item>
        
        <el-form-item prop='Detail'>
           <label for="Detail">详情</label>
          <el-input type="textarea" v-model="form.Detail" class="note" disabled></el-input>
        </el-form-item>

        <el-form-item  prop='Status'>
           <label>处理阶段</label>
           <el-select v-model="form.Status" clearable placeholder="请选择">
              <el-option label="等待反馈" value="等待反馈"></el-option>
              <el-option label="处理中" value="处理中"></el-option>
              <el-option label="接纳意见" value="接纳意见"></el-option>
              <el-option label="否决意见" value="否决意见"></el-option>
            </el-select>
        </el-form-item>
        
        <el-form-item prop='Response'  :rules='required'>
           <label for="Response">回复</label>
          <el-input type="textarea" v-model="form.Response" class="note"></el-input>
        </el-form-item>

        <el-form-item class="btns">
          <el-button type="success" @click="submitForm('form')" size="medium">提交</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
import Breadcrumb from "@/components/common/Breadcrumb.vue";
export default {
  name: "SOpinion_detail",
  components: { Breadcrumb },
  data() {
    return {
      IsEdit: true, 
      routes: {
        nav: "群众意见",
        parent: "反馈回复",
        parentRoute: "all",
        children: "具体信息",
      },
      form: {
        No: "",
        Title: "",
        Category: "",
        LandlordName: "",
        Landlord_ID: "",
        SubmitTime: "",
        Status: "",
        Response: "",
        StaffName: "",
        Staff_ID: "",
        Area: "",
        AreaID: "",
      },
      rules: {
        Title: [{ required: true, message: "请输入标题", trigger: "change" }],
        Category: [{ required: true, message: "请选择", trigger: "change" }],
        Status: [{ required: true, message: "请选择", trigger: "change" }],
        Detail: [{ required: true, message: "请输入详情", trigger: "change" }],
        SubmitTime: [
          {
            required: true,
            message: "请选择时间",
            trigger: "change",
          },
        ],
      },
    };
  },
  created() {
    this.getDetail();
  },
  mounted() {
    this.$refs.form.clearValidate();
  },
  computed: {
    required() {
      return this.form.Status != "等待反馈"
        ? [{ message: "请回复", trigger: "change", required: true }]
        : [];
    },
  },
  methods: {
    EditHandler() {
      this.IsEdit = !this.IsEdit;
      if (this.IsEdit) this.getDetail();
    },

    getDetail() {
      this.$store
        .dispatch("OpinionDetail", this.$route.query.No)
        .then((res) => {
          this.form = res;
        });
    },

    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          this.$confirm("确认回复该意见?", "确认回复", {
            confirmButtonText: "确定",
            cancelButtonText: "取消",
            center: true,
          })
            .then(() => {
              this.$store.dispatch("ModifyOpinion", this.form).then((res) => {
                this.$store.dispatch(
                  "FeedbackNumber",
                  this.$store.state.Administrator.adminID + "_opinion"
                );
                this.EditHandler();
              });
            })
            .catch(() => {});
        }
      });
    },
  },
};
</script>

<style lang="scss" scoped>
header {
  display: flex;
  align-items: center;
  justify-content: start;
  // background-color: rgb(34, 77, 114);
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
</style>