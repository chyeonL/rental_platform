<template>
  <div id="app">
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  name: 'app',
  created(){
     // 初始化 用户信息
    this.$store.commit("initUserInfo");
  }
}
</script>
