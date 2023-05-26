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
        <el-form-item  prop='Title'>
           <label>标题</label>
          <el-input v-model="form.Title"></el-input>
        </el-form-item>        

       <el-form-item prop='Owner'>
           <label>屋主</label>
          <el-input v-model="form.Owner" disabled></el-input>
        </el-form-item>  

       <el-form-item prop='HouseNumber'>
           <label>门牌号</label>
          <el-input v-model="form.HouseNumber" disabled></el-input>
        </el-form-item>
        
        <el-form-item prop='Area'>
           <label for="Area">区域</label>
          <el-input v-model="form.Area" disabled class="small"></el-input>
        </el-form-item>

        <el-form-item prop='StaffName'>
           <label for="StaffName">工作人员</label>
          <el-input v-model="form.StaffName" disabled class="small"></el-input>
        </el-form-item>  

        <el-form-item prop='Time'>
            <label for="Time">巡查时间</label>
            <el-date-picker
              type="date"
              placeholder="选择日期"
              value-format='yyyy-MM-dd'
              v-model="form.Time"              
            ></el-date-picker>
        </el-form-item>

        <el-form-item  prop='Overall'>
           <label>总体巡查情况</label>
           <el-select v-model="form.Overall" clearable placeholder="请选择">
              <el-option label="合格" value="合格"></el-option>
              <el-option label="需整改" value="需整改"></el-option>
            </el-select>
        </el-form-item>  

        <el-form-item prop='FailReason' v-if="form.Overall === '需整改'">
           <label for="FailReason">不合格原因</label>
          <el-input v-model="form.FailReason"></el-input>
        </el-form-item>
        
        <el-form-item prop='EntranceGuard'>
           <label for="EntranceGuard">门禁</label>
          <el-select v-model="form.EntranceGuard" clearable placeholder="请选择" class="small">
              <el-option label="未安装" value="未安装"></el-option>
              <el-option label="已安装" value="已安装"></el-option>
            </el-select>
        </el-form-item>
        
        <el-form-item prop='ServeillanceSystem'>
           <label for="ServeillanceSystem">监控</label>
          <el-select v-model="form.ServeillanceSystem" clearable placeholder="请选择" class="small">
              <el-option label="未安装" value="未安装"></el-option>
              <el-option label="已安装" value="已安装"></el-option>
            </el-select>
        </el-form-item>
        
        <el-form-item prop='FireSafety'>
           <label for="FireSafety">消防安全</label>
          <el-select v-model="form.FireSafety" clearable placeholder="请选择" class="small">
              <el-option label="合格" value="合格"></el-option>
              <el-option label="存在隐患" value="存在隐患"></el-option>
            </el-select>
        </el-form-item>
        
        <el-form-item prop='Sanitry'>
           <label for="Sanitry">卫生状况</label>
          <el-select v-model="form.Sanitry" clearable placeholder="请选择" class="small">
              <el-option label="合格" value="合格"></el-option>
              <el-option label="存在隐患" value="存在隐患"></el-option>
            </el-select>
        </el-form-item>
        
        <el-form-item prop='Structural'>
           <label for="Structural">房屋整体结构</label>
          <el-select v-model="form.Structural" clearable placeholder="请选择" class="small">
              <el-option label="合格" value="合格"></el-option>
              <el-option label="存在隐患" value="存在隐患"></el-option>
            </el-select>
        </el-form-item>
        
        <el-form-item prop='Circuit'>
           <label for="Circuit">电路安全</label>
          <el-select v-model="form.Circuit" clearable placeholder="请选择" class="small">
              <el-option label="合格" value="合格"></el-option>
              <el-option label="存在隐患" value="存在隐患"></el-option>
            </el-select>
        </el-form-item>
        
        <el-form-item prop='Other'>
           <label for="Other">其他</label>
          <el-input v-model="form.Other"></el-input>
        </el-form-item>

        <el-form-item prop='Note'>
           <label for="Note">备注</label>
          <el-input type="textarea" v-model="form.Note" class="note"></el-input>
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
import { mapState } from "vuex";
export default {
  name: "Inspectation_detail",
  components: { Breadcrumb },
  data() {
    return {
      IsEdit: true, // true为 查阅模式
      routes: {
        nav: "安全检查",
        parent: "巡视记录",
        parentRoute: "all",
        children: "具体信息",
      },
      form: {
        Area: "",
        HouseNumber: "",
        ServeillanceSystem: "",
        EntranceGuard: "",
        Note: "",
        FireSafety: "",
        Time: "",
        StaffName: "",
        Owner: "",
        Staff_ID: "",
        Sanitry: "",
        Other: "",
        Structural: "",
        Circuit: "",
        FailReason: "",
        Overall: "",
        Title: "",
      },
      rules: {
        Title: [{ required: true, message: "请输入标题", trigger: "change" }],
        Owner: [
          {
            required: true,
            message: "请输入身份证上的姓名",
            trigger: "change",
          },
        ],
        HouseNumber: [
          { required: true, message: "请输入门牌号", trigger: "change" },
        ],
        FireSafety: [{ required: true, message: "请选择", trigger: "change" }],
        ServeillanceSystem: [
          { required: true, message: "请选择", trigger: "change" },
        ],
        EntranceGuard: [
          {
            required: true,
            message: "请选择",
            trigger: "change",
          },
        ],
        Time: [{ required: true, message: "请选择时间", trigger: "change" }],
        Structural: [{ required: true, message: "请选择", trigger: "change" }],
        Circuit: [{ required: true, message: "请选择", trigger: "change" }],
        Sanitry: [{ required: true, message: "请选择", trigger: "change" }],
        Overall: [{ required: true, message: "请选择", trigger: "change" }],
        FailReason: [{ required: true, message: "请选择", trigger: "change" }],
      },
      options: [],
    };
  },
  created() {
    this.getDetail();
  },
  mounted() {
    this.$refs.form.clearValidate();
  },
  computed: {
    ...mapState({
      StaffID: (state) => state.Administrator.userInfo.Admin_ID,
    }),
  },
  methods: {
    // 编辑/查阅
    EditHandler() {
      this.IsEdit = !this.IsEdit;
      if (this.IsEdit) this.getDetail();
    },

    // 获取详情
    getDetail() {
      this.$store
        .dispatch("InspectationDetail", this.$route.query.No)
        .then((res) => {
          this.form = res;
          // console.log(this.form);
        });
    },

    // 提交表单
    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        // console.log(this.form);
        if (valid) {
          this.$confirm("确认编辑巡视记录?", "确认编辑", {
            confirmButtonText: "确定",
            cancelButtonText: "取消",
            center: true,
          })
            .then(() => {
              this.$store
                .dispatch("ModifyInspectation", this.form)
                .then(() => {
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