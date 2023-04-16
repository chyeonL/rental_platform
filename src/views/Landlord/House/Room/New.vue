<template>
  <div id="roomtype_new">
    <Breadcrumb  :routes='routes'/>
    <div class="form">
      <el-form :model="form"
        label-position="left" 
        ref="form" 
        :status-icon='true'
        :rules='rules'
      >            
        <el-form-item prop='RoomNumber'>
           <label>房间号</label>
          <el-input v-model="form.RoomNumber"></el-input>
        </el-form-item>

        <el-form-item  prop='RoomType'>
           <label>房间类型</label>
          <el-select v-model="form.RoomType" clearable placeholder="请选择">
              <el-option v-for="(item, index) in typeList" :key="index" :label="item.Type" :value="item.Type"></el-option>
            </el-select>
        </el-form-item>   

        <el-form-item prop='Rent'>
           <label>房租</label>
          <el-input v-model="form.Rent" :placeholder="minimunRent"></el-input>
        </el-form-item>

        <el-form-item prop='MortgageCash'>
           <label>押金</label>
          <el-input v-model="form.MortgageCash"></el-input>
        </el-form-item>

        <el-form-item prop='MortgageMethod'>
           <label>按押方式</label>
          <el-input v-model="form.MortgageMethod" disabled></el-input>
        </el-form-item>

        <el-form-item prop='Square'>
           <label>房间面积（平方米）</label>
          <el-input v-model.number="form.Square"></el-input>
        </el-form-item>       

       <el-form-item prop='IsFurnished'>
           <label>房间配置</label>          
          <el-select v-model="form.IsFurnished" clearable placeholder="请选择">
              <el-option label="配置齐全" value="配置齐全"></el-option>
              <el-option label="有缺" value="有缺"></el-option>
            </el-select>
        </el-form-item>

        <el-form-item prop='MinimunPeriod'>
           <label>起租时长（月）</label>
          <el-input v-model="form.MinimunPeriod"></el-input>
        </el-form-item>

       <el-form-item prop='RentStatus'>
           <label>出租状态</label>     
          <el-input v-model="form.RentStatus" disabled></el-input> 
        </el-form-item>

        <el-form-item prop='Note'>
           <label>备注</label>
          <el-input type="textarea" v-model="form.Note" class="note"></el-input>
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
// import { mapState } from "vuex";
export default {
  name: "roomtype_new",
  components: { Breadcrumb },
  data() {
    return {
      routes: {
        nav: "出租房",
        parent: "房间管理",
        parentRoute: "all",
        children: "新增记录",
      },
      form: {
        RoomType: "",
        RoomNumber: "",
        Rent: "",
        MortgageCash: "",
        IsFurnished: "",
        MortgageMethod: "",
        Square: "",
        MinimunPeriod: "",
        RentStatus: "未出租",   // 新增时，默认未出租
        // ContractNo: "",
        // TenantName: "",
        // TenantIDCard: "",
        Note: "",
      },
      rules: {
        RoomNumber: [
          { required: true, message: "请输入房间号", trigger: "change" },
        ],
        RoomType: [{ required: true, message: "请选择", trigger: "change" }],
        Rent: [{ required: true, message: "请输入租金", trigger: "change" }],
        IsFurnished: [{ required: true, message: "请选择", trigger: "change" }],
        MortgageCash: [
          { required: true, message: "请输入押金", trigger: "change" },
        ],
        RentStatus: [{ required: true, message: "请选择", trigger: "change" }],
        Square: [{ required: true, message: "请输入面积", trigger: "change" }],
        MinimunPeriod: [
          { required: true, message: "请输入时长", trigger: "change" },
        ],
        // ContractNo: [{ required: true, message: "请选择", trigger: "change" }],
      },
      typeList: [], // 房型列表选择
      contractList: [], // 合同列表选择
      minimunRent:''
    };
  },
  mounted() {
    this.$store.dispatch("TypeList").then((res) => {
      this.typeList = res;
    });
    this.$notify({
      title:'限制',
      type:'warning',
      message:'新房间的出租状态默认为 未出租 ',
      offset:60,
      duration:3000
    })
    // this.$store.dispatch("ContractList").then((res) => {
    //   this.contractList = res;
    // });
  },
  watch: {
    form: {
      // 监听 form的合同编号，自动赋值 租客姓名、身份证号
      deep: true,
      handler(newValue) {
        // this.contractList.map((item) => {
        //   if (item.ContractNo == newValue.ContractNo) {
        //     this.form.TenantIDCard = item.TenantID;
        //     this.form.TenantName = item.TenantName;
        //   }
        // });
        this.typeList.map((item) => {
          if (item.Type == newValue.RoomType) {
            this.form.MortgageMethod = item.MortgageMethod;
            this.minimunRent = item.Price
          }
        });
      },
    },
  },
  methods: {
    // 新增
    submitForm(formName) {
      // console.log(this.form);
      this.$refs[formName].validate((valid) => {
        if (valid) {
          // console.log(this.form);
          this.$confirm("确认新增房间?", "确认新增", {
            confirmButtonText: "确定",
            cancelButtonText: "取消",
            center: true,
          })
            .then(() => {
              this.$store.dispatch("AddRoom", this.form).then((res) => {
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
        RoomType: "",
        RoomNumber: "",
        Rent: "",
        MortgageCash: "",
        IsFurnished: "",
        MortgageMethod: "",
        Square: "",
        MinimunPeriod: "",
        RentStatus: "未出租",
        ContractNo: "",
        TenantName: "",
        TenantIDCard: "",
        Note: "",
      }),
        this.$refs["form"].validate((valid) => {});
    }
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