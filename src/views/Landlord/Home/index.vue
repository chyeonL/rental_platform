<template>
  <div id="Lhome">
    <div class="top">
      <!-- 现在已出租房间数量 -->
      <div class="card room">
        <p>目前已出租房间数量</p>
        <h2>{{$store.state.Administrator.rentedOut}}<span> (房间总数：{{$store.state.Administrator.all}})</span></h2>
        <Chart :options="roomNumberChart" class="chart" />
      </div>
      <!-- 网站披露 -->
      <div class="card rent">
        <p>网站披露</p> 
        <h4>门牌号：{{website.HouseNumber}}</h4>      
        <h4>联系电话：{{website.Contact}}</h4>      
        <h4>出租屋简介：{{website.More}}</h4>     
      </div>
      <!-- 个人信息 -->
      <div class="card person">
        <p>帐户信息</p>
        <h4>区域：{{$store.state.Administrator.userInfo.Area}}</h4>     
        <h4>角色：{{$store.state.Administrator.role==='landlord'?'房东':'工作人员'}}</h4>      
        <h4>管理员ID：{{$store.state.Administrator.adminID}}</h4>      
      </div>
    </div>

    <!-- 快速操作 -->
    <div class="operations">
      <h3>快速操作</h3>
      <div class="toolbox">
      <!-- 一键出租 -->
        <div class="tool" @click="$router.push('/landlord/contract/new')">
          <div class="up icon">
            <i class="iconfont icon-hetong-1"></i>
          </div>
          <div class="down name">出租</div>
        </div>
      <!-- 一键退租 -->
        <div class="tool" @click="$router.push('/landlord/contract/all')">
          <div class="up icon">
            <i class="iconfont icon-ico_qiantaijiedai_banlituifang"></i>
          </div>
          <div class="down name">退房</div>
        </div>
      <!-- 一键报备 -->
        <div class="tool" @click="$router.push('/landlord/tenant/all')">
          <div class="up icon">
            <i class="iconfont icon-13"></i>
          </div>
          <div class="down name">人员报备</div>
        </div>
      <!-- 填写意见 -->
        <div class="tool" @click="$router.push('/landlord/opinion/all')">
          <div class="up icon">
            <i class="iconfont icon-cangpeitubiao_xiugaixiugaiziliao"></i>
          </div>
          <div class="down name">意见反馈</div>
        </div>
      </div>
    </div>

    <!-- 折线图 -->
    <div class="wrapper">
      <!-- 已出租的房间 - 房型 柱状-->
      <Chart :options="roomtypes" class="roomtype" />
      <!-- 我提交的意见 处理状态 饼图 -->
      <Chart :options="opinion" class="opinion" />
    </div>    
  </div>
</template>

