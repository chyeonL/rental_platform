<template>
  <div id="migrant_new">
    <Breadcrumb  :routes='routes'/>
    <div class="form">
      <el-form :model="form"
        label-position="left" 
        ref="form" 
        :status-icon='true'
        :rules='rules'
      >
       <el-form-item prop='Name'>
           <label>姓名</label>
          <el-input v-model="form.Name" placeholder="请输入身份证上的姓名"></el-input>
        </el-form-item>

        <el-form-item  prop='ID'>
           <label>身份证号</label>
          <el-input v-model="form.ID" placeholder="请输入18位身份证号"></el-input>
        </el-form-item>

        <el-form-item  prop='Gender'>
           <label>性别</label>
           <el-select v-model="form.Gender" clearable placeholder="请选择" class="small">
              <el-option label="男" value="男"></el-option>
              <el-option label="女" value="女"></el-option>
            </el-select>
        </el-form-item>

        <el-form-item prop='Area'>
           <label for="Area">区域</label>
          <el-input v-model="form.Area" disabled class="small"></el-input>
        </el-form-item>

        <el-form-item prop='LandlordName'>
           <label for="LandlordName">房东</label>
            <el-select v-model="form.LandlordName" clearable placeholder="请选择">
              <el-option v-for="(item, index) in options" :key="index" :label="item.Name"  :value="item.Name"></el-option>
            </el-select>
        </el-form-item>

        <el-form-item prop='StaffName'>
           <label for="StaffName">对接工作人员</label>
          <el-input v-model="form.StaffName" disabled class="small"></el-input>
        </el-form-item>    

        <el-form-item prop='StartDate'>
            <label for="StartDate">来往时间</label>
            <el-date-picker
              type="date"
              placeholder="选择日期"
              value-format='yyyy-MM-dd'
              v-model="form.StartDate"              
            ></el-date-picker>
        </el-form-item>

        <el-form-item prop='EndDate'>
           <label for="EndDate">离开时间</label>
          <el-date-picker
              type="date"
              placeholder="选择日期"
              value-format='yyyy-MM-dd'
              v-model="form.EndDate"              
            ></el-date-picker>
        </el-form-item>

        <el-form-item prop='Marriage'>
           <label for="Marriage">婚育情况</label>
          <el-select v-model="form.Marriage" clearable placeholder="请选择" class="small">
              <el-option label="单身未育" value="单身未育"></el-option>
              <el-option label="已婚未育" value="已婚未育"></el-option>
              <el-option label="单身已育" value="单身已育"></el-option>
              <el-option label="已婚已育" value="已婚已育"></el-option>
            </el-select>
        </el-form-item>
        
        <el-form-item prop='Tel'>
           <label for="Tel">联系方式</label>
          <el-input v-model="form.Tel"></el-input>
        </el-form-item>

        <el-form-item prop='Birth'>
           <label for="Birth">出生日期</label>
          <el-date-picker
              type="date"
              placeholder="选择日期"
              value-format='yyyy-MM-dd'
              v-model="form.Birth"              
            ></el-date-picker>
        </el-form-item>

        <el-form-item prop='Origin'>
           <label for="Origin">籍贯</label>
          <el-input v-model="form.Origin"></el-input>
        </el-form-item>

        <el-form-item prop='Note'>
           <label for="Note">备注</label>
          <el-input type="textarea" v-model="form.Note" class="note"></el-input>
        </el-form-item>

        <el-form-item class="btns">
          <el-button type="success" @click="submitForm('form')" size="medium">提交</el-button>
          <el-button type="danger" @click="resetForm('houseForm')">重置</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
import Breadcrumb from "@/components/common/Breadcrumb.vue";
import { mapState } from "vuex";
export default {
  name: "migrant_new",
  components: { Breadcrumb },
  data() {
    return {
      routes: {
        // 面包屑导航 对象
        nav: "信息管理",
        parent: "流动人员",
        parentRoute: "all",
        children: "新增数据",
      },
      form: {
        Area: "",
        AreaID: "",
        Birth: "",
        EndDate: "",
        StartDate: "",
        Note: "",
        Tel: "",
        Origin: "",
        Name: "",
        StaffName: "",
        LandlordName: "",
        Marriage: "",
        ID: "",
        Gender: "",
      },
      rules: {
        ID: [
          { required: true, message: "请输入身份证号", trigger: "change" },
          {
            max: 18,
            min: 18,
            message: "请输入18位身份证号",
            trigger: "change",
          },
        ],
        Name: [
          { required: true, message: "请输入人员姓名", trigger: "change" },
        ],
        Tel: [{ required: true, message: "请输入联系方式", trigger: "change" }],
        LandlordName: [
          { required: true, message: "请选择", trigger: "change" },
        ],
        StartDate: [
          {
            required: true,
            message: "请选择时间",
            trigger: "change",
          },
        ],
        EndDate: [{ required: true, message: "请选择时间", trigger: "change" }],
        Birth: [{ required: true, message: "请选择时间", trigger: "change" }],
        Origin: [{ required: true, message: "请输入籍贯", trigger: "change" }],
        Marriage: [{ required: true, message: "请选择", trigger: "change" }],
        Gender: [{ required: true, message: "请选择", trigger: "change" }],
      },
      options: [],
    };
  },
  computed: {
    ...mapState({
      StaffName: (state) => state.Administrator.userInfo.Name,
      StaffID: (state) => state.Administrator.adminID,
      Area: (state) => state.Administrator.userInfo.Area,
      AreaID: (state) => state.Administrator.userInfo.AreaID,
    }),
  },
  mounted() {
    this.form.Area = this.Area;       // staff的信息，写死，负责xx区域的staff只能添加xx区域的流动人员
    this.form.StaffName = this.StaffName;
    this.form.AreaID = this.AreaID;
    this.form.StaffName = this.StaffName;
    // staff 和 landlord都有区域ID，
    this.$store
          .dispatch("LandlordNameList", this.form.AreaID)
          .then((res) => {
            this.options = res;
            // console.log(this.options);
          });
  },
  methods: {
    // 提交表单
    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          // console.log(this.form);
          this.$confirm("确认新增流动人员?", "确认新增", {
            confirmButtonText: "确定",
            cancelButtonText: "取消",
            center: true,
          })
            .then(() => {
              this.$store
                .dispatch("AddMigrant", {
                  form: this.form,
                  staff: { StaffName: this.StaffName, StaffID: this.StaffID },
                })
                .then((res) => {
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
      this.form = {
        Birth: "",
        EndDate: "",
        StartDate: "",
        Note: "",
        Tel: "",
        Origin: "",
        Name: "",
        LandlordName: "",
        Marriage: "",
        ID: "",
        Gender: "",
      };
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