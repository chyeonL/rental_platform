<template>
  <div id="#Inspectaion_all">
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
            @click="$router.push({name:'newInspectation'})">
          新增
        </el-button>
      </header>
    </div> 
    <!-- 表格 -->
    <main>
      <el-table
        :data="type==='all'?list:search"
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
        <el-table-column label="门牌号" prop="HouseNumber" align="center"> </el-table-column>
        <el-table-column label="屋主" prop="Owner" align="center"> </el-table-column>
        <!-- <el-table-column label="屋主ID" prop="Landlord_ID" align="center"> </el-table-column> -->
        <el-table-column label="巡查时间" prop="Time" align="center"> </el-table-column>
        <el-table-column label="总体情况" prop="Overall" align="center">
        </el-table-column>
        <el-table-column label="备注" prop="Note" align="center">
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
  name: "Inspectaion_all",
  components: { Pagination, Breadcrumb },
  data() {
    return {
      keyword: "",
      type: "all", // search 为搜索分页
      currentPage: 1,
      routes: {
        // 面包屑导航 对象
        nav: "安全检查",
        parent: "巡视记录",
        parentRoute: "all",
        children: "所有记录",
      },
    };
  },
  created() {
    this.getData();
  },
  computed: {
    // ...mapState(["total","pageSize","pageNo","search","allHouse","HouseList"])
    ...mapState({
      total: (state) => state.staff_Inspectation.total,
      pageNo: (state) => state.staff_Inspectation.pageNo,
      all: (state) => state.staff_Inspectation.all,
      list: (state) => state.staff_Inspectation.list,
      pageSize: (state) => state.staff_Inspectation.pageSize,
      search: (state) => state.staff_Inspectation.search,
    }),
  },
  methods: {
    // 获取数据
    async getData(pageNo = 1) {
      await this.$store
        .dispatch("GetAll", pageNo)
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
          .dispatch("SearchInspectation", { keywords, pageNo })
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
        name: "DetailInspectation",
        query: {
          No: row.No,
        },
      });
    },

    // 删除
    handleDelete(index, row) {
      this.$confirm("确认删除该巡视记录?", "确认删除", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        center: true,
      })
        .then(async () => {
          await this.$store
            .dispatch("DeleteInspectation", row.No)
            .then((res) => this.getData());
        })
        .catch(() => {});
    },

    // 待完善的行
    rowsToBeComplete({ row }) {
      if (row.Overall  === "合格")
        return "warning4-row";
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
::v-deep .el-table .warning4-row {
  background: rgb(235, 249, 227);
}
</style>