<template>
  <div id="Booking_detail">
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
        <el-form-item prop='Roomtype'>
           <label>房型</label>
          <el-input v-model="form.Roomtype" disabled></el-input>
        </el-form-item> 

        <el-form-item prop='Time'>
           <label>预约看房时间</label>
          <el-date-picker
              type="date"
              placeholder="选择日期"
              value-format='yyyy-MM-dd'
              v-model="form.Time"      
              disabled        
            ></el-date-picker>
        </el-form-item>   
        
        <el-form-item  prop='BookingStatus'>
           <label>预约状态</label> 
          <el-select v-model="form.BookingStatus" clearable placeholder="请选择">
              <el-option label="提交预约" value="提交预约"></el-option>
              <el-option label="确认" value="确认"></el-option>
              <el-option label="拒绝" value="拒绝"></el-option>
              <el-option label="完成" value="完成"></el-option>
            </el-select>
        </el-form-item>     

        <el-form-item prop='Name'>
           <label>姓名</label>
          <el-input v-model="form.Name" disabled style="width:180px"></el-input>
        </el-form-item>      

        <el-form-item prop='Contact'>
           <label>联系电话</label>
          <el-input v-model="form.Contact" disabled></el-input>
        </el-form-item>     

       <el-form-item prop='Gender'>
           <label>性别</label>   
          <el-select v-model="form.Gender" clearable placeholder="请选择" disabled>
              <el-option label="男" value="男"></el-option>
              <el-option label="女" value="女"></el-option>
            </el-select>
        </el-form-item>

        <el-form-item prop='Requirement'>
           <label>详细需求</label>
          <el-input type="textarea" v-model="form.Requirement" class="note" disabled></el-input>
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
  name: "Booking_detail",
  components: { Breadcrumb },
  data() {
    return {
      IsEdit: true,
      routes: {
        nav: "预约看房",
        parent: "所有记录",
        parentRoute: "all",
        children: "具体信息",
      },
      form: {
        BookingStatus: "",
        ID: "",
        Name: "",
        Gender: "",
        Contact: "",
        Time: "",
        Requirement: "",
        Roomtype: "",
      },
      rules: {
        BookingStatus: [
          { required: true, message: "请选择", trigger: "change" },
        ],
      },
    };
  },
  created() {
    this.getDetail();
  },
  mounted() {
    this.$refs.form.clearValidate();
  },
  methods: {
    EditHandler() {
      this.IsEdit = !this.IsEdit;
      if (this.IsEdit) this.getDetail();
    },

    getDetail() {
      this.$store
        .dispatch("DetailBooking", this.$route.query.No)
        .then((res) => {
          this.form = res;
        });
    },

    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          this.$confirm("确认修改预约状态?", "确认修改", {
            confirmButtonText: "确定",
            cancelButtonText: "取消",
            center: true,
          }).then(() => {
            this.$store
              .dispatch("UpdateBookingStatus", {
                No: this.form.No,
                BookingStatus: this.form.BookingStatus,
              })
              .then(() => {
                this.$store.dispatch("ToBeConfirm");
                this.EditHandler();
              });
          });
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
    ::v-deep .el-date-editor {
      width: 160px;
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