<template>
  <div id="Tenant_detail">
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

        <el-form-item  prop='ID'>
           <label>身份证号</label>
          <el-input v-model="form.ID" disabled style="width:180px"></el-input>
        </el-form-item>   

        <el-form-item prop='Name'>
           <label>姓名</label>
          <el-input v-model="form.Name" disabled style="width:180px"></el-input>
        </el-form-item>      

        <el-form-item prop='ContractNo'>
           <label>合同编号</label>
          <el-input v-model="form.ContractNo" disabled></el-input>
        </el-form-item>

        <el-form-item prop='ContractStage'>
           <label>合同状态</label>
          <el-input v-model="form.ContractStage" disabled></el-input>
        </el-form-item>          

        <el-form-item prop='RoomNumber'>
           <label>房间号</label>
          <el-input v-model="form.RoomNumber" disabled></el-input>
        </el-form-item> 

        <el-form-item prop='StartDate'>
           <label>租约开始</label>
          <el-input v-model.number="form.StartDate" disabled></el-input>
        </el-form-item>            
 
        <el-form-item prop='Term'>
           <label>租期</label>
          <el-input v-model.number="form.Term" disabled></el-input>
        </el-form-item>    

       <el-form-item prop='Gender'>
           <label>性别</label>   
          <el-select v-model="form.Gender" clearable placeholder="请选择">
              <el-option label="男" value="男"></el-option>
              <el-option label="女" value="女"></el-option>
            </el-select>
        </el-form-item>

        <el-form-item prop='Marriage'>
           <label>婚育状况</label>
          <el-select v-model="form.Marriage" clearable placeholder="请选择">
              <el-option label="单身未育" value="单身未育"></el-option>
              <el-option label="单身已育" value="单身已育"></el-option>
              <el-option label="已婚未育" value="已婚未育"></el-option>
              <el-option label="已婚已育" value="已婚已育"></el-option>
            </el-select>
        </el-form-item>    

        <el-form-item prop='Origin'>
           <label>籍贯</label>
          <el-input v-model="form.Origin"></el-input>
        </el-form-item>            
 
        <el-form-item prop='ReportStatus'>
           <label>报备状态</label>
          <el-input v-model.number="form.ReportStatus" disabled></el-input>
        </el-form-item>        

        <el-form-item prop='Note'>
           <label>备注</label>
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
export default {
  name: "Tenant_detail",
  components: { Breadcrumb },
  data() {
    return {
      IsEdit: true,
      routes: {
        nav: "流动人员",
        parent: "租户",
        parentRoute: "all",
        children: "具体信息",
      },
      form: {
        RoomNumber: "",
        Term: "",
        ContractNo: "",
        ContractStage: "",
        ID: "",
        Name: "",
        Gender: "",
        Marriage: "",
        Origin: "",
        Status: "",
        ReportStatus: "",
        StartDate: "",
        Note: "",
      },
      rules: {
        Origin: [
          { required: true, message: "请输入籍贯", trigger: "change" },
        ],
        Gender: [{ required: true, message: "请选择", trigger: "change" }],
        Marriage: [{ required: true, message: "请选择", trigger: "change" }],
      },
    };
  },
  created() {
    this.getDetail();
  },
  mounted() {
    this.$refs.form.clearValidate();
    // this.$message.info('因为租户信息与合同')
  },
  methods: {
    // 编辑/查阅
    EditHandler() {
      this.IsEdit = !this.IsEdit;
      if (this.IsEdit) this.getDetail();
    },

    // 获取详情
    getDetail() {
      this.$store.dispatch("DetailTenant", this.$route.query.No).then((res) => {
        this.form = res;
      });
    },

    // 修改
    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          if (
            typeof this.form.Note == "undefined" ||
            this.form.Note == "undefined"||
            this.form.Note === null
          )
            this.form.Note = "";
          // console.log(this.form);
          this.$confirm("确认编辑租户记录?", "确认编辑", {
            confirmButtonText: "确定",
            cancelButtonText: "取消",
            center: true,
          })
            .then(() => {
              this.$store.dispatch("ModifyTenant", this.form).then((res) => {
                this.$store.dispatch('TenantNumber','tenant_'+this.$store.state.Administrator.adminID)
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
    .el-input,
    .el-textarea,
    .el-select {
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