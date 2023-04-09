<template>
  <div id="#Migrant_detail">
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
       <el-form-item prop='Name'>
           <label>姓名</label>
          <el-input v-model="form.Name" placeholder="请输入身份证上的姓名"></el-input>
        </el-form-item>

        <el-form-item  prop='ID'>
           <label>身份证号</label>
          <el-input v-model="form.ID" placeholder="请输入18位身份证号"></el-input>
        </el-form-item>

        <el-form-item  prop='Gender'>
           <label>性别</label>
           <el-select v-model="form.Gender" clearable placeholder="请选择" class="small">
              <el-option label="男" value="男"></el-option>
              <el-option label="女" value="女"></el-option>
            </el-select>
        </el-form-item>

        <el-form-item prop='Area'>
           <label for="Area">区域</label>
          <el-input v-model="form.Area" disabled class="small"></el-input>
        </el-form-item>

        <el-form-item prop='LandlordName'>
           <label for="LandlordName">房东</label>
            <el-select v-model="form.LandlordName" clearable placeholder="请选择">
              <el-option v-for="(item, index) in options" :key="index" :label="item.Name"  :value="item.Name"></el-option>
            </el-select>
        </el-form-item>

        <el-form-item prop='StaffName'>
           <label for="StaffName">对接工作人员</label>
          <el-input v-model="form.StaffName" disabled class="small"></el-input>
        </el-form-item>    

        <el-form-item prop='StartDate'>
            <label for="StartDate">来往时间</label>
            <el-date-picker
              type="date"
              placeholder="选择日期"
              value-format='yyyy-MM-dd'
              v-model="form.StartDate"              
            ></el-date-picker>
        </el-form-item>

        <el-form-item prop='EndDate'>
           <label for="EndDate">离开时间</label>
          <el-date-picker
              type="date"
              placeholder="选择日期"
              value-format='yyyy-MM-dd'
              v-model="form.EndDate"              
            ></el-date-picker>
        </el-form-item>

        <el-form-item prop='Marriage'>
           <label for="Marriage">婚育情况</label>
          <el-select v-model="form.Marriage" clearable placeholder="请选择" class="small">
              <el-option label="单身未育" value="单身未育"></el-option>
              <el-option label="已婚未育" value="已婚未育"></el-option>
              <el-option label="单身已育" value="单身已育"></el-option>
              <el-option label="已婚已育" value="已婚已育"></el-option>
            </el-select>
        </el-form-item>
        
        <el-form-item prop='Tel'>
           <label for="Tel">联系方式</label>
          <el-input v-model="form.Tel"></el-input>
        </el-form-item>

        <el-form-item prop='Birth'>
           <label for="Birth">出生日期</label>
          <el-date-picker
              type="date"
              placeholder="选择日期"
              value-format='yyyy-MM-dd'
              v-model="form.Birth"              
            ></el-date-picker>
        </el-form-item>

        <el-form-item prop='Origin'>
           <label for="Origin">籍贯</label>
          <el-input v-model="form.Origin"></el-input>
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
import {mapState} from 'vuex'
export default {
  name: "Migrant_detail",
  components: { Breadcrumb },
  data() {
    return {
      IsEdit: true, // true为 查阅模式
      routes: {
        // 面包屑导航 对象
        nav: "信息管理",
        parent: "流动人员",
        parentRoute: "all",
        children: "具体信息",
      },
      form: {
        Area: "",
        AreaID: "",
        Birth: "",
        EndDate: "",
        StartDate: "",
        Note: "",
        Tel: "",
        Origin: "",
        Name: "",
        StaffName: "",
        LandlordName: "",
        Marriage: "",
        ID: "",
        Gender: "",
      },
      rules: {
        ID: [
          { required: true, message: "请输入身份证号", trigger: "change" },
          {
            max: 18,
            min: 18,
            message: "请输入18位身份证号",
            trigger: "change",
          },
        ],
        Name: [
          { required: true, message: "请输入人员姓名", trigger: "change" },
        ],
        Tel: [{ required: true, message: "请输入联系方式", trigger: "change" }],
        LandlordName: [
          { required: true, message: "请选择", trigger: "change" },
        ],
        StartDate: [
          {
            required: true,
            message: "请选择时间",
            trigger: "change",
          },
        ],
        EndDate: [{ required: true, message: "请选择时间", trigger: "change" }],
        Birth: [{ required: true, message: "请选择时间", trigger: "change" }],
        Origin: [{ required: true, message: "请输入籍贯", trigger: "change" }],
        Marriage: [{ required: true, message: "请选择", trigger: "change" }],
        Gender: [{ required: true, message: "请选择", trigger: "change" }],
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
  computed:{
    ...mapState({
      StaffID:(state)=>state.Administrator.userInfo.Admin_ID
    })
  },
  methods: {
    // 编辑/查阅
    EditHandler() {
      this.IsEdit = !this.IsEdit;
      if (this.options.length < 1) {
        this.$store
          .dispatch("LandlordNameList", this.form.AreaID)
          .then((res) => {
            this.options = res;
            // console.log(this.options);
          });
      }
      if(this.IsEdit) this.getDetail();
    },

    // 获取详情
    getDetail() {
      this.$store
        .dispatch("migrantDetail", this.$route.query.No)
        .then((res) => {
          // console.log(res);
          this.form = res;
        });
    },

    // 提交表单
    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        // console.log(this.form);
        if (valid) {
          this.$confirm("确认提交该流动人员记录?", "确认编辑", {
            confirmButtonText: "确定",
            cancelButtonText: "取消",
            center: true,
          })
            .then(() => {
              this.$store.dispatch("ModifyMigrant", {form:this.form,staff:{StaffName:this.form.StaffName,StaffID:this.StaffID}}).then((res) => {
                // console.log(res);
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