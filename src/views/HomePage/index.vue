<template>
  <div id="HomePage">
    <!-- 顶部 -->
    <nav class="rentNav">
      <div class="left">
        <a href="#">
          <h2>{{HouseInfo.HouseNumber}} {{VillageInfo.Area}} 出租屋</h2>
        </a>
        <div class="hello">
          <!--  class="my" -->
          <span v-if="$store.state.Administrator.isLogin">Hello，{{$store.state.Administrator.userInfo.Name}}</span>
          <span @click="logout" class="logout" v-if="$store.state.Administrator.isLogin">登出</span>
          <span v-else>Welcome to our village!</span>
          <span @click="viewHistory" class="history" v-if="$store.state.Administrator.isLogin&&$store.state.Administrator.role == 'visitor'"><i class='iconfont icon-baogao'></i>预约历史</span>
        </div>
      </div>
      <div class="right">
        <!-- 下拉框 -->
        <div class="village">
          <el-dropdown>
            <i class="iconfont icon-w_cunzhuang">{{VillageInfo.Area}}</i>
            <el-dropdown-menu slot="dropdown" class="">
              <el-dropdown-item v-for="(item,index) in villageList" :key='index' @click.native="changeVillage(item.AreaID)">{{item.Area}}</el-dropdown-item>
            </el-dropdown-menu>
          </el-dropdown>
        </div>
        <div class="house">          <!-- HouseList -->
          <el-dropdown>
            <i class="iconfont icon-shouye">{{HouseInfo.HouseNumber}}</i>  
            <el-dropdown-menu slot="dropdown" class="">
              <el-dropdown-item v-for="(item,index) in HouseList" :key='index' @click.native="changeHouse(item.Landlord_ID,item.AreaID)">{{item.HouseNumber}}</el-dropdown-item>
            </el-dropdown-menu>
          </el-dropdown>
        </div>
        <div class="system" @click="goSystem" v-if="$store.state.Administrator.isLogin">
            <i class="iconfont icon-shezhi"></i>
            管理后台
        </div>
        <div class="login" @click="visitor" v-if="!$store.state.Administrator.isLogin">
            <!-- <i class="iconfont icon-shezhi"></i> -->
            登录/注册
        </div>
      </div>
    </nav>

    <!-- 图片 -->
    <div class="rentCover">
      <div class="left">
        <div class="banner1" :style="{backgroundImage:`url(${banner1})`}"></div>
      </div>
      <div class="right">
        <div class="up">
          <div class="banner2" :style="{backgroundImage:`url(${banner2})`}"></div>
        </div>
        <div class="down">
          <div class="l">
            <div class="banner3" :style="{backgroundImage:`url(${banner3})`}"></div>
          </div>
          <div class="r">
            <div class="banner4" :style="{backgroundImage:`url(${banner4})`}"></div>
          </div>
        </div>
      </div>
    </div>

    <!-- 导航栏 -->
    <div class="rentSubNav"  :class="{ fixed: isFixed }">
      <div class="left">
        <div v-for="(item,index) in navList" :key='index' @click="toBox(index)" :class="{ active: currentNav == index }">{{item}}</div>
      </div>
      <div class="right">       
        <span> <i class="iconfont icon-w_cunzhuang"></i>  村庄资讯</span>
        <div class="villageInfo">
          <div class="brief block">
            <div class="headliner">简单介绍</div>
            <div class="content">
              {{VillageInfo.Brief}}
            </div>
          </div>
          <div class="location block">
            <div class="headliner">地理位置</div>
            <div class="content">
              {{VillageInfo.Location}}
            </div>
          </div>
          <div class="work block">
            <div class="headliner">联系工作人员</div>
            <div class="content workk">
              <div class="col wechat">
                <i class="iconfont icon-24gf-phoneLoudspeaker"></i>
                <span>{{VillageInfo.Contact}}</span>
              </div>
              <div class="col office">
                <i class="iconfont icon-Name-Tag"></i>
                <span>{{VillageInfo.Office}}</span>
              </div>
            </div>
          </div>
        </div>
      </div>      
    </div>

    <!-- 内容区 -->
    <div class="main">
      <!-- 房型列表 -->
      <div class="box houseType" id="houseType" v-if="roomtypeList.length">
        <div class="typeCard" v-for="item in roomtypeList" :key='item.No'>
          <div class="up">
            {{item.Type}}
            <el-button type="primary" round @click="book(item.Type)" v-if="$store.state.Administrator.role == 'visitor'||!$store.state.Administrator.isLogin">+ 预约看房</el-button>
          </div>
          <div class="down">
            <div class="pic">
              <div class="img" :style='{backgroundImage:`url(${item.Picture})`}'></div>
            </div>
            <div class="detail">
              <div class="price"><div>CNY {{item.Price}}</div></div>
              <div class="limit row">
                <div class="people">
                  <div class="title">房间总数</div>
                  <div class="info">{{item.Amount}}</div>
                </div>
                <div class="square">
                  <div class="title">可出租房间</div>
                  <div class="info">{{item.AvailableRoomsQuantity}}</div>
                </div>
              </div>
              <div class="roomType row">
                <div class="title">坪数</div>
                <div class="info">{{item.Square}} 平方米</div>
              </div>
              <div class="limit row">
                <div class="people">
                  <div class="title">按押方式</div>
                  <div class="info">{{item.MortgageMethod}}</div>
                </div>
                <div class="square">
                  <div class="title">押金</div>
                  <div class="info">{{item.MortgageCash}}</div>
                </div>
              </div>
              <div class="facility row">
                <div class="title">设施</div>
                <div class="info">
                  <div class="fac">
                    {{item.Furnishment}}
                  </div>
                </div>
              </div>
            </div>
            </div>
          </div>
       
      </div>
      <div class="noRoomtype" v-else>
        <img :src="NoRoomtype" alt="">
        <p>
          <i class="iconfont icon-zhuyi"></i>
          暂无可出租的房型房间
        </p>
      </div>


      <!-- 出租资讯 -->
      <!-- 出租屋设施 -->
      <div class="box houseFac" id="houseInfo">
        <!-- 设施 -->
        <div class="facility block">
          <div class="headliner">出租屋设施</div>
          <div class="row">
            <div class="title">公共区域设施与服务</div>
            <div class="content">
              <div class="faci">
                <i class="iconfont icon-louti"></i>
                <span>需上下楼梯</span>
              </div>
              <div class="faci">
                <i class="iconfont icon-chongdianzhong"></i>
                <span>电动车充电</span>
              </div>
              <div class="faci">
                <i class="iconfont icon-wifi"></i>
                <span>无线WIFI</span>
              </div>
              <div class="faci">
                <i class="iconfont icon-jianlixunshi"></i>
                <span>不定时巡查</span>
              </div>
              <div class="faci">
                <i class="iconfont icon-qingjie"></i>
                <span>楼道清洁</span>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="title">安全设施</div>
            <div class="content">
              <div class="faci">
                <i class="iconfont icon-shipinjiankong"></i>
                <span>监控</span>
              </div>
              <div class="faci">
                <i class="iconfont icon-zuoce-anfangmenjin"></i>
                <span>门禁</span>
              </div>
              <div class="faci">
                <i class="iconfont icon-qitimiehuo"></i>
                <span>灭火器</span>
              </div>
            </div>
          </div>
          <div class="row more">
            <div class="title" style="color: #e07612">需另外付费</div>
            <div class="content">
              <div class="faci">
                <i class="iconfont icon-tingchechang" style="color: #e07612"></i>
                <span style="color: #e07612">停车场</span>
              </div>
              <div class="faci">
                <i class="iconfont icon-luyoubiao" style="color: #e07612"></i>
                <span style="color: #e07612">设置路由</span>
              </div>
            </div>
          </div>
        </div>       
      </div>

       <!-- 出租资讯 -->
      <div class="box houseInfo">
        <div class="house block">
          <div class="headliner">出租资讯</div>
          <div class="content">
            {{HouseInfo.Brief}}
          </div>
        </div>
        <!-- 联络资讯 -->
        <div class="contact block">
          <div class="headliner">联络资讯</div>
          <div class="content">
            <div class="LandlordName">
              <i class="iconfont icon-wode"></i>
              <span>{{HouseInfo.LandlordName}}</span>
            </div>
            <div class="tel"> 
              <i class="iconfont icon-24gf-phoneLoudspeaker"></i>
              <span>{{HouseInfo.Contact}}</span>
            </div>
          </div>
        </div>
        <!-- 更多 -->
        <div class="more block">
          <div class="headliner">更多资讯</div>
          <div class="content">
            <i class="iconfont icon-a-quanbusuoyou-08"></i>
            <span>{{HouseInfo.More}}</span>
          </div>
        </div>
        <!-- 村庄资讯给的位置 -->
        <div class="location block">
          <div class="headliner">位置</div>
          <div class="content">
            <div class="map"></div>
          </div>
        </div>
      </div>
      
    </div>
      
      <!-- 提交预约 -->
     <el-dialog
      title="提交预约"
      :visible.sync="visible"
      width="35%"
      center
      :lock-scroll='true'
    >
      <el-form
        :model="info"
        status-icon
        ref="info"
        :rules="rules"
        label-width="100px"
        class="demo-ruleForm"
      >      
        <el-form-item label="名字" prop="Name">
          <el-input v-model="info.Name"
            autocomplete="off" disabled></el-input>
        </el-form-item>
        <el-form-item label="看房时间" prop="Time">
          <el-date-picker
              type="date"
              placeholder="选择日期"
              value-format='yyyy-MM-dd'
              v-model="info.Time"   
            ></el-date-picker>
        </el-form-item>
        <el-form-item label="联系电话" prop="Contact">
          <el-input
            v-model="info.Contact"
            autocomplete="off"
            disabled
          ></el-input>
        </el-form-item>
        <el-form-item label="性别" prop="Gender">
          <el-select v-model="info.Gender" clearable placeholder="请选择" class="small">
              <el-option label="男" value="男"></el-option>
              <el-option label="女" value="女"></el-option>
            </el-select>
        </el-form-item>
        <el-form-item label="详细需求" prop="Requirement">
          <el-input
            v-model="info.Requirement"
            autocomplete="off"
            placeholder="可以附加说明详细的租房需求"
            type="textarea"
          ></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitMyInfo('info')"
          >确 定</el-button
        >
      </span>
    </el-dialog>


      <!-- 预约历史 -->
     <el-dialog
      title="预约历史"
      :visible.sync="historyVisible"
      width="60%"
      center
      :lock-scroll='true'
    >
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
        <el-table-column label="数据操作" width="160" class="operation" fixed="right" align="center">
          <template slot-scope="scope">
            <el-button type="info" @click="handleEdit(scope.$index, scope.row)" class="button">修改时间</el-button>
            <el-button
              type="danger"
              @click="handleDelete(scope.$index, scope.row)"
               class="button"
              >取消预约</el-button
            >
          </template>
        </el-table-column>
      </el-table>
    <Pagination
      :total="total"
      :currentPage="currentPage"
      :pageSize="pageSize"
      @changePageNo="changePageNo"
    />
    </el-dialog>
      
      <!-- 修改时间 -->
     <el-dialog
      title="修改时间"
      :visible.sync="rescheduleVisible"
      width="40%"
      center
      :lock-scroll='true'
    >
      <el-form
        :model="reschedule"
        status-icon
        ref="reschedule"
        :rules="rescheduleTime"
        label-width="100px"
        class="demo-ruleForm"
      >      
        <el-form-item label="看房时间" prop="Time">
          <el-date-picker
              type="date"
              placeholder="选择日期"
              value-format='yyyy-MM-dd'
              v-model="reschedule.Time"   
            ></el-date-picker>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submit"
          >确 定</el-button
        >
      </span>
    </el-dialog>


    <!-- 页脚 -->
    <footer>
      <div class="houseName">
        <span>{{HouseInfo.HouseNumber}} {{VillageInfo.Area}} 出租屋</span>
      </div>
      <div class="HouseLocation">
        <i class="iconfont icon-icon_location"></i>
        <span>{{VillageInfo.Location}} {{HouseInfo.HouseNumber}}</span>
      </div>
      <div class="HouseTel">
        <i class="iconfont icon-24gf-phoneLoudspeaker"></i>
        <span>{{HouseInfo.Contact}}</span>
      </div>
      <div class="support">
        Powered by <span>Chiuyan</span>
      </div>
    </footer>

  </div>
