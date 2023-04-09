<template>
  <div id="LOpinion_new">
    <Breadcrumb  :routes='routes'/>
    <div class="form">
      <el-form :model="form"
        label-position="left" 
        ref="form" 
        :status-icon='true'
        :rules='rules'
      >
       <el-form-item prop='Title'>
           <label>标题</label>
          <el-input v-model="form.Title" placeholder="请输入标题"></el-input>
        </el-form-item>

        <el-form-item  prop='Category'>
           <label>类别</label>
           <el-select v-model="form.Category" clearable placeholder="请选择">
              <el-option label="出租屋事务" value="出租屋事务"></el-option>
              <el-option label="相关管理" value="相关管理"></el-option>
              <el-option label="巡查工作" value="巡查工作"></el-option>
              <el-option label="流动人员" value="流动人员"></el-option>
              <el-option label="其他" value="其他"></el-option>
            </el-select>
        </el-form-item>

        <!-- <el-form-item  prop='Status'>
           <label>处理阶段</label>
           <el-select v-model="form.Status" clearable placeholder="请选择">
              <el-option label="等待反馈" value="等待反馈"></el-option>
              <el-option label="处理中" value="处理中"></el-option>
              <el-option label="接纳意见" value="接纳意见"></el-option>
              <el-option label="否决意见" value="否决意见"></el-option>
            </el-select>
        </el-form-item> -->

        <el-form-item prop='Area'>
           <label for="Area">区域</label>
          <el-input v-model="form.Area" disabled class="small"></el-input>
        </el-form-item>

        <!-- <el-form-item prop='AreaID'>
           <label for="AreaID">区域ID</label>
          <el-input v-model="form.AreaID" disabled class="small"></el-input>
        </el-form-item> -->

        <el-form-item prop='StaffName'>
           <label for="StaffName">对接工作人员</label>
          <el-input v-model="form.StaffName" disabled class="small"></el-input>
        </el-form-item>   

        <!-- <el-form-item prop='Staff_ID'>
           <label for="Staff_ID">对接工作人员ID</label>
          <el-input v-model="form.Staff_ID" disabled class="small"></el-input>
        </el-form-item>    -->
        
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
            ></el-date-picker>
        </el-form-item>

        <!-- <el-form-item prop='Landlord_ID'>
           <label for="Landlord_ID">反馈人ID</label>
          <el-input v-model="form.Landlord_ID" class="small"></el-input>
        </el-form-item>  -->
        
        <el-form-item prop='Detail'>
           <label for="Detail">详情</label>
          <el-input type="textarea" v-model="form.Detail" class="note"></el-input>
        </el-form-item>
        
        <el-form-item class="btns">
          <el-button type="success" @click="submitForm('form')" size="medium">提交</el-button>
          <el-button type="danger" @click="resetForm('form')">重置</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
import Breadcrumb from "@/components/common/Breadcrumb.vue";
import { mapState } from "vuex";
export default {
  name: "LOpinion_new",
  components: { Breadcrumb },
  data() {
    return {
      routes: {
        nav: "意见反馈",
        parent: "我的意见",
        parentRoute: "all",
        children: "新增意见",
      },
      form: {
        No: "",
        Title: "",
        Category: "",
        LandlordName: "",
        Landlord_ID: "",
        SubmitTime: "",
        Status: "",
        StaffName: "",
        Staff_ID: "",
        Area: "",
        AreaID: "",
      },
      rules: {
        Title: [{ required: true, message: "请输入标题", trigger: "change" }],
        Category: [{ required: true, message: "请选择", trigger: "change" }],
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
  computed: {
    ...mapState({
      LandlordName: (state) => state.Administrator.userInfo.Name,
      Landlord_ID: (state) => state.Administrator.adminID,
      StaffID: (state) => state.Administrator.userInfo.InChargeStaffID,
      StaffName: (state) => state.Administrator.userInfo.InChargeStaffName,
      Area: (state) => state.Administrator.userInfo.Area,
      AreaID: (state) => state.Administrator.userInfo.AreaID,
    }),
  },
  mounted() {
    this.form.Area = this.Area;
    this.form.AreaID = this.AreaID;
    this.form.StaffName = this.StaffName;
    this.form.Staff_ID = this.StaffID;
    this.form.LandlordName = this.LandlordName;
    this.form.Landlord_ID = this.Landlord_ID;
  },
  methods: {
    // 提交表单
    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          this.form.Status = "等待反馈";
          // console.log(this.form);
          this.$confirm("确认新增意见?", "确认新增", {
            confirmButtonText: "确定",
            cancelButtonText: "取消",
            center: true,
          })
            .then(() => {
              this.$store
                .dispatch("NewMyOpinion", this.form)
                .then((res) => {
                  this.$router.push("all");
                });
            })
            .catch(() => {});
        } else {
          this.$message.error("请完整输入！");
        }
      });
    },

    // 重置
    resetForm(formName) {
      (this.form = {
        No: "",
        Title: "",
        Category: "",
        LandlordName: this.LandlordName,
        Landlord_ID: this.Landlord_ID,
        SubmitTime: "",
        Status: "等待反馈",
        StaffName: this.StaffName,
        Staff_ID: this.Staff_ID,
        Area: this.Area,
        AreaID: this.AreaID,
      }),
        this.$refs["form"].validate((valid) => {});
    },
  },
};
</script>

<style lang="scss" scoped>
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
      justify-content: start;
      align-items: center;
    }
    label {
      display: inline-block;
      width: 140px;
      color: #1fa0ff;
      font-weight: 700;
      font-size: 15px;
    }
    .el-input,
    .el-textarea {
      width: 200px;
    }
    textarea {
      min-height: 40px;
    }
    .safety,
    .small {
      width: 130px;
    }
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