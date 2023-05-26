<template>
  <div id="rent_new">
    <Breadcrumb  :routes='routes'/>
    <div class="form">
      <el-form :model="form"
        label-position="left" 
        ref="form" 
        :status-icon='true'
        :rules='rules'
      >
        <el-form-item prop='ContractNo'>
           <label>合同编号</label>
          <el-select v-model="form.ContractNo" clearable placeholder="请选择">
              <el-option v-for="(item,index) in contractList" :key="index" :label="item.No" :value="item.No"></el-option>
            </el-select>
        </el-form-item>

        <el-form-item prop='RoomNumber'>
           <label>房间号</label>
          <el-input v-model="form.RoomNumber" disabled></el-input>
        </el-form-item>

        <el-form-item  prop='Month'>
           <label>月份</label>
           <el-select v-model="form.Month" clearable placeholder="请选择" :disabled='!form.ContractNo' ref="month">
              <el-option v-for="(item,index) in months" :key="index" :label="item.No" :value="item"></el-option>
            </el-select>
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
          <el-select v-model="form.Stage" clearable placeholder="请选择"  :disabled='!form.ContractNo'>
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
          <el-input v-model="form.ActualAmount" :disabled='form.Stage!="已收"'></el-input>
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
          <el-input v-model="form.ElectricityMeterDegree"  :disabled='!form.ContractNo'></el-input>
        </el-form-item>        

        <el-form-item prop='WaterMeterDegree'>
           <label>水表吨数</label>
          <el-input v-model="form.WaterMeterDegree" :disabled='!form.ContractNo'></el-input>
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
          <el-button type="danger" @click="resetForm()">重置</el-button>
        </el-form-item>
      </el-form>   
    </div>
  </div>
</template>

<script>
import Breadcrumb from "@/components/common/Breadcrumb.vue";
export default {
  name: "rent_new",
  components: { Breadcrumb },
  data() {
    return {
      routes: {
        nav: "收入租金",
        parent: "月租",
        parentRoute: "all",
        children: "新增记录",
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
          { required: true, message: "请输入水表度数", trigger: "change" },
        ],
        ElectricityMeterDegree: [
          { required: true, message: "请输入电表度数", trigger: "change" },
        ],
        Stage: [{ required: true, message: "请选择", trigger: "change" }],
        ContractNo: [
          { required: true, message: "请选择合同编号", trigger: "change" },
        ],
      },
      contractList: [], // 合同列表选择
      months: [],
    };
  },
  watch: {
    form: {
      // 监听 form的合同编号，自动赋值 租客姓名、身份证号
      deep: true,
      handler(newValue, oldValue) {
        this.contractList.map((item) => {
          if (item.No == newValue.ContractNo) {
            this.form.RoomNumber = item.Room;
            this.form.ContractNo = item.No;
            this.form.ContractStage = item.Stage;
            this.form.ID = item.TenantID;
            this.form.Name = item.TenantName;
            this.form.CollectionDate = item.CollectionDate;
            this.form.MonthlyRent = item.Rent;
            this.form.HygieneFee = item.PublicCleanFee;
            this.form.NetworkFee = item.NetworkFee;
            this.form.UnitElectrictyFee = item.UnitElectricityCharge;
            this.form.UnitWaterFee = item.UnitWaterFee;
          }
        });
        if (newValue.ContractNo) {
          this.$store
            .dispatch("MonthsList", newValue.ContractNo)
            .then((res) => {
              this.months = res;
              // console.log(this.$refs.month.selected.value);
              this.form.Month = this.$refs.month.selected.value;
            });
        }
        this.form.WaterFee = (
          newValue.WaterMeterDegree * this.form.UnitWaterFee
        ).toFixed(2);
        this.form.ElectricityFee = (
          newValue.ElectricityMeterDegree * this.form.UnitElectrictyFee
        ).toFixed(2);
        if (this.form.NetworkFee)
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
  mounted() {
    this.$store.dispatch("ContractList").then((res) => {
      this.contractList = res;
    });
    this.$notify({
      title: "提醒",
      type: "warning",
      message: "请先选择合同编号",
      offset: 70,
      duration: 2000,
    });
  },
  computed: {
    required() {
      return this.form.Stage == "已收"
        ? [{ message: "请输入实收金额", trigger: "change", required: true }]
        : [];
    },
  },
  methods: {
    // 新增
    submitForm(formName) {
      //   console.log(this.form);
      this.$refs[formName].validate((valid) => {
        if (valid) {
          if (this.form.Stage == "未收") this.form.ActualAmount = "";
          // console.log(this.form);
          this.$confirm("确认新增月租记录?", "确认新增", {
            confirmButtonText: "确定",
            cancelButtonText: "取消",
            center: true,
          })
            .then(() => {
              this.$store.dispatch("AddRent", this.form).then((res) => {
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
    resetForm() {
      (this.form = {
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
        ElectricityMeterDegree:'',
        WaterMeterDegree: '',
        WaterFee: "",
        ElectricityFee: "",
        Note: "",
      }),
        (this.months = []);
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
    .el-textarea,
    .el-select {
      width: 130px;
    }
    textarea {
      min-height: 40px;
    }
    .note {
      width: 200px;
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