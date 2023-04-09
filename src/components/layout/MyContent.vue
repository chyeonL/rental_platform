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
      push: '/'+this.$store.state.Administrator.role+'/my'
    };
  },
  methods: {
    // 展开折叠
    change() {
      this.$emit("changeIsCollapse");
    },

    // 退出登录
    logout() {
      this.$store.dispatch("Logout");
      this.$router.replace("/login");
    },

    // 跳转前台
    goToWebsite() {
      this.$router.push("/");
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

  .toWebsite {
    margin: 0 20px;
    padding: 9px;
    color: #ffd04b;
    // background-color: #3292f8;
    border-radius: 8px;
    cursor: pointer;

    button {
      font-size: 14px;
      color: #ffd04b;
      border: none;
      background-color: transparent;
      &:hover {
        cursor: pointer;
        // color: #8a8985;
        text-decoration: underline;
      }
    }

    i {
      font-size: 18px;
      vertical-align: bottom;
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
}
</style>
