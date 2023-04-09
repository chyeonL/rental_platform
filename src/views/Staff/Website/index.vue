<template>
  <div id="village">
    <header>
      <Breadcrumb  :routes='routes'/>
    </header>

    <div class="main">
      <!-- 描述列表  展示我的信息    direction="vertical" -->
      <el-descriptions :column="4" border label-class-name="my-label" :colon='true'>
        <el-descriptions-item label="村庄"  content-class-name="my-content" :span='3'>{{VillageInfo.Area}}</el-descriptions-item>
        <el-descriptions-item label="村庄ID" :span='1' >{{VillageInfo.AreaID}}</el-descriptions-item>
        <el-descriptions-item label="地理位置" :span='4' >{{VillageInfo.Location}}</el-descriptions-item>
        <el-descriptions-item label="工作人员ID" :span='4'>{{VillageInfo.Staff_ID}}</el-descriptions-item>
        <el-descriptions-item label="联系电话" :span='4'>{{VillageInfo.Contact}}</el-descriptions-item>
        <el-descriptions-item label="办公室"  :span='3'>{{VillageInfo.Office}}</el-descriptions-item>
        <el-descriptions-item label="出租屋数量" :span='1' >{{VillageInfo.HouseCount}}</el-descriptions-item>
        <el-descriptions-item label="村庄简介"  :span='4'>{{VillageInfo.Brief}}</el-descriptions-item>
      </el-descriptions>
      <!-- 编辑 -->
      <el-button icon="el-icon-edit" @click="Visible=true">修改网站资讯</el-button> 
    </div>

    <!-- 修改 -->
     <el-dialog
      title="村庄资讯"
      :visible.sync="Visible"
      width="35%"
      center
      :lock-scroll='true'
    >
      <el-form
        :model="Info"
        status-icon
        ref="Info"
        label-width="100px"
        class="demo-ruleForm"
      >      
        <el-form-item label="村庄" prop="Area">
          <el-input v-model="Info.Area"
            autocomplete="off" class=""></el-input>
        </el-form-item>
        <el-form-item label="地理位置" prop="Location">
          <el-input
            v-model="Info.Location"
            autocomplete="off"
          ></el-input>
        </el-form-item>
        <el-form-item label="联系电话" prop="Contact">
          <el-input
            v-model="Info.Contact"
            autocomplete="off"
          ></el-input>
        </el-form-item>
        <el-form-item label="办公室" prop="Office">
          <el-input
            v-model="Info.Office"
            autocomplete="off"
          ></el-input>
        </el-form-item>
        <el-form-item label="简介" prop="Brief">
          <el-input
            v-model="Info.Brief"
            autocomplete="off"
            type="textarea"
          ></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitInfo('Info')"
          >确 定</el-button
        >
      </span>
    </el-dialog>
  </div>   
</template>

<script>
import Breadcrumb from "@/components/common/Breadcrumb.vue";
import { mapState } from "vuex";
export default {
  name: "Village",
  components: { Breadcrumb },
  data() {
    return {
      routes: {
        nav: "网站管理",
        parent: "村庄资讯",
      },
      VillageInfo: {
        Area: "",
        AreaID: "",
        Staff_ID: "",
        Location: "",
        Contact: "",
        Office: "",
        HouseCount: "",
        Brief: "",
      },
      Visible: false,
      Info: {
        // 我的信息
        Location: "",
        Contact: "",
        Area: "",
        Office: "",
        Brief: "",
      },
    };
  },
  computed: {
    ...mapState({
      userInfo: (state) => state.Administrator.userInfo,
      village: (state) => state.Website.village,
    }),
  },
  mounted() {
    this.$store
      .dispatch("GetVillageInfoByID", this.userInfo.Admin_ID)
      .then((res) => {
        this.VillageInfo = this.village;
        this.Info.Location = this.village.Location;
        this.Info.Contact = this.village.Contact;
        this.Info.Area = this.village.Area;
        this.Info.Office = this.village.Office;
        this.Info.Brief = this.village.Brief;
        this.Info.No = this.village.No;
        this.Info.Area = this.village.Area;
        this.Info.AreaID = this.village.AreaID;
      });
  },
  methods: {
    submitInfo(formName) {
      this.$refs[formName].validate((valid) => {
        // console.log(this.Info);
        if (valid) {
          this.$confirm("确认修改村庄资讯?", "确认修改", {
            confirmButtonText: "确定",
            cancelButtonText: "取消",
            center: true,
          })
            .then(() => {
              this.$store.dispatch("ModifyVillageInfo", this.Info).then(()=>{
                this.Visible = true
                this.$router.go(0)
              })
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
  margin-bottom: 20px;
}
.main {
  width: 100%;
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 50px;
  padding: 0 30px;
  // background-color: wheat;
  .el-descriptions {
    width: 60%;
    font-size: 15px;
    // border-radius: 40px;
    ::v-deep .my-label {
      width: 100px;
      color: #ffd04b;
      background-color: #24292e;
      text-align: center;
      // border: 1px solid #fff;
    }
  }
  ::v-deep .el-descriptions {
    border: 1px solid rgb(210, 210, 210);
  }
  .el-button {
    color: #ffd04b;
    background-color: #24292e;
    padding: 15px 25px;
    margin-left: 100px;
    margin-right: 200px;
    border-radius: 15px;
    font-weight: 700;
    i {
      color: #1fa0ff;
      width: 100px;
    }
  }
}
::v-deep .el-descriptions-row {
  height: 60px;
}

.el-dialog {
  border-radius: 40px;
}
.demo-ruleForm {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: space-around;
  padding-top: 20px;
  .el-input,
  .el-select {
    width: 200px;
    margin-left: 20px;
  }
}
.dialog-footer {
  .el-button {
    color: #ffd04b;
    background-color: #24292e;
    padding: 12px 25px;
    margin-left: 30px;
    border-radius: 15px;
    font-weight: 700;
    i {
      color: #1fa0ff;
      width: 100px;
    }
  }
}
::v-deep .el-dialog--center {
  text-align: center;
  border-radius: 15px;
}
</style>