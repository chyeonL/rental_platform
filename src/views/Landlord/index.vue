<template>
  <div id="landlord">  
   <!-- 左侧导航 -->
    <MyNav
      class="myNav"
      :isCollapse="isCollapse"
      :class="{active:isCollapse}"
    />

    <!-- 右侧内容 -->
    <MyContent
      class="myContent"
      :isCollapse="isCollapse"
      @changeIsCollapse="changeIsCollapse"
    />
  </div>  
</template>

<script>
import MyContent from "@/components/layout/MyContent.vue";
import MyNav from "@/components/layout/MyNav.vue";
export default {
  name: "Landlord",
  components: { MyNav, MyContent },
  data() {
    return {
      isCollapse: false, //默认非 折叠状态
    };
  },
  methods: {
    changeIsCollapse() {
      this.isCollapse = !this.isCollapse;
    },
  },
};
</script>

<style lang="scss" scoped>
#landlord {
  width: 100vw;
  height: 100vh;
  display: flex;
  min-width: 1180px;
}
.myNav {
  width: 200px;
  height: 100%;
  background-color: #24292e;
}

.myContent {
  flex: 1;
  height: 100%;
  overflow: auto;
}

.active {
  width: 64px;
}
</style>
