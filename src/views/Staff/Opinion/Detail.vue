<template>
  <div id="SOpinion_detail">
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
        :disabled='IsEdit?true:false'
        :rules='rules'
      >
       <el-form-item prop='Title'>
           <label>标题</label>
          <el-input v-model="form.Title" placeholder="请输入标题"></el-input>
        </el-form-item>

        <el-form-item  prop='Category'>
           <label>类别</label>
           <el-select v-model="form.Category" clearable placeholder="请选择">
              <el-option label="出租屋" value="出租屋"></el-option>
              <el-option label="服务站管理" value="服务站管理"></el-option>
              <el-option label="活动" value="活动"></el-option>
              <el-option label="检查" value="检查"></el-option>
              <el-option label="其他" value="其他"></el-option>
            </el-select>
        </el-form-item>

        <el-form-item prop='Area'>
           <label for="Area">区域</label>
          <el-input v-model="form.Area" disabled class="small"></el-input>
        </el-form-item>

        <el-form-item  prop='Status'>
           <label>状态</label>
           <el-select v-model="form.Status" clearable placeholder="请选择" class="small">
              <el-option label="已上报" value="已上报"></el-option>
              <el-option label="处理中" value="处理中"></el-option>
              <el-option label="接纳" value="接纳"></el-option>
              <el-option label="否决" value="否决"></el-option>
            </el-select>
        </el-form-item>  

        <el-form-item prop='Time'>
            <label for="Time">提交时间</label>
            <el-date-picker
              type="date"
              placeholder="选择日期"
              value-format='yyyy-MM-dd'
              v-model="form.Time"              
            ></el-date-picker>
        </el-form-item>
        
        <el-form-item prop='Name'>
           <label for="Name">提交人(可以匿名)</label>
          <el-input v-model="form.Name" class="small"></el-input>
        </el-form-item> 

        <el-form-item prop='StaffName'>
           <label for="StaffName">对接工作人员</label>
          <el-input v-model="form.StaffName" disabled class="small"></el-input>
        </el-form-item> 
        
        <el-form-item prop='Detail'>
           <label for="Detail">详细</label>
          <el-input type="textarea" v-model="form.Detail" class="note"></el-input>
        </el-form-item>
        
        <el-form-item prop='Note'>
           <label for="Note">备注</label>
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
import { mapState } from "vuex";
export default {
  name: "SOpinion_detail",
  components: { Breadcrumb },
  data() {
    return {
      IsEdit: true, // true为 查阅模式
      routes: {
        nav: "收集报告",
        parent: "群众意见",
        parentRoute: "all",
        children: "具体信息",
      },
      form: {
        No: "",
        Title: "",
        Category: "",
        Detail: "",
        Name: "",
        Time: "",
        Status: "",
        Note: "",
        StaffName: "",
        Staff_ID: "",
        Area: "",
        AreaID: "",
      },
      rules: {
        Title: [{ required: true, message: "请输入标题", trigger: "change" }],
        Category: [{ required: true, message: "请选择", trigger: "change" }],
        Status: [{ required: true, message: "请选择", trigger: "change" }],
        Detail: [{ required: true, message: "请输入详情", trigger: "change" }],
        Time: [
          {
            required: true,
            message: "请选择时间",
            trigger: "change",
          },
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
  computed: {
    ...mapState({
      StaffName: (state) => state.Administrator.userInfo.Name,
      StaffID: (state) => state.Administrator.adminID,
      Area: (state) => state.Administrator.userInfo.Area,
      AreaID: (state) => state.Administrator.userInfo.AreaID,
    }),
  },
  methods: {
    // 编辑/查阅
    EditHandler() {
      this.IsEdit = !this.IsEdit;
      if (this.IsEdit) this.getDetail();
    },

    // 获取详情
    getDetail() {
      this.$store
        .dispatch("OpinionDetail", this.$route.query.No)
        .then((res) => {
          this.form = res;
          // console.log(this.form);
        });
    },

    // 提交表单
    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        // console.log(this.form);
        if (valid) {
          this.$confirm("确认编辑当前群众意见?", "确认编辑", {
            confirmButtonText: "确定",
            cancelButtonText: "取消",
            center: true,
          })
            .then(() => {
              this.$store
                .dispatch("ModifyOpinion", {
                  form: this.form,
                  staff: {
                    StaffName: this.form.StaffName,
                    StaffID: this.StaffID,
                  },
                })
                .then((res) => {
                  // console.log(res);
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