<script>
import Chart from "@/components/common/Chart.vue";
export default {
  name: "Lhome",
  components: { Chart },
  data() {
    return {
      // 房间数量 折线图
      roomNumberChart: {
        option: {
          xAxis: {
            type: "category",
            show: false,
          },
          yAxis: {
            type: "value",
            show: false,
          },
          series: [
            {
              data: [150, 230, 104, 218, 335, 307, 260, 248, 290],
              type: "line",
            },
          ],
          grid: {
            x: 40,
            x2: 10,
            y: 70,
          },
        },
        w: 300,
        h: 80,
        note: "",
      },
      // 已出租的房间 房型柱状图
      roomtypes: {
        option: {
          color: [ "#FFD04B"],
          tooltip: {},
          legend: {
            itemWidth: 15,
            right: 40,
            top: 35,
          },
          grid: {
            top: 70,
            bottom: 30,
            left: 30,
          },
          title: {
            text: "已出租房间的房型占比图",
            top: 15,
            left: 20,
          },
          xAxis: [
            {
              data: [],
              axisLabel: {
                interval: 0,
                rotate: 0,
              },
            },
          ],
          yAxis: [
            {
              type: "value",
              // show:false
            },
          ],
          series: [
            {
              type: "bar",
              data: [],
            },
          ],
        },
        w: "450px",
        h: "350px",
        note:'roomtype'
      },
      // 意见饼图
      opinion: {
        option: {
          backgroundColor: "#2c343c",
          title: {
            text: "我提交的意见",
            left: "center",
            top: 20,
            left: 20,
            textStyle: {
              color: "#ffd04b",
            },
          },
          tooltip: {
            trigger: "item",
          },
          visualMap: {
            show: false,
            min: -3,
            max: 10,
            inRange: {
              colorLightness: [0, 1],
            },
          },
          grid: {
            x: 40,
            x2: 0,
            y: 100,
            y2: 20,
          },
          series: [
            {
              type: "pie",
              radius: "60%",
              center: ["50%", "50%"],
              data: [],
              roseType: "radius",
              label: {
                color: "rgba(255, 255, 255, 0.3)",
              },
              labelLine: {
                lineStyle: {
                  color: "rgba(255, 255, 255, 0.3)",
                },
                smooth: 0.2,
                length: 10,
                length2: 20,
              },
              itemStyle: {
                color: "#c23531",
                shadowBlur: 200,
                shadowColor: "rgba(0, 0, 0, 0.5)",
              },
              animationType: "scale",
              animationEasing: "elasticOut",
              animationDelay: function (idx) {
                return Math.random() * 200;
              },
            },
          ],
        },
        w: "400px",
        h: "300px",
        note: "opinion",
      },
      // 网站披露
      website:{
        More:'',
        Contact:'',
        HouseNumber:''
      }
    };
  },
  created() {
    this.$store.dispatch("RentedOutRooms");
    this.$store.dispatch('GetHouseInfoByID',this.$store.state.Administrator.adminID).then(res=>{
      this.website.More=res.data[0].More
      this.website.Contact=res.data[0].Contact
      this.website.HouseNumber=res.data[0].HouseNumber
    })
  },
};
</script>

<style scoped lang="scss">
#Lhome {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  justify-content: space-around;
  margin-top: 10px;
}
.top {
  width: 100%;
  display: flex;
  align-items: center;
  justify-content: start;
}

.saeles {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 1200px;
}

.card {
  width: 25%;
  height: 130px;
  padding: 10px 20px;
  margin: 0 20px;
  background-color: #fff;
  display: flex;
  flex-direction: column;
  align-items: start;
  justify-content: space-around;
  box-shadow: 0px 0px 30px 0px rgb(0 0 0 / 50%);
  h2 {
    padding-top: 5px;
    font-size: 25px;
    span {
      font-size: 13px;
      margin-left: 10px;
    }
  }
}
.room {
  border-left: 6px solid #768cd1;
  p{
    margin-top: 20px;
  }
}
.rent {
  border-left: 6px solid #ff8800;
}
.person {
  border-left: 6px solid #b057fe;
}
.operations {
  width: 95%;
  background-color: #fff;
  border-radius: 10px;
  margin: 40px 0;
  margin-left: 20px;
  margin-right: 5%;
  h3 {
    color: #ffd04b;
    background-color: #24292e;
    height: 50px;
    line-height: 50px;
    padding-left: 30px;
    font-size: 15px;
    border-top-left-radius: 10px;
    border-top-right-radius: 10px;
  }
}
.toolbox {
  display: flex;
  align-items: center;
  justify-content: space-around;
  .tool {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: space-around;
    width: 25%;
    padding: 20px;
    height: 100px;
    box-sizing: border-box;
    .up {
      margin-bottom: 10px;
      i {
        font-size: 30px;
      }
    }
    &:hover {
      cursor: pointer;
      color: #ffd04b;
      background-color: #303438;
    }
  }
}
.wrapper {
  width: 95%;
  display: flex;
  align-items: center;
  justify-content: space-around;
  .roomtype{
    padding: 10px;
    background-color: #fff;
  }
  // .opinion {
  //   &>div>canvas{
  //     border-radius: 30px !important;
  //   }
  // }
}
</style>