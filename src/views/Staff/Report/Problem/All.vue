<template>
  <div id="Problem_all">
    <!-- 头部 -->
    <div class="header">      
      <Breadcrumb  :routes='routes'/>
      <header>
        <el-input
          v-model="keyword"
          placeholder="输入关键字进行搜索……"
          @change="goSearch()"
        >
        </el-input>
        <el-button  icon="el-icon-search">搜索</el-button>
        <el-button  icon="el-icon-document-add" 
            @click="$router.push({name:'newProblem'})">
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
        <el-table-column label="门牌号" prop="HouseNumber" align="center"></el-table-column>
        <el-table-column label="屋主" prop="OwnerName" align="center"></el-table-column>
        <el-table-column label="区域" prop="Area" align="center"> </el-table-column>
        <el-table-column label="时间" prop="Time" align="center"> </el-table-column>
        <!-- <el-table-column label="工作人员" prop="StartDate" align="center">
        </el-table-column> -->
        <el-table-column label="状态" prop="Status" align="center">
        </el-table-column>
        <el-table-column label="数据操作" width="200" class="operation" fixed="right" align="center">
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
  name: "Problem_all",
  components: { Pagination, Breadcrumb },
  data() {
    return {
      keyword: "",
      type: "all", // search 为搜索分页
      currentPage: 1,
      routes: {
        nav: "收集报告",
        parent: "问题报告",
        parentRoute: "all",
        children: "所有记录",
      },
    };
  },
  created() {
    this.getData();
  },
  computed: {
    // ...mapState(["total","pageSize","pageNo","searchList","allHouse","HouseList"])
    ...mapState({
      total: (state) => state.Problem.total,
      pageNo: (state) => state.Problem.pageNo,
      all: (state) => state.Problem.all,
      list: (state) => state.Problem.list,
      pageSize: (state) => state.Problem.pageSize,
      searchList: (state) => state.Problem.searchList,
    }),
  },
  methods: {
    // 获取数据
    async getData(pageNo = 1) {
      await this.$store
        .dispatch("GetAllProblem", pageNo)
        .then((res) => (this.type = "all"));
    },

    // 改变页码，重发请求
    changePageNo(pageNo) {
      // this.currentPage = pageNo;
      if (this.type == "all") {
        this.getData(pageNo);
      } else {
        this.goSearch(pageNo);
      }
    },

    // 搜索
    async goSearch(pageNo = 1) {
      // 根据关键字发请求 搜索
      let keywords = this.keyword.trim();
      if (keywords) {
        await this.$store
          .dispatch("SearchProblem", { keywords, pageNo })
          .then((res) => {
            this.type = "search";
            // console.log(this.type);
          });
      } else {
        this.getData(1, this.pageSize); // 搜索之后，删掉关键词，再按回车，重新加载全部数据
        // return;
      }
    },

    // 编辑
    handleEdit(index, row) {
      // console.log(row.No);
      this.$router.push({
        name: "DetailProblem",
        query: {
          No: row.No,
        },
      });
    },

    // 删除
    handleDelete(index, row) {
      this.$confirm("确认删除当前问题报告?", "确认删除", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        center: true,
      })
        .then(async () => {
          await this.$store
            .dispatch("DeleteProblem", row.No)
            .then((res) => this.getData());
        })
        .catch(() => {});
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
  margin: 0 100px;

  ::v-deep .el-input {
    width: 300px;
    border: 1px solid #24292e;
    outline: none;
  }

  ::v-deep .el-input:focus {
    border-color: none;
  }

  ::v-deep .el-button {
    padding: 12px;
    margin-left: 20px;
    font-size: 14px;
    color: #ffd04b;
    background-color: #24292e;
    // border-radius: 15px;
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
</style>