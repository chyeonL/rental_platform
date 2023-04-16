<template>
  <div id="roomType_all">
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
            @click="$router.push({name:'newType'})">
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
      >
       <el-table-column
        label="编号"
        prop="No"
        width="50"
        align="center"
        >
        </el-table-column>
        <el-table-column label="房型" prop="Type" align="center"> </el-table-column>
        <el-table-column label="房间总数" prop="Amount" align="center" width="80"> </el-table-column>
        <el-table-column label="可出租" prop="AvailableRoomsQuantity" align="center" width="80"> </el-table-column>
        <el-table-column label="配置" prop="Furnishment" align="center"> </el-table-column>
        <el-table-column label="房间号" prop="RoomNumber" align="center"> </el-table-column>
        <el-table-column label="房租" prop="Price" align="center"></el-table-column>
        <el-table-column label="按押方式" prop="MortgageMethod" align="center" width="80"></el-table-column>
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
        parent: "房间类型",
        parentRoute: "all",
        children: "所有记录",
      },
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
        .dispatch("GetAllRoomType", pageNo)
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
      if (keywords) {
        await this.$store
          .dispatch("SearchRoomtype", { keywords, pageNo })
          .then((res) => {
            this.type = "search";
          });
      } else {
        this.getData(1, this.pageSize); // 搜索之后，删掉关键词，再按回车，重新加载全部数据
      }
    },

    handleEdit(index, row) {
      this.$router.push({
        name: "DetailType",
        query: {
          No: row.No,
        },
      });
    },

    handleDelete(index, row) {
      console.log(row);
      this.$confirm("确认删除该房型?", "确认删除", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        center: true,
      })
        .then(async () => {
          if (row.Amount > 0) {
            this.$notify({
              title: "错误提醒",
              offset: 60,
              duration: 3000,
              type: "error",
              message: `该房型有${row.Amount}个房间,无法直接删除...`,
            });
          } else {
            await this.$store
              .dispatch("DeleteRoomtype", row.No)
              .then(() => this.getData());
          }
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