</template>

<script>
import Pagination from "@/components/common/Pagination.vue";
import { mapState } from "vuex";
export default {
  name: "HomePage",
  components: { Pagination },
  data() {
    var reg_tel =
      /^(13[0-9]|14[01456879]|15[0-35-9]|16[2567]|17[0-8]|18[0-9]|19[0-35-9])\d{8}$/;
    var validateTel = (rule, value, callback) => {
      if (value === "") {
        callback(new Error("请输入手机号"));
      } else if (!reg_tel.test(value)) {
        callback(new Error("请输入11位规范手机号"));
      } else {
        callback();
      }
    };
    return {
      banner1: "", // ./banner1.jpeg
      banner2: "",
      banner3: "",
      banner4: "",
      type: "", // ./type.jpeg"
      isFixed: false,
      currentNav: 0,
      navList: ["房型", "出租屋设施", "出租资讯"],
      map: {},
      markerLayer: {},
      center: { lat: 0, lng: 0 }, // 地图中心点，根据VillageInfo的location转换
      villageList: ["法仔庄", "矜用庄"], // 村庄list
      HouseList: ["七巷1号", "八巷2号"], // 出租屋list
      VillageInfo: {}, // 村庄资讯
      HouseInfo: {}, // 出租资讯
      roomtypeList: [], // 房型列表
      NoRoomtype: "./NoRoomtype.png",
      visible: false,
      info: {
        Name: "",
        Time: "",
        Contact: "",
        Gender: "",
        Requirement: "",
        Roomtype: "",
      },
      rules: {
        Name: [{ required: true, trigger: "blur", message: "请输入姓名" }],
        Time: [{ required: true, trigger: "blur", message: "请选择时间" }],
        Contact: [{ required: true, validator: validateTel, trigger: "blur" }],
        Gender: [{ required: true, trigger: "change", message: "请选择" }],
      },
      historyVisible: false, // 预约历史
      form: {
        BookingStatus: "",
        ID: "",
        Name: "",
        Gender: "",
        Contact: "",
        Time: "",
        Requirement: "",
        Roomtype: "",
      },
      currentPage: 1,
      rescheduleVisible: false, // 修改时间
      reschedule: {
        Time: "",
      },
      rescheduleTime: {
        Time: [{ required: true, trigger: "blur", message: "请选择时间" }],
      },
      TempNo: 0,
    };
  },
  computed: {
    push() {
      if (
        this.$store.state.Administrator.role &&
        this.$store.state.Administrator.role != "visitor"
      )
        return "/" + this.$store.state.Administrator.role;
      else return "/";
    },
    ...mapState({
      total: (state) => state.RoomType.total,
      pageNo: (state) => state.RoomType.pageNo,
      all: (state) => state.RoomType.all,
      list: (state) => state.RoomType.list,
      pageSize: (state) => state.RoomType.pageSize,
      search: (state) => state.RoomType.search,
      userInfo: (state) => state.Administrator.userInfo,
    }),
  },
  created() {
    // 获取 村庄list
    this.$store.dispatch("GetVillageList").then((res) => {
      this.villageList = res;
      // 当前村庄
      this.$store.dispatch("GetCurrentVillage").then((res) => {
        this.VillageInfo = res.data[0];
        // 腾讯地图
        this.addrToGetCoordinate(this.VillageInfo.Location); // 将位置转变为经纬度
        this.loadScript();

        // 获取出租屋list
        this.$store
          .dispatch("GetHouseList", this.VillageInfo.AreaID)
          .then((res) => {
            this.HouseList = res;
            // 当前出租屋
            this.$store
              .dispatch("GetCurrentHouse", this.VillageInfo.AreaID)
              .then((res) => {
                this.HouseInfo = res.data[0];
                this.banner1 = this.HouseInfo.Cover1;
                this.banner2 = this.HouseInfo.Cover2;
                this.banner3 = this.HouseInfo.Cover3;
                this.banner4 = this.HouseInfo.Cover4;
                this.$store
                  .dispatch("getRoomtypeList", this.HouseInfo.Landlord_ID)
                  .then((res) => {
                    this.roomtypeList = res;
                    for (let obj in this.roomtypeList) {
                      var str = this.roomtypeList[obj].Furnishment.slice(
                        0,
                        this.roomtypeList[obj].Furnishment.length
                      );
                      var arr = str.split("，");
                      this.roomtypeList[obj].facilities = [];
                      arr.forEach((i) => {
                        this.roomtypeList[obj].facilities.push(i);
                      });
                    }
                  });
              });
          });
      });
    });
  },
  mounted() {
    // console.log(this.push);
    window.addEventListener("scroll", this.handleScroll); // 监听滑动事件
    this.info.Name = this.userInfo.Name;
    this.info.Contact = this.userInfo.Tel;
  },
  destroyed() {
    window.removeEventListener("scroll", this.handleScroll); // 销毁监听滑动事件
  },
  methods: {
    // 处理滚动
    handleScroll() {
      var scrollTop =
        window.pageYOffset ||
        document.documentElement.scrollTop ||
        document.body.scrollTop;
      // console.log(scrollTop) // 滑动的长度 offsetParent
      var offsetTop =
        document.querySelector(".rentNav").offsetHeight +
        document.querySelector(".rentCover").offsetHeight +
        document.querySelector(".rentCover").offsetHeight / 2;

      // console.log(document.querySelector(".rentSubNav").offsetTop);

      // 吸顶效果
      if (scrollTop > offsetTop) {
        this.isFixed = true;
      } else {
        this.isFixed = false;
      }
    },
    // 滚动到哪一块
    toBox(index) {
      this.currentNav = index;
      const DOM = document.querySelectorAll(".box")[index];
      let offsetTop = DOM.offsetTop - 120;
      if (index == 1) offsetTop -= 90; // 滚动的位置没错，但是因为导航栏吸顶会遮住，所以需要减去
      // console.log('滚动到哪里', DOM)
      window.scrollTo({
        top: offsetTop,
        behavior: "smooth",
      });
    },

    // 切换村庄
    changeVillage(AreaID) {
      this.$store.dispatch("ChangeVillage", AreaID).then((res) => {
        this.$router.go(0);
      });
    },
    // 切换出租屋
    changeHouse(Landlord_ID, AreaID) {
      this.$store
        .dispatch("ChangeHouse", { AreaID, Landlord_ID })
        .then((res) => {
          this.$router.go(0);
        });
    },

    book(type) {
      if (!this.$store.state.Administrator.isLogin) {
        this.$notify({
          type: "warning",
          title: "限制提醒",
          message: "请先前往登录",
          offset: 100,
          duration: 3000,
        });
        return;
      }
      this.visible = true;
      this.reset();
      this.info.Roomtype = type;
      this.$refs.info.clearValidate();
    },

    reset() {
      this.info = {
        Name: this.userInfo.Name,
        Time: "",
        Contact: this.userInfo.Tel,
        Gender: "",
        Requirement: "",
        Roomtype: "",
      };
    },

    // 提交
    submitMyInfo() {
      this.$refs["info"].validate((valid) => {
        if (valid) {
          // console.log(this.info);
          this.$confirm("确认提交预约？", "确认预约", {
            confirmButtonText: "确定",
            cancelButtonText: "取消",
            center: true,
          }).then(() => {
            this.$store.dispatch("NewBooking", this.info).then((res) => {
              if (res.success) {
                this.$notify({
                  title: "成功",
                  offset: 80,
                  duration: 3000,
                  type: "success",
                  message: "成功预约，稍等一会儿房东很快就会确认状态噢！",
                });
              }
              this.visible = false;
              this.reset();
            });
          });
        }
      });
    },

    // 跳转后台
    goSystem() {
      if (this.$store.state.Administrator.role == "visitor") {
        // 访客不可以登陆后台
        this.$notify({
          type: "warning",
          title: "限制提醒",
          message: "抱歉，后台系统目前只为管理员开放使用",
          offset: 100,
          duration: 4000,
        });
        return;
      }
      if (this.push === "/") {
        // this.$message.info("需要登陆以继续");
        this.$router.push({
          name: "Login",
          query: {
            redirect: "/",
          },
        });
      } else this.$router.push(this.push);
    },

    visitor() {
      this.$message.info("需要登陆以继续");
      this.$router.push({
        name: "Login",
        query: {
          redirect: "/",
        },
      });
    },

    logout() {
      this.$confirm("确定退出登录?", "确定", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        center: true,
      })
        .then(() => {
          this.$store.dispatch("Logout").then(() => {
            this.$router.replace("/");
            this.$notify({
              type: "success",
              title: "成功",
              message: "已登出",
              offset: 100,
              duration: 4000,
            });
          });
        })
        .catch(() => {});
    },

    // 腾讯地图
    initMap(lat = 0.0, lng = 0.0) {
      // console.log(lat,lng);
      // 定义map变量，调用 TMap.Map() 构造函数创建地图
      this.map = new TMap.Map(document.querySelector(".map"), {
        center: new TMap.LatLng(lat, lng), // 设置地图中心点坐标
        zoom: 16, // 设置地图缩放级别
        pitch: 30, // 设置俯仰角
        rotation: 0, // 设置地图旋转角度
        viewMode: "3D",
      });
      this.markerLayer = new TMap.MultiMarker({
        // 初始化marker图层（标记点，即红点）
        id: "marker-layer",
        map: this.map,
      });
      // 绑定点击事件
      this.map.on("click", (evt) => {
        console.log(evt);
        const latb = parseFloat(evt.latLng.lat.toFixed(6));
        const lngb = parseFloat(evt.latLng.lng.toFixed(6));
        this.map.setCenter(new TMap.LatLng(latb, lngb));
        // 获取地图标记点（红点）
        const arrB = this.markerLayer.getGeometries();
        if (arrB.length > 1) {
          const delArr = arrB.map((itemB, index) => {
            if (index + 1 < arrB.length) {
              return itemB.id;
            }
          });
          this.markerLayer.remove(delArr);
          this.markerLayer.add({
            position: new TMap.LatLng(latb, lngb),
          });
        }
      });
    },
    // 引入
    loadScript() {
      var script = document.createElement("script");
      script.type = "text/javascript";
      script.src =
        "https://map.qq.com/api/gljs?v=1.exp&key=TUGBZ-X3B3V-SZEPR-5FDDJ-3AIQO-FPFKA&callback=init";
      script.onload = script.onreadystatechange = () => {
        if (
          !this.readyState ||
          this.readyState === "loaded" ||
          this.readyState === "complete"
        ) {
          // 初始化地图，传入地图中心点经纬度
          this.initMap(
            parseFloat(this.center.lat),
            parseFloat(this.center.lng)
          );
          // console.log(parseFloat(this.center.lat), parseFloat(this.center.lng));
          // 给地图中心点添加标记（红点）
          this.markerLayer.add({
            position: new TMap.LatLng(
              parseFloat(this.center.lat),
              parseFloat(this.center.lng)
            ),
          });
          script.onload = script.onreadystatechange = null;
        }
      };
      document.body.appendChild(script);
    },
    // 根据位置获取经纬度（腾讯地图）
    async addrToGetCoordinate(addr) {
      await this.$jsonp("https://apis.map.qq.com/ws/geocoder/v1/", {
        key: "TUGBZ-X3B3V-SZEPR-5FDDJ-3AIQO-FPFKA",
        output: "jsonp",
        address: addr,
        timeout: 20000,
      })
        .then((res) => {
          // console.log(res);
          if (res.status === 0) {
            // console.log(
            //   "当前村庄位置经纬度",
            //   res.result.location.lat.toFixed(6),
            //   res.result.location.lng.toFixed(6)
            // );
            this.center = {
              lat: res.result.location.lat.toFixed(6),
              lng: res.result.location.lng.toFixed(6),
            };
            // console.log(this.center);
          }
        })
        .catch((e) => {
          console.log(e);
        });
    },
    //修改地图的中心点
    changeCenter(lat, lng) {
      this.map.setCenter(new TMap.LatLng(lat, lng));
    },

    viewHistory() {
      this.historyVisible = true;
      this.getData();
    },

    async getData(pageNo = 1) {
      await this.$store
        .dispatch("ViewHistory", {
          pageNo,
          Name: this.info.Name,
          Contact: this.info.Contact,
        })
        .then(() => (this.type = "all"));
    },

    changePageNo(pageNo) {
      this.getData(pageNo);
    },

    handleEdit(index, row) {
      this.rescheduleVisible = true;
      this.TempNo = row.No;
      this.reschedule.Time = "";
      this.$refs.reschedule.clearValidate();
    },

    submit() {
      this.$refs["reschedule"].validate((valid) => {
        if (valid) {
          this.$confirm("确认修改时间?", "确认修改", {
            confirmButtonText: "确定",
            cancelButtonText: "取消",
            center: true,
          }).then(async () => {
            await this.$store
              .dispatch("rescheduleBooking", {
                No: this.TempNo,
                Time: this.reschedule.Time,
              })
              .then(() => {
                this.getData();
                this.rescheduleVisible = false;
              });
          });
        }
      });
    },

    handleDelete(index, row) {
      this.$confirm("确认取消预约?", "确认取消", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        center: true,
      }).then(async () => {
        await this.$store.dispatch("DeleteBooking", row.No).then(() => {
          this.getData();
          this.historyVisible = false;
        });
      });
    },
  },
};
</script>

