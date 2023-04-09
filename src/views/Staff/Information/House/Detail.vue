<template>
  <div id="#House_detail">
    <header>
      <Breadcrumb  :routes='routes'/>
      <el-button icon="el-icon-edit" @click="EditHandler" v-show="IsEdit">编辑模式</el-button> 
      <el-button icon="el-icon-tickets" @click="EditHandler" v-show="!IsEdit">查阅模式</el-button>     
    </header>    

    <div class="form">
      <el-form :model="houseForm" :rules="rules" 
        label-position="left" 
        ref="houseForm" 
        :disabled='IsEdit?true:false'
        :status-icon='true'
      >
        <el-form-item prop='HouseNumber'>
           <label for="HouseNumber">门牌号</label>
          <el-input v-model="houseForm.HouseNumber" placeholder="格式：[ xx巷 ] xx号"></el-input>
        </el-form-item>

        <el-form-item  prop='OwnerName'>
           <label for="OwnerName">屋主姓名</label>
          <el-input v-model="houseForm.OwnerName" placeholder="请输入身份证上的姓名"></el-input>
        </el-form-item>

        <el-form-item  prop='OwnerID'>
           <label for="OwnerID">屋主身份证号</label>
          <el-input v-model="houseForm.OwnerID" placeholder="请输入18位身份证号"></el-input>
        </el-form-item>

        <el-form-item prop='Landlord_ID'>
           <label for="Landlord_ID">房东</label>
            <el-select v-model="houseForm.Landlord_ID" clearable  filterable placeholder="请选择">
              <el-option
                v-for="item in options"
                :key="item.value"
                :label="item.label"
                :value="item.value">
              </el-option>
            </el-select>
        </el-form-item>

        <el-form-item prop='Area'>
           <label for="Area">区域</label>
          <el-input v-model="houseForm.Area" disabled class="small"></el-input>
        </el-form-item>

        <el-form-item prop='AreaID'>
           <label for="AreaID">区域ID</label>
          <el-input v-model="houseForm.AreaID" disabled class="small"></el-input>
        </el-form-item>

        <el-form-item prop='StaffName'>
           <label for="StaffName">对接工作人员</label>
          <el-input v-model="houseForm.StaffName" disabled class="small"></el-input>
        </el-form-item>

        <el-form-item prop='OverallSafetySituation'>
            <label for="OverallSafetySituation">房屋总体安全状况</label>
            <el-select v-model="houseForm.OverallSafetySituation" placeholder="请选择" class="safety">
              <el-option label="合格" value="合格"></el-option>
              <el-option label="存在隐患" value="存在隐患"></el-option>
          </el-select>
        </el-form-item>         

        <el-form-item prop='LastInspectedTime'>
            <label for="LastInspectedTime">上次巡查时间</label>
            <el-date-picker
              type="date"
              placeholder="选择日期"
              value-format='yyyy-MM-dd'
              v-model="houseForm.LastInspectedTime"              
            ></el-date-picker>
        </el-form-item>

        <el-form-item prop='CompletionTime'>
           <label for="CompletionTime">建成时间</label>
          <el-date-picker
              type="date"
              placeholder="选择日期"
              value-format='yyyy-MM-dd'
              v-model="houseForm.CompletionTime"              
            ></el-date-picker>
        </el-form-item>

        <el-form-item prop='Floors'>
           <label for="Floors">楼层数</label>
          <el-input v-model="houseForm.Floors" class="small"></el-input>
        </el-form-item>

        <el-form-item prop='Square'>
           <label for="Square">面积(平方米)</label>
          <el-input v-model="houseForm.Square" class="small"></el-input>
        </el-form-item>

        <el-form-item prop='Height'>
           <label for="Height">楼高(米)</label>
          <el-input v-model="houseForm.Height" class="small"></el-input>
        </el-form-item>

        <el-form-item prop='AvailableRooms'>
           <label for="AvailableRooms">可出租房间数量</label>
          <el-input v-model="houseForm.AvailableRooms" class="small"></el-input>
        </el-form-item>

        <el-form-item prop='Note'>
           <label for="Note">备注</label>
          <el-input type="textarea" v-model="houseForm.Note" class="note"></el-input>
        </el-form-item>

        <el-form-item class="btns">
          <el-button type="success" @click="submitForm('houseForm')" size="medium">提交</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
import Breadcrumb from "@/components/common/Breadcrumb.vue";
export default {
  name: "House_detail",
  components: { Breadcrumb },
  data() {
    return {
      IsEdit: true, // true为 查阅模式
      routes: {
        // 面包屑导航 对象
        nav: "信息管理",
        parent: "出租屋",
        parentRoute: "all",
        children: "具体信息",
      },
      houseForm: {
        // 表单数据对象
        HouseNumber: "",
        OwnerName: "",
        Landlord_ID: "",
        OwnerID: "",
        OverallSafetySituation: "",
        LastInspectedTime: "",
        StaffName: "",
        AreaID: "",
        Area: "",
        Square: "",
        CompletionTime: "",
        Height: "",
        Floors: "",
        AvailableRooms: "",
        Note: "",
      },
      rules: {
        // 不是必须的那也没必要写了
        HouseNumber: [
          { required: true, message: "请输入门牌号", trigger: "change" },
          { max: 10, message: "长度不少于 3 个字符", trigger: "change" },
        ],
        OwnerName: [
          { required: true, message: "请输入屋主姓名", trigger: "change" },
        ],
        OwnerID: [
          { required: true, message: "请输入身份证号", trigger: "change" },
          { max: 18, min: 18, message: "请输入18位身份证号", trigger: "change" },
        ],
        Landlord_ID: [{ required: true, message: "请选择", trigger: "change" }],
        OverallSafetySituation: [
          {
            required: true,
            message: "请选择",
            trigger: "change",
          },
        ],
        LastInspectedTime: [
          { required: true, message: "请选择时间", trigger: "change" },
        ],
        CompletionTime: [
          { required: true, message: "请选择时间", trigger: "change" },
        ],
        Floors: [{ required: true, message: "请输入楼层数", trigger: "change" }],
        Height: [{ required: true, message: "请输入楼高", trigger: "change" }],
        AvailableRooms: [
          { required: true, message: "请输入数量", trigger: "change" },
        ],
        Square: [{ required: true, message: "请输入面积", trigger: "change" }],
      },
      options: [],
    };
  },
  created() {
    // console.log(this.$route.query.No);
    this.getDetail();
  },
  mounted() {
    this.$refs.houseForm.clearValidate()
  },
  methods: {
    // 编辑/查阅
    EditHandler() {
      this.IsEdit = !this.IsEdit;
      if (this.options.length < 1) {
        this.$store
          .dispatch("LandlordIdList", this.houseForm.AreaID)
          .then((res) => {
            this.options = res;
          });
      }
      this.getDetail();
    },

    // 获取详情
    getDetail() {
      this.$store.dispatch("HouseDetail", this.$route.query.No).then((res) => {
        // console.log(res);
        this.houseForm = res;
        for (let key in this.houseForm) {
          if (this.houseForm[key] == "undefined") this.houseForm[key] = "";
        }
      });
    },

    // 提交表单
    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          // console.log(this.houseForm);
          this.$confirm("确认提交此出租屋记录?", "确认编辑", {
            confirmButtonText: "确定",
            cancelButtonText: "取消",
            center: true,
          })
            .then(() => {
              this.$store
                .dispatch("ModifyHouse", this.houseForm)
                .then((res) => {
                  // console.log(res);
                  this.EditHandler()
                });
            })
            .catch(() => {});
        }
      });
    }
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