<template>
  <div id="LOpinion_all">
    <!-- 头部 -->
    <div class="header">      
      <Breadcrumb  :routes='routes'/>
      <header>
        <!-- 筛选 -->
        <el-select v-model="filterKey" placeholder="筛选:反馈状态" @change='filterStatus'>
          <el-option
            v-for="(item,index) in status"
            :key="index"
            :label="item"
            :value="item"
            >
          </el-option>
        </el-select>
        <el-input
          v-model="keyword"
          placeholder="输入关键字进行搜索……"
          @change="goSearch()"
        >
        </el-input>
        <el-button  icon="el-icon-search">搜索</el-button>
        <el-button  icon="el-icon-document-add" 
            @click="$router.push({name:'LOpinion_New'})">
          新增
        </el-button>
      </header>
    </div> 
    <!-- 表格 -->
    <main>
      <el-table
        :data="type==='all'?list:searchList"
        border
        :header-cell-style="{background:'#24292e',color:'#ffd04b',borderColor:'#4c4c4c'}"
        :row-class-name="rowsToBeComplete"
      >
       <el-table-column
        label="编号"
        prop="No"
        width="50"
        align="center"
        >
        </el-table-column>
        <el-table-column label="标题" prop="Title" align="center"> </el-table-column>
        <el-table-column label="类别" prop="Category" align="center"> </el-table-column>
        <el-table-column label="提交时间" prop="SubmitTime" align="center" width="120"> </el-table-column>
        <el-table-column label="状态" prop="Status" align="center"></el-table-column>
        <el-table-column label="具体" prop="Detail" align="center" width="200"> </el-table-column>
        <el-table-column label="数据操作" width="180" class="operation" fixed="right" align="center">
          <template slot-scope="scope">
            <el-button type="info" @click="handleEdit(scope.$index, scope.row)">具体/编辑</el-button>
            <el-button
              type="danger"
              @click="handleDelete(scope.$index, scope.row)"
              >删除</el-button
            >
          </template>
        </el-table-column>
      </el-table>
    </main>
    <!-- 分页器 -->
    <Pagination
      :total="total"
      :currentPage="currentPage"
      :pageSize="pageSize"
      @changePageNo="changePageNo"
    />
  </div>
</template>

<script>
import Breadcrumb from "@/components/common/Breadcrumb.vue";
import Pagination from "@/components/common/Pagination.vue";
import { mapState } from "vuex";
export default {
  name: "LOpinion_all",
  components: { Pagination, Breadcrumb },
  data() {
    return {
      keyword: "",
      type: "all", // search 为搜索分页
      currentPage: 1,
      routes: {
        nav: "意见反馈",
        parent: "我的意见",
        parentRoute: "all",
        children: "所有数据",
      },
      status: ["所有意见", "等待反馈", "处理中", "否决意见", "接纳意见"],
      filterKey: "",
    };
  },
  created() {
    this.getData();
  },
  computed: {
    ...mapState({
      total: (state) => state.Opinion.total,
      pageNo: (state) => state.Opinion.pageNo,
      all: (state) => state.Opinion.all,
      list: (state) => state.Opinion.list,
      pageSize: (state) => state.Opinion.pageSize,
      searchList: (state) => state.Opinion.searchList,
    }),
  },
  methods: {
    async getData(pageNo = 1) {
      await this.$store
        .dispatch("GetMyOpinion", pageNo)
        .then(() => (this.type = "all"));
    },

    changePageNo(pageNo) {
      if (this.type == "all") {
        this.getData(pageNo);
      } else {
        this.goSearch(pageNo);
      }
    },

    async goSearch(pageNo = 1) {
      let keywords = this.keyword.trim();
      await this.$store
        .dispatch("SearchMyOpinion", {
          keywords,
          pageNo,
          Status: this.filterKey === "所有意见" ? "" : this.filterKey,
        })
        .then(() => {
          this.type = "search";
        });
    },

    handleEdit(index, row) {
      this.$router.push({
        name: "LOpinion_Detail",
        query: {
          No: row.No,
        },
      });
    },

    handleDelete(index, row) {
      this.$confirm("确认删除当前意见?", "确认删除", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        center: true,
      })
        .then(async () => {
          await this.$store
            .dispatch("DeleteMyOpinion", row.No)
            .then((res) => this.getData());
        })
        .catch(() => {});
    },

    // 待完善的行
    rowsToBeComplete({ row }) {
      if (row.Status === "等待反馈") return "warning2-row";
      if (row.Status === "否决意见") return "warning3-row";
      if (row.Status === "接纳意见") return "warning4-row";
    },

    filterStatus(status) {
      this.filterKey = status;
      this.keyword = "";
      this.goSearch();
    },
  },
};
</script>

<style scoped lang="scss">
.header {
  display: flex;
  align-items: center;
  margin-top: 10px;
}
header {
  display: flex;
  align-items: center;
  justify-content: start;

  ::v-deep .el-input {
    width: 300px;
    border: 1px solid #24292e;
    outline: none;
  }

  ::v-deep .el-input__inner:focus {
    border-color: #24292e;
    outline: 0;
  }

  ::v-deep .el-button {
    padding: 12px;
    margin-left: 20px;
    font-size: 14px;
    color: #ffd04b;
    background-color: #24292e;
  }
  ::v-deep .el-select {
    width: 140px;
    margin-left: 50px;
    margin-right: 50px;
    .el-input {
      width: 100%;
      border: none;
    }
    .el-input__inner {
      border: none;
      font-weight: 700;
      color: #ffd04b;
      background-color: #24292e;
    }
  }
}

main {
  margin: 30px 25px;
  ::v-deep .el-button--mini {
    font-size: 15px;
  }

  table {
    text-align: center !important;
    .el-button {
      padding: 8px;
    }
  }
}
::v-deep .el-table .warning2-row {
  background: #fae2d4;
}
::v-deep .el-table .warning3-row {
  background: #fad1cb;
}
::v-deep .el-table .warning4-row {
  background: rgb(235, 249, 227);
}
</style>