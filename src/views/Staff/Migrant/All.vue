<template>
  <div id="#Migrant_all">
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
        <!-- <el-button  icon="el-icon-document-add" 
            @click="$router.push({name:'newMigrant'})">
          新增
        </el-button> -->
      </header>
    </div> 
    <!-- 表格 -->
    <main>
      <el-table
        :data="type==='all'?migrantList:searchList"
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
        <el-table-column label="姓名" prop="Name" align="center"> </el-table-column>
        <el-table-column label="身份证号" prop="ID" align="center" width="150"></el-table-column>
        <el-table-column label="性别" prop="Gender" align="center" width="50"></el-table-column>
        <el-table-column label="区域" prop="Area" align="center"> </el-table-column>
        <el-table-column label="房东" prop="LandlordName" align="center"></el-table-column>
        <el-table-column label="合同状态" prop="ContractStage" align="center"></el-table-column>
        <el-table-column label="联系方式" prop="Tel" align="center" width="100"> </el-table-column>
        <el-table-column label="来往时间" prop="StartDate" align="center" width="100"></el-table-column>
        <el-table-column label="租期" prop="Term" align="center"> </el-table-column>
        <el-table-column label="数据操作" width="120" class="operation" fixed="right" align="center">
          <template slot-scope="scope">
            <el-button type="info" @click="handleEdit(scope.$index, scope.row)">具体信息</el-button>
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
  name: "Migrant_all",
  components: { Pagination, Breadcrumb },
  data() {
    return {
      keyword: "",
      type: "all", 
      currentPage: 1,
      routes: {
        nav: "信息管理",
        parent: "流动人员",
        parentRoute: "all",
        children: "所有数据",
      },
    };
  },
  created() {
    this.getData();
  },
  computed: {
    ...mapState({
      total: (state) => state.Migrant.total,
      pageNo: (state) => state.Migrant.pageNo,
      allMigrants: (state) => state.Migrant.allMigrants,
      migrantList: (state) => state.Migrant.migrantList,
      pageSize: (state) => state.Migrant.pageSize,
      searchList: (state) => state.Migrant.searchList,
    }),
  },
  methods: {
    async getData(pageNo = 1) {
      await this.$store
        .dispatch("GetAllMigrants", pageNo)
        .then(() => (this.type = "all"));
    },

    changePageNo(pageNo) {
      if (this.type == "all") {
        this.getData(pageNo);
      } else {
        this.goSearch(pageNo);
      }
    },

    // 搜索
    async goSearch(pageNo = 1) {
      let keywords = this.keyword.trim();
      if (keywords) {
        await this.$store
          .dispatch("SearchMigrant", { keywords, pageNo })
          .then(() => {
            this.type = "search";
          });
      } else {
        this.getData(1, this.pageSize); // 搜索之后，删掉关键词，再按回车，重新加载全部数据
      }
    },

    handleEdit(index, row) {
      this.$router.push({
        name: "Migrant_Detail",
        query: {
          No: row.No,
        },
      });
    },
    
    // 租约中
    rowsToBeComplete({ row }) {
      if (row.ContractStage === "租约中")
        return "warning2-row";
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
::v-deep .el-table .warning2-row {
  background: rgb(235, 249, 227);
}
::v-deep .el-table tbody tr {
  height: 80px;
}
</style>