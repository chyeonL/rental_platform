<template>
  <div id="Tenant_all">
    <!-- 头部 -->
    <div class="header">      
      <Breadcrumb  :routes='routes'/>
      <header>
        <el-button  icon="el-icon-document-add"  class="report"
            @click="report">
          一键报备
        </el-button>
        <span class="toBeReport">
          <i class="iconfont icon-liudongrenyuan"></i>
          {{toBeReport}}
        </span>
        <!-- 筛选 -->
        <el-select v-model="filterKey" placeholder="筛选: 完整度" @change='filterStatus'>
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
        <el-table-column label="房间号" prop="RoomNumber" align="center"> </el-table-column>
        <el-table-column label="姓名" prop="Name" align="center" width="120"> </el-table-column>
        <el-table-column label="身份证号" prop="ID" align="center" width="180"> </el-table-column>
        <el-table-column label="联系电话" prop="Tel" align="center" width="120"></el-table-column>
        <el-table-column label="合同编号" prop="ContractNo" align="center" width="100"></el-table-column>
        <el-table-column label="合同状态" prop="ContractStage" align="center" width="100"></el-table-column>
        <el-table-column label="报备状态" prop="ReportStatus" align="center" width="80"></el-table-column>
        <el-table-column label="信息完整度" prop="Status" align="center" width="100"></el-table-column>
        <el-table-column label="租期开始" prop="StartDate" align="center" width="100"></el-table-column>
        <el-table-column label="租期" prop="Term" align="center"> </el-table-column>
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
  name: "Tenant_all",
  components: { Pagination, Breadcrumb },
  data() {
    return {
      keyword: "",
      type: "all",
      currentPage: 1,
      routes: {
        nav: "流动人员",
        parent: "租户",
        parentRoute: "all",
        children: "所有租户",
      },
      status: ["所有租户", "待完善", "信息完整"],
      filterKey: "",
    };
  },
  created() {
    this.getData();
    this.$store.dispatch(
      "ToBeReport",
      "tenant_" + this.$store.state.Administrator.adminID
    );
    this.$notify({
      title: "报备提醒",
      offset: 150,
      duration: 4000,
      message: `要求向工作人员报备所有流动人员, 报备条件：信息完整、租约中。`,
      type: "warning",
    });
  },
  computed: {
    ...mapState({
      total: (state) => state.RoomType.total,
      pageNo: (state) => state.RoomType.pageNo,
      all: (state) => state.RoomType.all,
      list: (state) => state.RoomType.list,
      pageSize: (state) => state.RoomType.pageSize,
      search: (state) => state.RoomType.search,
      toBeReport: (state) => state.Administrator.toBeReport,
    }),
  },
  methods: {
    async getData(pageNo = 1) {
      await this.$store
        .dispatch("GetAllTenants", pageNo)
        .then((res) => (this.type = "all"));
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
      if (this.filterKey === "信息完整") this.filterKey = "√";
      await this.$store
        .dispatch("SearchTenant", {
          keywords,
          pageNo,
          Status: this.filterKey === "所有租户" ? "" : this.filterKey,
        })
        .then(() => {
          if (this.filterKey === "√") this.filterKey = "信息完整";
          this.type = "search";
        });
    },

    handleEdit(index, row) {
      this.$router.push({
        name: "Tenant_Detail",
        query: {
          No: row.No,
        },
      });
    },

    handleDelete(index, row) {
      this.$confirm("确认删除该租户?", "确认删除", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        center: true,
      })
        .then(async () => {
          if (row.ContractStage === "租约中") {
            this.$message.error('该租户的合同状态处于"租约中"，暂时无法删除！');
          } else {
            await this.$store
              .dispatch("DeleteTenant", row.No)
              .then((res) => this.getData());
          }
        })
        .catch(() => {});
    },

    // 待完善的行
    rowsToBeComplete({ row }) {
      if (row.Status === "待完善" && row.ContractStage === "租约中")
        return "warning-row";
      if (row.ReportStatus === "√" && row.ContractStage === "租约中")
        return "warning2-row";
    },

    // 报备
    report() {
      this.$store.dispatch("ReportTenant").then(() => {
        this.$router.go(0);
      });
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
  .report {
    margin: 0 10px 0 30px;
  }
  .toBeReport {
    margin-right: 40px;
    font-size: 14px;
    vertical-align: top;
    background-color: #fff;
    padding: 5px;
    border-radius: 10px;
    box-shadow: 0px 0px 10px 0px rgb(0 0 0 / 50%);
    i {
      font-size: 21px;
      margin-right: -3px;
    }
  }
  ::v-deep .el-select {
    width: 140px;
    margin-right: 20px;
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
::v-deep .el-table .warning-row {
  background: #fae2d4;
}
::v-deep .el-table .warning2-row {
  background: rgb(235, 249, 227);
}
::v-deep .el-table tbody tr {
  height: 80px;
}
</style>