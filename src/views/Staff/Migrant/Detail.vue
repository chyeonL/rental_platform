<template>
  <div id="#Migrant_detail">
    <header>
      <Breadcrumb  :routes='routes'/>
    </header>    

    <div class="form">
      <el-form :model="form"
        label-position="left" 
        ref="form" 
        :status-icon='true'
        disabled
      >            
        <el-form-item  prop='ID'>
           <label>身份证号</label>
          <el-input v-model="form.ID" disabled style="width:180px"></el-input>
        </el-form-item>   

        <el-form-item prop='Name'>
           <label>姓名</label>
          <el-input v-model="form.Name" disabled style="width:180px"></el-input>
        </el-form-item>     

        <el-form-item prop='Tel'>
           <label>联系电话</label>
          <el-input v-model="form.Tel" disabled style="width:180px"></el-input>
        </el-form-item>      

        <el-form-item prop='Area'>
           <label>区域</label>
          <el-input v-model="form.Area" disabled></el-input>
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

        <el-form-item prop='LandlordName'>
           <label>房东姓名</label>
          <el-input v-model="form.LandlordName" disabled></el-input>
        </el-form-item>

        <el-form-item prop='ContractStage'>
           <label>合同状态</label>
          <el-input v-model="form.ContractStage" disabled></el-input>
        </el-form-item>          

        <el-form-item prop='StartDate'>
           <label>租约开始</label>
          <el-input v-model.number="form.StartDate" disabled></el-input>
        </el-form-item>            
 
        <el-form-item prop='Term'>
           <label>租期</label>
          <el-input v-model.number="form.Term" disabled></el-input>
        </el-form-item>     

        <el-form-item prop='Note'>
           <label>备注</label>
          <el-input type="textarea" v-model="form.Note" class="note"></el-input>
        </el-form-item>
      </el-form> 
    </div>
  </div>
</template>

<script>
import Breadcrumb from "@/components/common/Breadcrumb.vue";
import {mapState} from 'vuex'
export default {
  name: "Migrant_detail",
  components: { Breadcrumb },
  data() {
    return {
      IsEdit: true,
      routes: {
        nav: "流动人员",
        parent: "来往记录",
        parentRoute: "all",
        children: "具体信息",
      },
     form: {
        Term: "",
        Area: "",
        ContractStage: "",
        ID: "",
        Name: "",
        Gender: "",
        Marriage: "",
        Origin: "",
        LandlordName: "",
        StartDate: "",
        Tel: "",
        Note: "",
      },
    };
  },
  created() {
    this.getDetail();
  },
  mounted() {
    this.$refs.form.clearValidate();
  },
  computed:{
    ...mapState({
      StaffID:(state)=>state.Administrator.userInfo.Admin_ID
    })
  },
  methods: {
    getDetail() {
      this.$store
        .dispatch("migrantDetail", this.$route.query.No)
        .then((res) => {
          this.form = res;
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