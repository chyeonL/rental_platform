<template>
  <div id="Contract_new">
    <Breadcrumb  :routes='routes'/>
    <div class="form">
       <el-form :model="form"
        label-position="left" 
        ref="form" 
        :status-icon='true'
        :rules='rules'
      >            
        <el-form-item  prop='Room'>
           <label>房间号</label>
          <el-select v-model="form.Room" clearable placeholder="请选择" class="small">
              <el-option v-for="(item, index) in roomList" :key="index" :label="item.RoomNumber" :value="item.RoomNumber"></el-option>
            </el-select>
        </el-form-item>        
              
        <el-form-item prop='Stage'>
           <label for="Stage">合同状态</label>
           <el-input v-model="form.Stage" disabled></el-input>
        </el-form-item>
        
        <el-form-item prop='RoomType'>
           <label for="RoomType">房型</label>
           <el-input v-model="form.RoomType" disabled></el-input>
        </el-form-item>

       <el-form-item prop='TenantID'>
           <label>租客身份证号</label>
          <el-input v-model="form.TenantID" placeholder="请输入身份证号"></el-input>
        </el-form-item>  

       <el-form-item prop='TenantName'>
           <label>租客姓名</label>
          <el-input v-model="form.TenantName" placeholder="请输入身份证上的姓名"></el-input>
        </el-form-item>
        
        <el-form-item prop='Tel'>
           <label for="Tel">租客联系电话</label>   
          <el-input v-model="form.Tel"></el-input>
        </el-form-item>

        <el-form-item prop='StartDate'>
            <label for="StartDate">起租日</label>
            <el-date-picker
              type="date"
              placeholder="选择日期"
              value-format='yyyy-MM-dd'
              v-model="form.StartDate"              
            ></el-date-picker>
        </el-form-item>

        <el-form-item prop='Term'>
           <label for="Term">租期</label>
          <el-input v-model="form.Term" class="small"></el-input>
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
           <el-input v-model="form.CollectionDate" placeholder="每月 xx 号"></el-input>
        </el-form-item>
        
        <el-form-item prop='Population'>
           <label for="Population">实际租住人数</label>
          <el-input v-model="form.Population" class="small"></el-input>
        </el-form-item>
        
        <el-form-item prop='UnitWaterFee'>
           <label for="UnitWaterFee">单位水费(元/吨)</label>   
            <el-input v-model="form.UnitWaterFee"></el-input>
        </el-form-item>
        
        <el-form-item prop='UnitElectricityCharge'>
           <label for="UnitElectricityCharge">单位电费(元/度)</label>
          <el-input v-model="form.UnitElectricityCharge"></el-input>
        </el-form-item>
        
        <el-form-item prop='NetworkFee'>
           <label for="NetworkFee">网费</label>   
          <el-input v-model="form.NetworkFee"></el-input>
        </el-form-item>
        
        <el-form-item prop='PublicCleanFee'>
           <label for="PublicCleanFee">卫生费</label>
          <el-input v-model="form.PublicCleanFee"></el-input>
        </el-form-item>

        <el-form-item prop='Note'>
           <label for="Note">备注</label>
          <el-input type="textarea" v-model="form.Note" class="note"></el-input>
        </el-form-item>

        <el-form-item class="btns">
          <el-button type="success" @click="submitForm('form')" size="medium">提交</el-button>
          <el-button type="danger" @click="resetForm()" size="medium">重置</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
import Breadcrumb from "@/components/common/Breadcrumb.vue";
export default {
  name: "Contract_new",
  components: { Breadcrumb },
  data() {
    return {
      routes: {
        nav: "签署合同",
        parent: "合同管理",
        parentRoute: "all",
        children: "新增合同",
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
        Stage: "租约中",
        Tel: "",
        Note: "",
      },
      rules: {
        TenantID: [
          {
            required: true,
            message: "请输入18位身份证号",
            trigger: "blur",
            max: 18,
            min: 18,
          },
        ],
        TenantName: [
          {
            required: true,
            message: "请输入身份证上的姓名",
            trigger: "blur",
          },
        ],
        NetworkFee: [
          { required: true, message: "请输入网费", trigger: "blur" },
        ],
        CollectionDate: [
          { required: true, message: "请输入每月收租日", trigger: "blur" },
        ],
        PublicCleanFee: [
          { required: true, message: "请输入卫生费", trigger: "blur" },
        ],
        Tel: [
          {
            required: true,
            message: "请输入联系电话",
            trigger: "blur",
            max: 11,
            min: 11,
          },
        ],
        Population: [
          { required: true, message: "请输入实际居住人数", trigger: "blur" },
        ],
        Term: [{ required: true, message: "请输入租期", trigger: "blur" }],
        StartDate: [{ required: true, message: "请选择时间", trigger: "blur" }],
        UnitWaterFee: [
          { required: true, message: "请输入单位水费", trigger: "blur" },
        ],
        UnitElectricityCharge: [
          { required: true, message: "请输入单位电费", trigger: "blur" },
        ],
        Room: [{ required: true, message: "请选择", trigger: "change" }],
        Stage: [{ required: true, message: "请选择", trigger: "change" }],
      },
      roomList: [],
      rent: 0,
      tenant: 0,
    };
  },
  watch: {
    form: {
      deep: true,
      handler(newValue) {
        this.roomList.map((item) => {
          if (item.RoomNumber == newValue.Room) {
            this.form.MortgageCash = item.MortgageCash;
            this.form.Rent = item.Rent;
            this.form.MortgageMethod = item.MortgageMethod;
            this.form.RoomType = item.RoomType;
          }
        });
      },
    },
  },
  mounted() {
    this.$store.dispatch("RoomList").then((res) => {
      this.roomList = res;
    });
  },
  methods: {
    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          // console.log(this.form);
          this.$confirm("确认新增合同?", "确认新增", {
            confirmButtonText: "确定",
            cancelButtonText: "取消",
            center: true,
          })
            .then(() => {
              this.$store.dispatch("AddContract", this.form).then(() => {
                this.$store
                  .dispatch(
                    "TenantNumber",
                    "tenant_" + this.$store.state.Administrator.adminID
                  )
                  .then(() => {
                    this.$store
                      .dispatch(
                        "RentNumber",
                        "rent_" + this.$store.state.Administrator.adminID
                      )
                      .then(() => {
                        this.$router.push("all");
                      });
                  });
              });
            })
            .catch(() => {});
        } else {
          this.$notify({
            title: "错误提醒",
            offset: 60,
            duration: 2000,
            type: "error",
            message: "请完整输入！",
          });
        }
      });
    },

    resetForm() {
      (this.form = {
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
        Stage: "租约中",
        Tel: "",
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