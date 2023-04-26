<template>
  <div id="Rent_detail">
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
        <el-form-item prop='RoomNumber'>
           <label>房间号</label>
          <el-input v-model="form.RoomNumber" disabled></el-input>
        </el-form-item>

        <el-form-item  prop='Month'>
           <label>月份</label>
          <el-input v-model="form.Month" disabled></el-input>
        </el-form-item>   

        <el-form-item prop='ContractNo'>
           <label>合同编号</label>
          <el-input v-model="form.ContractNo" disabled></el-input>
        </el-form-item>

        <el-form-item prop='ContractStage'>
           <label>合同状态</label>
          <el-input v-model="form.ContractStage" disabled></el-input>
        </el-form-item>          

        <el-form-item prop='Name'>
           <label>租户姓名</label>
          <el-input v-model="form.Name" disabled></el-input>
        </el-form-item>       

        <el-form-item prop='CollectionDate'>
           <label>收租日</label>
          <el-input v-model="form.CollectionDate" disabled></el-input>
        </el-form-item>

       <el-form-item prop='Stage'>
           <label>收租状态</label>          
          <el-select v-model="form.Stage" clearable placeholder="请选择">
              <el-option label="已收" value="已收"></el-option>
              <el-option label="未收" value="未收"></el-option>
            </el-select>
        </el-form-item>

        <el-form-item prop='ToalAmount'>
           <label>合计应收</label>
          <el-input v-model="form.ToalAmount" disabled></el-input>
        </el-form-item>    

        <el-form-item prop='ActualAmount' :rules='required'>
           <label>实收</label>
          <el-input v-model="form.ActualAmount" :disabled='form.Stage=="未收"'></el-input>
        </el-form-item>    

        <el-form-item prop='MonthlyRent'>
           <label>月租</label>
          <el-input v-model.number="form.MonthlyRent" disabled></el-input>
        </el-form-item>            
 
        <el-form-item prop='HygieneFee'>
           <label>卫生费</label>
          <el-input v-model.number="form.HygieneFee" disabled></el-input>
        </el-form-item>            
 

        <el-form-item prop='NetworkFee'>
           <label>网费</label>
          <el-input v-model.number="form.NetworkFee" disabled></el-input>
        </el-form-item>        
 
        <el-form-item prop='UnitElectrictyFee'>
           <label>单位电费(元/度)</label>
          <el-input v-model="form.UnitElectrictyFee" disabled></el-input>
        </el-form-item>            

        <el-form-item prop='UnitWaterFee'>
           <label>单位水费(元/吨)</label>
          <el-input v-model="form.UnitWaterFee" disabled></el-input>
        </el-form-item>         

        <el-form-item prop='ElectricityMeterDegree'>
           <label>电表度数</label>
          <el-input v-model="form.ElectricityMeterDegree"></el-input>
        </el-form-item>        

        <el-form-item prop='WaterMeterDegree'>
           <label>水表吨数</label>
          <el-input v-model="form.WaterMeterDegree"></el-input>
        </el-form-item>        

        <el-form-item prop='ElectricityFee'>
           <label>当月电费</label>
          <el-input v-model="form.ElectricityFee" disabled></el-input>
        </el-form-item>  

        <el-form-item prop='WaterFee'>
           <label>当月水费</label>
          <el-input v-model="form.WaterFee" disabled></el-input>
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
  name: "Rent_detail",
  components: { Breadcrumb },
  data() {
    return {
      IsEdit: true,
      routes: {
        nav: "收入租金",
        parent: "月租",
        parentRoute: "all",
        children: "具体数据",
      },
      form: {
        RoomNumber: "",
        Month: "",
        ContractNo: "",
        ContractStage: "",
        ID: "",
        Name: "",
        Stage: "",
        CollectionDate: "",
        ToalAmount: "",
        ActualAmount: "",
        MonthlyRent: "",
        HygieneFee: "",
        NetworkFee: "",
        UnitElectrictyFee: "",
        UnitWaterFee: "",
        ElectricityMeterDegree: "",
        WaterMeterDegree: "",
        WaterFee: "",
        ElectricityFee: "",
        Note: "",
      },
      rules: {
        WaterMeterDegree: [
          { required: true, message: "请输入水表度数", trigger: "blur" },
        ],
        ElectricityFee: [
          { required: true, message: "请输入电表度数", trigger: "blur" },
        ],
        Stage: [{ required: true, message: "请选择", trigger: "change" }],
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
      return this.form.Stage == "已收"
        ? [{ message: "请输入实收金额", trigger: "change", required: true }]
        : [];
    },
  },
  watch: {
    form: {
      deep: true,
      handler(newV) {
        // 计算费用
        this.form.WaterFee = (
          newV.WaterMeterDegree * this.form.UnitWaterFee
        ).toFixed(2);
        this.form.ElectricityFee = (
          newV.ElectricityMeterDegree * this.form.UnitElectrictyFee
        ).toFixed(2);
        this.form.ToalAmount = (
          parseFloat(this.form.WaterFee) +
          parseFloat(this.form.ElectricityFee) +
          parseFloat(this.form.NetworkFee) +
          parseFloat(this.form.HygieneFee) +
          parseFloat(this.form.MonthlyRent)
        ).toFixed(2);
      },
    },
  },
  methods: {
    // 编辑/查阅
    EditHandler() {
      this.IsEdit = !this.IsEdit;
      if (this.IsEdit) this.getDetail();
    },

    // 获取详情
    getDetail() {
      this.$store.dispatch("DetailRent", this.$route.query.No).then((res) => {
        this.form = res;
      });
    },

    // 修改
    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          if (
            typeof this.form.ActualAmount == "undefined" ||
            this.form.ActualAmount == "undefined"
          )
            this.form.ActualAmount = "";
          // console.log(this.form);
          this.$confirm("确认编辑月租记录?", "确认编辑", {
            confirmButtonText: "确定",
            cancelButtonText: "取消",
            center: true,
          })
            .then(() => {
              this.$store.dispatch("ModifyRent", this.form).then((res) => {
                this.$store.dispatch('RentNumber','rent_'+this.$store.state.Administrator.adminID)
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