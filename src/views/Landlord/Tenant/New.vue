<template>
  <div id="Tenant_new">
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
           <el-select v-model="form.ContractNo" placeholder="">
            <el-option
              v-for="item in contractList"
              :key="item.No"
              :label="item.No"
              :value="item.No">
            </el-option>
           </el-select>
        </el-form-item>

        <el-form-item prop='ContractStage'>
           <label>合同状态</label>
          <el-input v-model="form.ContractStage" disabled></el-input>
        </el-form-item>    

        <el-form-item  prop='ID'>
           <label>身份证号</label>
          <el-input v-model="form.ID" disabled style="width:180px"></el-input>
        </el-form-item>   

        <el-form-item prop='Name'>
           <label>姓名</label>
          <el-input v-model="form.Name" disabled style="width:180px"></el-input>
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
          <el-button type="danger" @click="resetForm()">重置</el-button>
        </el-form-item>
      </el-form>  
    </div>
  </div>
</template>

<script>
import Breadcrumb from "@/components/common/Breadcrumb.vue";
export default {
  name: "Tenant_new",
  components: { Breadcrumb },
  data() {
    return {
      routes: {
        nav: "流动人员",
        parent: "租户",
        parentRoute: "all",
        children: "新增租户",
      },
      form: {
        RoomNumber: "",
        Term: "",
        ContractNo: "",
        ContractStage: "",
        ID: "",
        Name: "",
        Stage: "",
        Gender: "",
        Marriage: "",
        Origin: "",
        Status: "",
        ReportStatus: "未上报",
        StartDate: "",
        Note: "",
      },
      rules: {
        Origin: [{ required: true, message: "请输入籍贯", trigger: "change" }],
        Gender: [{ required: true, message: "请选择", trigger: "change" }],
        Marriage: [{ required: true, message: "请选择", trigger: "change" }],
        ContractNo: [{ required: true, message: "请选择", trigger: "change" }],
      },
      contractList: [], // 合同列表选择
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
            this.form.Term = item.Term;
            this.form.StartDate = item.StartDate;
          }
        });
        if (newValue.ContractNo) {
          this.$store
            .dispatch("MonthsList", newValue.ContractNo)
            .then((res) => {
              this.months = res;
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
    this.$message.warning("请先选择合同编号");
  },
  // computed: {
  //   required() {
  //     return this.form.Stage == "已收"
  //       ? [{ message: "请输入实收金额", trigger: "change", required: true }]
  //       : [];
  //   },
  // },
  methods: {
    // 新增
    submitForm(formName) {
      //   console.log(this.form);
      this.$refs[formName].validate((valid) => {
        if (valid) {
          console.log(this.form);
          this.$confirm("确认新增租户记录?", "确认新增", {
            confirmButtonText: "确定",
            cancelButtonText: "取消",
            center: true,
          })
            .then(() => {
              this.$store.dispatch("AddTenant", this.form).then((res) => {
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
        Term: "",
        ContractNo: "",
        ContractStage: "",
        ID: "",
        Name: "",
        Stage: "",
        Gender: "",
        Marriage: "",
        Origin: "",
        Status: "",
        ReportStatus: "未上报",
        StartDate: "",
        Note: "",
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