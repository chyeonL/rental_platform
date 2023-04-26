<template>
  <div id="roomType_all">
    <!-- 头部 -->
    <div class="header">      
      <Breadcrumb  :routes='routes'/>
      <header>
        <!-- 筛选 -->
        <el-select v-model="filterKey" placeholder="筛选:出租状态" @change='filterStatus'>
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
            @click="$router.push({name:'newRoom'})">
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
        <el-table-column label="房间号" prop="RoomNumber" align="center"> </el-table-column>
        <el-table-column label="房型" prop="RoomType" align="center"> </el-table-column>
        <el-table-column label="租金" prop="Rent" align="center"> </el-table-column>
        <el-table-column label="押金" prop="MortgageCash" align="center"></el-table-column>
        <el-table-column label="出租状态" prop="RentStatus" align="center" width="80"></el-table-column>
        <el-table-column label="起租时长" prop="MinimunPeriod" align="center" width="80"></el-table-column>
        <el-table-column label="配置" prop="IsFurnished" align="center"> </el-table-column>
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
  name: "roomType_all",
  components: { Pagination, Breadcrumb },
  data() {
    return {
      keyword: "",
      type: "all", 
      currentPage: 1,
      routes: {
        nav: "出租房",
        parent: "房间管理",
        parentRoute: "all",
        children: "所有记录",
      },
      status: ["所有房间", "未出租", "已出租"],
      filterKey: "",
    };
  },
  created() {
    this.getData();
  },
  computed: {
    ...mapState({
      total: (state) => state.RoomType.total,
      pageNo: (state) => state.RoomType.pageNo,
      all: (state) => state.RoomType.all,
      list: (state) => state.RoomType.list,
      pageSize: (state) => state.RoomType.pageSize,
      search: (state) => state.RoomType.search,
    }),
  },
  methods: {
    async getData(pageNo = 1) {
      await this.$store
        .dispatch("GetAllRoom", pageNo)
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
        .dispatch("SearchRoom", {
          keywords,
          pageNo,
          RentStatus: this.filterKey === "所有房间" ? "" : this.filterKey,
        })
        .then(() => {
          this.type = "search";
        });
    },

    handleEdit(index, row) {
      this.$router.push({
        name: "DetailRoom",
        query: {
          No: row.No,
        },
      });
    },

    handleDelete(index, row) {
      this.$confirm("确认删除该房间?", "确认删除", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        center: true,
      })
        .then(async () => {
          if (row.RentStatus === "已出租") {
            this.$notify({
              title: "警告提醒",
              offset: 80,
              duration: 3000,
              message: "该房间已出租，暂时无法删除",
              type: "warning",
            });
          } else
            await this.$store
              .dispatch("DeleteRoom", {
                No: row.No,
                RoomType: row.RoomType,
                RoomNumber: row.RoomNumber,
              })
              .then((res) => this.getData());
        })
        .catch(() => {});
    },

    rowsToBeComplete({ row }) {
      if (row.RentStatus === "已出租") return "warning2-row";
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
  background: rgb(235, 249, 227);
}
</style>