<style scoped lang='scss'>
#HomePage {
  min-width: 1260px;
  background-color: rgb(255, 255, 255);
}
// 顶部
.rentNav {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
  height: 2.1333rem;
  padding: 3rem 4rem;
  box-sizing: border-box;
  background-color: #fff;
  .left {
    display: flex;
    align-items: flex-end;
    a {
      color: black;
      h2 {
        font-weight: normal;
      }
    }
    .hello {
      color: #686e74;
      margin-left: 50px;
      font-size: 14px;
      .logout,
      .my {
        margin-left: 20px;
        font-size: 12px;
        color: #dba000;
        border-bottom: 1px solid;
        &:hover {
          cursor: pointer;
        }
      }
      .history {
        margin-left: 40px;
        font-size: 14px;
        vertical-align: top;
        &:hover {
          cursor: pointer;
          font-weight: 700;
          color: #000;
        }
      }
    }
  }
  .right {
    display: flex;
    align-items: center;
    justify-content: space-between;
    color: #686e74;
    i {
      color: #686e74;
    }
    div {
      padding: 0.8rem;
      cursor: pointer;
    }
    .system {
      font-size: 0.9rem;
      &:hover {
        color: #dba000;
        border-bottom: 1px solid;
      }
      &:hover i {
        color: #dba000;
      }
    }
    .login {
      font-size: 0.9rem;
      color: #dba000;
      border-bottom: 1px solid;
    }
    .el-dropdown .village i {
      font-size: 1rem;
    }
  }
}
// banner
.rentCover {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
  height: 20rem;
  .left {
    width: 65%;
    height: 100%;
    box-sizing: border-box;
    overflow: hidden;
    position: relative;
  }
  .right {
    width: 35%;
    height: 100%;
    margin-left: 5px;
    overflow: hidden;
    .up {
      width: 100%;
      height: 60%;
      margin-bottom: 5px;
      overflow: hidden;
      position: relative;
    }
    .down {
      display: flex;
      justify-content: space-between;
      align-items: center;
      width: 100%;
      height: 40%;
      overflow: hidden;
      & > div {
        width: 49%;
        height: 100%;
        padding: 2px;
        overflow: hidden;
        position: relative;
      }
    }
  }
  .banner1,
  .banner4,
  .banner3,
  .banner2 {
    position: absolute;
    background-size: cover;
    background-position: 50%;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
  }
  .banner1:hover,
  .banner4:hover,
  .banner3:hover,
  .banner2:hover {
    transition: all 0.6s;
    transform: scale(1.2);
  }
}
// 导航栏
.rentSubNav {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
  height: 1rem;
  padding: 2.5rem 4rem;
  margin-bottom: 2.5rem;
  background-color: #fff;
  box-sizing: border-box;
  box-shadow: 0 25px 40px -15px rgb(92 101 107 / 20%);
  .left {
    display: flex;
    align-items: center;
    justify-content: start;
    font-size: 1rem;
    // background-color: #e4dcc3;
    & > div {
      padding: 0.5rem;
      margin-right: 2.5rem;
      box-sizing: border-box;
      .color {
        color: #dba000;
      }
      &:hover {
        color: #dba000;
        border-bottom: 1px solid;
        cursor: pointer;
      }
    }
  }
  .right {
    position: relative;
    font-size: 1rem;
    color: #686e74;
    padding-right: 25%;
    & > span {
      display: block;
      height: 100%;
      padding-bottom: 10px;
      border-bottom: 1px solid #686e74;
      box-sizing: border-box;
      i {
        font-size: 1.3rem;
      }
    }
  }
}
// 内容区
.main {
  display: flex;
  flex-direction: column;
  align-items: start;
  justify-content: start;
  min-width: 47rem;
  max-width: 60%;
  padding-left: 4rem;
  .houseType {
    width: 100%;
    margin-bottom: 100px;
  }
  .typeCard {
    width: 100%;
    display: flex;
    flex-direction: column;
    align-items: start;
    justify-content: start;
    box-sizing: border-box;
    margin-bottom: 5rem;
    .up {
      font-size: 1.2rem;
      // height: 2rem;
      padding-bottom: 10px;
      // background-color: #078abc;
      .el-button {
        padding: 15px 30px;
        color: #ffd04b;
        background-color: #23272a;
        padding: 12px 15px;
        margin-left: 70px;
        border-radius: 15px;
        font-weight: 700;
        border: none;
        i {
          color: #66ff1f;
          width: 100px;
        }
      }
    }
    .down {
      display: flex;
      align-items: center;
      justify-content: space-between;
      width: 100%;
      height: 19rem;
      border-bottom: 1px solid #ccc;
      .pic {
        width: 50%;
        height: 100%;
        position: relative;
        overflow: hidden;
        .img {
          position: absolute;
          top: 0;
          left: 0;
          width: 100%;
          height: 100%;
          background-size: cover;
          background-position: 50%;
        }
      }
    }
  }
  .detail {
    width: 50%;
    height: 100%;
    display: flex;
    flex-direction: column;
    align-items: start;
    justify-content: space-between;
    padding: 0 2rem;
    box-sizing: border-box;
    .price {
      width: 100%;
      height: 30px;
      position: relative;
      div {
        position: absolute;
        top: 0;
        right: 0;
        background-color: #fff;
        border: 1px solid #ccc;
        // width: 110px;
        padding: 5px 15px;
        border-radius: 10px;
        box-sizing: border-box;
        color: #ccc;
        text-align: center;
      }
    }
    .row {
      display: flex;
      flex-direction: column;
      justify-content: start;
      width: 100%;
      height: 70px;
      box-sizing: border-box;
      font-size: 15px;
      padding: 5px 0;
    }
    .limit {
      display: flex;
      justify-content: start;
      align-items: center;
      flex-direction: row;
      .people,
      .square {
        width: 50%;
      }
    }
    .title {
      color: #686e74;
      margin-bottom: 8px;
    }
  }
  .houseFac,
  .houseInfo {
    width: 100%;
    .block {
      margin-bottom: 5rem;
      .headliner {
        font-size: 1.2rem;
        color: #3c4145;
      }
      .row {
        // height: 5rem; // 140px
        padding: 1.5rem 0.5rem;
        // background-color: blanchedalmond;
        border-bottom: 1px solid #ccc;
        .title {
          font-size: 1rem;
          // font-weight: 700;
          color: #3c4145;
          margin-bottom: 1rem;
        }
        .content {
          display: flex;
          align-items: center;
          // justify-content: space-between;
          flex-wrap: wrap;
          .faci {
            width: 25%;
            height: 2rem;
            margin-bottom: 1rem;
            font-size: 1rem;
            i {
              margin-right: 8px;
            }
          }
          .more .title {
            color: #e07612 !important;
          }
        }
      }
      .content {
        padding: 0 5rem 0 1rem;
        margin-top: 1.5rem;
        display: flex;
        align-items: center;
        justify-content: start;
        .tel,
        .LandlordName {
          padding-bottom: 10px;
          padding-right: 30px;
        }
        i {
          margin-right: 5px;
        }
      }
      .location {
        .content {
          height: 350px;
          padding: 10px 40px;
          margin-top: 20px;
          // box-sizing: border-box;
        }
        ::v-deep .logo-text,
        ::v-deep .tmap-scale-control {
          display: none;
        }
      }
    }
  }
  .box {
    margin-bottom: 10px;
  }
}
// 页脚
footer {
  width: 100%;
  height: 13rem;
  padding: 0 4rem;
  box-sizing: border-box;
  background-color: #f8fafc;
  .houseName {
    font-size: 1.1rem;
    padding: 2rem 0 1.5rem 0;
    border-bottom: 1px solid #ccc;
    span {
      color: #3c4145;
    }
  }
  .HouseLocation {
    padding: 1.2rem 0;
    span {
      color: #3c4145;
    }
    i {
      color: #3c4145;
      margin-right: 0.5rem;
    }
  }
  .HouseTel {
    span {
      color: #3c4145;
    }
    i {
      color: #3c4145;
      margin-right: 0.5rem;
    }
  }
  .support {
    margin-top: 20px;
    text-align: right;
    color: #686e74;
    span {
      color: #078abc;
      font-size: 1.2rem;
      margin-left: 5px;
    }
  }
}
.active {
  font-size: 1rem;
  color: #dba000;
  border-bottom: 1px solid #dba000;
}
// 固定定位 类
.fixed {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 10;
}
// 村庄资讯
.villageInfo {
  position: absolute;
  top: 7rem;
  left: 0;
  width: 24rem;
  padding: 20px 16px 10px 16px;
  box-sizing: border-box;
  background-color: #fff;
  box-shadow: 0 15px 30px -10px rgb(92 101 107 / 15%);
  .block {
    width: 100%;
    margin-bottom: 20px;
    .headliner {
      font-size: 0.9rem;
      color: black;
      font-weight: 600;
      padding-bottom: 10px;
    }
    .content {
      padding: 0 10px;
    }
    .workk {
      width: 100%;
      display: flex;
      justify-content: start;
      align-items: center;
      height: 20px;
      padding-right: 0;
      .col {
        // width: 40%;
        height: 100%;
        font-size: 0.9rem;
        padding: 0 8px;
        i {
          margin-right: 5px;
        }
      }
    }
  }
}
// 下拉框
::v-deep .el-dropdown:hover i {
  color: #000;
}
::v-deep .el-dropdown:hover {
  border-bottom: 1px solid #000;
}
::v-deep .el-dropdown-menu__item:focus,
.el-dropdown-menu__item:not(.is-disabled):hover {
  background-color: rgb(237, 235, 235);
  color: #f8b600;
}
.noRoomtype {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  width: 97%;
  height: 300px;
  align-self: center;
  box-sizing: border-box;
  background-color: #fff;
  text-align: center;
  border: 1px solid #d1d7dd;
  margin-bottom: 30px;
  p {
    margin-top: 20px;
    font-size: 20px;
    i {
      font-size: 20px;
      color: #f7ac15;
    }
  }
}
.el-dialog {
  border-radius: 40px;
}
.demo-ruleForm {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: space-around;
  padding-top: 20px;
  .el-input,
  .el-select {
    width: 200px;
    margin-left: 20px;
  }
  ::v-deep .el-form-item {
    padding: 10px 0;
  }
}
.dialog-footer {
  .el-button {
    color: #ffd04b;
    background-color: #24292e;
    padding: 12px 25px;
    margin-left: 30px;
    border-radius: 15px;
    font-weight: 700;
    i {
      color: #1fa0ff;
      width: 100px;
    }
  }
}
::v-deep .el-dialog--center {
  text-align: center;
  border-radius: 15px;
}
::v-deep .button {
  padding: 5px;
  font-size: 13px;
}
</style>