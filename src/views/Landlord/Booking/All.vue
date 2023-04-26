<template>
  <div id="Booking_all">
     <!-- 头部 -->
    <div class="header">      
      <Breadcrumb  :routes='routes'/>
      <header>
        <!-- 筛选 -->
        <el-select v-model="filterKey" placeholder="筛选: 预约状态" @change='filterStatus'>
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
      >
       <el-table-column
        label="编号"
        prop="No"
        width="50"
        align="center"
        >
        </el-table-column>
        <el-table-column label="房型" prop="Roomtype" align="center" width="100"></el-table-column>
        <el-table-column label="看房时间" prop="Time" align="center" width="120"></el-table-column>
        <el-table-column label="预约状态" prop="BookingStatus" align="center"> </el-table-column>
        <el-table-column label="姓名" prop="Name" align="center" width="120"> </el-table-column>
        <el-table-column label="联系电话" prop="Contact" align="center" width="120"> </el-table-column>
        <el-table-column label="性别" prop="Gender" align="center" width="60"></el-table-column>
        <el-table-column label="详细需求" prop="Requirement" align="center" width="180"></el-table-column>
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
import Pagination from "@/components/common/Pagination.vue";
import Breadcrumb from "@/components/common/Breadcrumb.vue";
import { mapState } from "vuex";
export default {
  name: "Booking_all",
  components: { Pagination, Breadcrumb },
  data() {
    return {
      keyword: "",
      type: "all",
      currentPage: 1,
      routes: {
        nav: "预约看房",
        parent: "所有",
      },
      status: ["所有预约", "确认", "拒绝", "完成", "提交预约"],
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
        .dispatch("GetAllBooking", pageNo)
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
        .dispatch("SearchBooking", {
          keywords,
          pageNo,
          BookingStatus: this.filterKey === "所有预约" ? "" : this.filterKey,
        })
        .then(() => {
          this.type = "search";
        });
    },

    handleEdit(index, row) {
      this.$router.push({
        name: "Booking_Detail",
        query: {
          No: row.No,
        },
      });
    },

    handleDelete(index, row) {
      this.$confirm("确认删除该预约记录?", "确认删除", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        center: true,
      }).then(async () => {
        if (row.BookingStatus === "提交预约") {
          this.$notify({
            title: "错误提醒",
            offset: 60,
            duration: 3000,
            type: "error",
            message: "该预约还未处理，暂时无法删除！",
          });
          return;
        } else {
          await this.$store
            .dispatch("DeleteBooking", row.No)
            .then(() => this.getData());
        }
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
  margin-left: 100px;

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
::v-deep .el-table tbody tr {
  height: 80px;
}
</style>