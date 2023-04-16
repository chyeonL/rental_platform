<template>
  <div id="Contract_detail">
    <header>
      <Breadcrumb  :routes='routes'/>
      <el-button icon="el-icon-edit" @click="EditHandler" v-show="IsEdit &&!IsEnd">编辑模式</el-button> 
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
        <el-form-item  prop='Room'>
           <label>房间号</label>
           <el-input v-model="form.Room" disabled></el-input>
        </el-form-item>        
        
        <el-form-item prop='Stage'>
           <label for="Stage">合同状态</label>
           <el-select v-model="form.Stage" clearable placeholder="请选择" class="small" :disabled='IsEnd'>
              <el-option label="租约中" value="租约中"></el-option>
              <el-option label="租约结束" value="租约结束"></el-option>
            </el-select>
        </el-form-item>
        
        <el-form-item prop='RoomType'>
           <label for="RoomType">房型</label>
           <el-input v-model="form.RoomType" disabled></el-input>
        </el-form-item>

       <el-form-item prop='TenantID'>
           <label>租客身份证号</label>
          <el-input v-model="form.TenantID" placeholder="请输入身份证号" disabled></el-input>
        </el-form-item>  

       <el-form-item prop='TenantName'>
           <label>租客姓名</label>
          <el-input v-model="form.TenantName" placeholder="请输入身份证上的姓名" disabled></el-input>
        </el-form-item>
        
        <el-form-item prop='Tel'>
           <label for="Tel">租客联系电话</label>   
          <el-input v-model="form.Tel" disabled></el-input>
        </el-form-item>

        <el-form-item prop='StartDate'>
            <label for="StartDate">起租日</label>
            <el-date-picker
              type="date"
              placeholder="选择日期"
              value-format='yyyy-MM-dd'
              v-model="form.StartDate"   
               disabled           
            ></el-date-picker>
        </el-form-item>

        <el-form-item prop='Term'>
           <label for="Term">租期</label>
          <el-input v-model="form.Term" class="small"   disabled></el-input>
        </el-form-item>  

        <el-form-item prop='Rent'>
           <label for="Rent">月租</label>
          <el-input v-model="form.Rent" disabled></el-input>
        </el-form-item>
        
        <el-form-item prop='MortgageMethod'>
           <label for="MortgageMethod">按押方式</label>
           <el-input v-model="form.MortgageMethod" disabled></el-input>
        </el-form-item>
        
        <el-form-item prop='MortgageCash'>
           <label for="MortgageCash">押金</label>
           <el-input v-model="form.MortgageCash" disabled></el-input>
        </el-form-item>
        
        <el-form-item prop='CollectionDate'>
           <label for="CollectionDate">收租日</label>
           <el-input v-model="form.CollectionDate" placeholder="每月 xx 号"  disabled></el-input>
        </el-form-item>
        
        <el-form-item prop='Population'>
           <label for="Population">实际租住人数</label>
          <el-input v-model="form.Population" class="small"  disabled></el-input>
        </el-form-item>
        
        <el-form-item prop='UnitWaterFee'>
           <label for="UnitWaterFee">单位水费(元/吨)</label>   
            <el-input v-model="form.UnitWaterFee"  disabled></el-input>
        </el-form-item>
        
        <el-form-item prop='UnitElectricityCharge'>
           <label for="UnitElectricityCharge">单位电费(元/度)</label>
          <el-input v-model="form.UnitElectricityCharge"  disabled></el-input>
        </el-form-item>
        
        <el-form-item prop='NetworkFee'>
           <label for="NetworkFee">网费</label>   
          <el-input v-model="form.NetworkFee"  disabled></el-input>
        </el-form-item>
        
        <el-form-item prop='PublicCleanFee'>
           <label for="PublicCleanFee">卫生费</label>
          <el-input v-model="form.PublicCleanFee"  disabled></el-input>
        </el-form-item>

        <el-form-item prop='Note'>
           <label for="Note">备注</label>
          <el-input type="textarea" v-model="form.Note" class="note"  disabled></el-input>
        </el-form-item>

        <el-form-item class="btns">
          <el-button type="success" @click="submitForm('form')" size="medium" v-if='!IsEnd'>提交</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
import Breadcrumb from "@/components/common/Breadcrumb.vue";
export default {
  name: "Contract_detail",
  components: { Breadcrumb },
  data() {
    return {
      IsEdit: true,
      routes: {
        nav: "签署合同",
        parent: "合同管理",
        parentRoute: "all",
        children: "合同详细",
      },
      form: {
        Room: "",
        RoomType: "",
        TenantID: "",
        TenantName: "",
        Population: "",
        StartDate: "",
        Term: "",
        Rent: "",
        MortgageMethod: "",
        MortgageCash: "",
        CollectionDate: "",
        PublicCleanFee: "",
        NetworkFee: "",
        UnitWaterFee: "",
        UnitElectricityCharge: "",
        Stage: "",
        Tel: "",
        Note: "",
      },
      rules: {
        Stage: [{ required: true, message: "请选择", trigger: "change" }],
      },
      IsEnd: false,
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
      message: "合同签署后，不可更改所有具体信息，只能更改合同状态",
    });
  },
  methods: {
    EditHandler() {
      this.IsEdit = !this.IsEdit;
      if (this.IsEdit) this.getDetail();
    },

    getDetail() {
      this.$store
        .dispatch("DetailContract", this.$route.query.No)
        .then((res) => {
          this.form = res;
          if (this.form.Stage === "租约结束") {
            this.IsEnd = true;
            this.$notify({
              title: "提醒",
              offset: 80,
              duration: 4000,
              type: "info",
              message: "合同处于租约结束状态，不可编辑",
            });
          }
        });
    },

    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          if (this.form.Stage === "租约结束")
            this.$confirm("确定结束租约?", "确认结束", {
              confirmButtonText: "确定",
              cancelButtonText: "取消",
              center: true,
            })
              .then(() => {
                this.$store
                  .dispatch("TerminateContract", {
                    No: this.form.No,
                    Room: this.form.Room,
                    RoomType: this.form.RoomType,
                  })
                  .then(() => {
                    this.EditHandler();
                    this.$router.go(0);
                  });
              })
              .catch(() => {});
          else {
            this.$notify({
              title: "限制",
              offset: 60,
              duration: 4000,
              type: "warning",
              message: "合同状态无变更",
            });
          }
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