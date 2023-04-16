<template>
  <div class="myContent">
    <!-- 顶部 -->
    <div class="header">
      <!-- 折叠 展开 -->
      <div class="collapse" @click="change">
        <i class="el-icon-s-unfold" v-show="isCollapse"></i>
        <i class="el-icon-s-fold" v-show="!isCollapse"></i>
      </div>

      <!-- title -->
      <h3 class="title">
        数字化出租管理平台
      </h3>

      <!-- 右侧 -->
      <div class="user">
        <!-- 前台网站 -->
        <div class="toWebsite" @click="goToWebsite">
          <i class="iconfont icon-guanfangwangzhan"></i>
          <button>前台网站</button>
        </div>

        <el-badge :value="$store.state.Administrator.opinion" class="opinion" v-if="$store.state.Administrator.role=='staff'">
          <el-button size="small"  icon="el-icon-bell" @click="feedback"></el-button>
        </el-badge>

        <el-badge :value="$store.state.Administrator.rent" class="rent" v-if="$store.state.Administrator.role=='landlord'">
          <el-button size="small"  icon="iconfont icon-wodejifenbao" @click="rentComplete"></el-button>
        </el-badge>

        <el-badge :value="$store.state.Administrator.tenant" class="tenant" v-if="$store.state.Administrator.role=='landlord'">
          <el-button size="small"  icon="iconfont icon-13" @click="tenantComplete"></el-button>
        </el-badge>

        <!-- 头像 移入显示dropdown -->
        <el-dropdown class="avatar">
          <span class="wrapper">
            <span :style="{backgroundImage:`url(${circleUrl})`}"></span>
            <!-- <el-avatar size="small" :src="circleUrl"></el-avatar> -->
          </span>
          <el-dropdown-menu slot="dropdown" class="dd">
            <el-dropdown-item @click.native="$router.push(push)">我的信息</el-dropdown-item>
            <el-dropdown-item @click.native="logout">退出登录</el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
      </div>
    </div>
    <!-- 内容显示 -->
    <main>
      <router-view></router-view>
    </main>
  </div>
</template>

<script>
export default {
  name: "MyContent",
  props: ["isCollapse"],
  data() {
    return {
      circleUrl:
        this.$store.state.Administrator.userInfo.Avatar || "./NoAvatar.png",
      value: "",
      push: "/" + this.$store.state.Administrator.role + "/my",
    };
  },
  created() {
    if (this.$store.state.Administrator.role == "staff") {
      this.$store.dispatch(
        "FeedbackNumber",
        this.$store.state.Administrator.adminID + "_opinion"
      );
    }

    if (this.$store.state.Administrator.role == "landlord") {
      this.$store.dispatch(
        "TenantNumber",
        "tenant_" + this.$store.state.Administrator.adminID
      );
      this.$store.dispatch(
        "RentNumber",
        "rent_" + this.$store.state.Administrator.adminID
      );
    }
  },
  methods: {
    // 展开折叠
    change() {
      this.$emit("changeIsCollapse");
    },

    // 退出登录
    logout() {
      this.$confirm("确定退出登录?", "确定", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        center: true,
      })
        .then(() => {
          this.$store.dispatch("Logout", this.form).then((res) => {
            this.$router.replace("/login");
          });
        })
        .catch(() => {});
    },

    // 跳转前台
    goToWebsite() {
      this.$router.push("/");
    },

    // 等待反馈
    feedback() {
      this.$router.push("/staff/opinion/all");
      this.$notify({
        type: "warning",
        duration: 4000,
        title: "反馈提醒",
        offset: 70,
        message: `您有 ${this.$store.state.Administrator.opinion} 条群众意见正等待反馈......`,
      });
    },

    //
    rentComplete() {
      this.$router.push("/landlord/rent/all");
      this.$notify({
        type: "warning",
        duration: 4000,
        title: "完善提醒",
        offset: 70,
        message: `您有 ${this.$store.state.Administrator.rent} 条月租记录待完善......`,
      });
    },

    //
    tenantComplete() {
      this.$router.push("/landlord/tenant/all");
      this.$notify({
        type: "warning",
        duration: 4000,
        title: "完善提醒",
        offset: 70,
        message: `您有 ${this.$store.state.Administrator.tenant} 条租户信息待完善......`,
      });
    },
  },
};
</script>

<style scoped lang="scss">
.myContent {
  display: flex;
  position: relative;
  width: 100%;
  height: 100%;
}
.header {
  position: absolute;
  top: 0;
  left: 0;
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
  height: 56px;
  background-color: #24292e;
}

main {
  flex: 1;
  margin-top: 56px;
  padding: 20px;
  overflow: auto;
}

.collapse {
  width: 25px;
  margin-left: 15px;
  cursor: pointer;

  i {
    color: #ffd04b;
    font-size: 25px;
    font-weight: 700;
  }
}

.title {
  color: #fff;
  font-size: 20px;
  font-weight: normal;
}

.user {
  display: flex;
  justify-content: center;
  align-items: center;
  margin-right: 15px;
  // background-color: #fff;

  .toWebsite {
    // margin-right: 15px;
    padding: 7px 13px;
    color: #ffd04b;
    background-color: #24292e;
    border: 1px dotted grey;
    border-radius: 8px;
    cursor: pointer;

    button {
      font-size: 13px;
      color: #ffd04b;
      border: none;
      background-color: transparent;
      vertical-align: top;
      &:hover {
        cursor: pointer;
        // color: #8a8985;
        text-decoration: underline;
      }
    }

    i {
      font-size: 15px;
      // vertical-align: bottom;
      margin-right: 4px;
    }
  }

  .avatar {
    cursor: pointer;
    margin-right: 10px;
  }

  .select {
    width: 150px;
    color: black;
  }

  .el-dropdown {
    span {
      display: block;
    }
    .wrapper {
      width: 28px;
      height: 28px;
      background-color: #fff;
      overflow: hidden;
      position: relative;
      border-radius: 15px;
      span {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-size: cover;
        background-position: 50%;
      }
    }
  }
  ::v-deep .el-button {
    color: #ffd04b;
    background-color: transparent;
    border: none;
    margin-left: 15px;
    margin-right: 25px;
    i {
      font-size: 20px;
    }
  }
  ::v-deep .el-badge__content.is-fixed {
    top: 5px;
    right: 38px;
  }
  ::v-deep .el-badge__content {
    color: #fff;
    font-size: 8px;
    height: 15px;
    line-height: 15px;
    padding: 0 4px;
    background-color: #ff5555;
  }
  .rent {
    margin-right: -20px;
  }
}
</style>
