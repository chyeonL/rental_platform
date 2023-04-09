<template>
  <div id="pagination">
    <el-pagination
      @current-change="handleCurrentChange"
      :current-page="currentPage"
      layout="total, prev, pager, next,jumper"
      background
      :total="total"
      :page-size="pageSize"
    >
    <!-- page-size必须携带，不然页数会显示错误 -->
    </el-pagination>
  </div>
</template>

<script>
export default {
  name: "Pagination",
  methods: {
    // 改变页码
    handleCurrentChange(val) {
      //   console.log(val);
      this.$emit("changePageNo", val);
    },
  },
  props: {
    total: {
      type: Number,
    },
    currentPage: {
      type: Number,
      default: 1,
    },
    pageSize: {
      type: Number,
      default: 5,
    },
  },
};
</script>

<style lang="scss" scoped>
.el-pagination {
  margin: 25px auto 0;
  text-align: center;
}
</style>
