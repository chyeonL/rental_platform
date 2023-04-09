<template>
  <el-breadcrumb separator-class="el-icon-arrow-right" :class='{short:isShorter,padding:isVillage}'>
    <el-breadcrumb-item :to="routes.topRoute">{{routes.nav}}</el-breadcrumb-item>
    <el-breadcrumb-item :to="routes.parentRoute">{{routes.parent}}</el-breadcrumb-item>
    <el-breadcrumb-item v-if="routes.children">{{routes.children}}</el-breadcrumb-item>
  </el-breadcrumb>
</template>

<script>
export default {
  name: "Breadcrumb",
  data() {
    return {
      isShorter: false,
      isVillage:false
    };
  },
  props: ["routes"],
  mounted() {
    this.shorter()
  },
  methods: {
    shorter() {      
      this.isShorter = typeof this.routes.children === 'undefined' ? true : false;
      this.isVillage = this.routes.nav === '网站管理' ? true : false;
    },
  },
};
</script>

<style lang="scss" scoped>
.el-breadcrumb {
  width: 220px;
  height: 35px;
  padding: 0 30px;
  margin-left: 20px;
  // margin-right: 50px;
  line-height: 35px;
  background-color: #fff;
  border-radius: 10px;
  text-align: left;
  font-size: 14px;
  box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.5);
  ::v-deep .el-breadcrumb__inner {
    // color: #fff;
  }
}
.short {
  width: 140px;
  padding-left:  20px;
  padding-right: 0;
}
.padding {
  padding:0 25px;
}
</style>