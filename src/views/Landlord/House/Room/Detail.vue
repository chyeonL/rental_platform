<template>
  <div id="Room_detail">
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
          <el-input v-model="form.RoomNumber"></el-input>
        </el-form-item>

        <el-form-item  prop='RoomType'>
           <label>房间类型</label>
          <el-input v-model="form.RoomType" disabled></el-input>
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
          <el-select v-model="form.RentStatus" clearable placeholder="请选择" disabled>
              <el-option label="已出租" value="已出租"></el-option>
              <el-option label="未出租" value="未出租"></el-option>
            </el-select>
        </el-form-item>

        <el-form-item prop='ContractNo' v-if="form.RentStatus==='已出租'" :required="form.RentStatus==='已出租'">
           <label>合同编号</label>
          <el-input v-model="form.ContractNo" disabled></el-input>
          <!-- <el-select v-model="form.ContractNo" clearable placeholder="请选择" ref="contract">
              <el-option v-for="(item,index) in contractList" :key="index" :label="item.No" @change="handleChange(item)" :value="item.No"></el-option>
            </el-select> -->
        </el-form-item>

        <el-form-item prop='TenantName' v-if="form.RentStatus==='已出租'">
           <label>租客姓名</label>
          <el-input v-model="form.TenantName" disabled></el-input>
        </el-form-item>

        <el-form-item prop='TenantIDCard' v-if="form.RentStatus==='已出租'">
           <label>租客身份证号</label>
          <el-input v-model="form.TenantIDCard" disabled></el-input>
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
export default {
  name: "Room_detail",
  components: { Breadcrumb },
  data() {
    return {
      IsEdit: true,
      routes: {
        nav: "出租房",
        parent: "房间管理",
        parentRoute: "all",
        children: "具体信息",
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
        RentStatus: "",
        ContractNo: "",
        TenantName: "",
        TenantIDCard: "",
        Note: "",
      },
      rules: {
        RoomNumber: [
          { required: true, message: "请输入房间号", trigger: "change" },
        ],
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
        ContractNo: [{ required: true, message: "请选择", trigger: "change" }],
      },
      typeList: [], // 房型列表选择
      // contractList: [], // 合同列表选择
      minimunRent: "",
    };
  },
  created() {
    this.getDetail();
  },
  mounted() {
    this.$refs.form.clearValidate();
    this.$notify({
      type:'warning',
      title:'限制',
      message:'出租状态需要通过签署合同来自动修改',
      duration:3000,
      offset:80
    })
  },
  // watch: {
  //   form: {
  //     // 监听 form的合同编号，自动赋值 租客姓名、身份证号
  //     deep: true,
  //     handler(newValue) {
  //       this.contractList.map((item) => {
  //         if (item.No == newValue.ContractNo) {
  //           this.form.TenantIDCard = item.TenantID;
  //           this.form.TenantName = item.TenantName;
  //         }
  //       });
  //     },
  //   },
  // },
  methods: {
    // 编辑/查阅
    EditHandler() {
      this.IsEdit = !this.IsEdit;
      if (this.IsEdit) this.getDetail();
      // if (this.contractList.length == 0) {
      //   this.$store.dispatch("ContractList").then((res) => {
      //     this.contractList = res;
      //   });
      // }
    },

    // 获取详情
    getDetail() {
      this.$store.dispatch("DetailRoom", this.$route.query.No).then((res) => {
        this.form = res;
      });
    },

    // 修改
    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          // console.log(this.form);
          this.$confirm("确认编辑房间信息?", "确认编辑", {
            confirmButtonText: "确定",
            cancelButtonText: "取消",
            center: true,
          })
            .then(() => {
              this.$store.dispatch("ModifyRoom", this.form).then((res) => {
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