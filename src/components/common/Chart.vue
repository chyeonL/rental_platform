<template>
  <div class="chart" ref="chart" :style='width'></div>
</template>

<script>
export default {
  name: "Chart",
  props: ["options"],
  mounted() {
    // console.log(this.$props);
    const { option, w, h, note } = this.$props.options;
    var myChart = this.$echarts.init(this.$refs.chart, null, {
      width: w,
      height: h,
    });
    myChart.setOption(option);
    if (note === "opinion") {
      this.$store.dispatch("VariousOpinions").then((res) => {
        // console.log(res);
        myChart.setOption({
          series: [
            {
              type: "pie",
              radius: "60%",
              center: ["50%", "50%"],
              data: res.data.sort(function (a, b) {
                return a.value - b.value;
              }),
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
        });
      });
    }
    if (note === "roomtype") {
      this.$store.dispatch("RoomtypeBarChart").then((res) => {
        // console.log(res);
        myChart.setOption({
          series: [
            {
              type: "bar",
              data: res.data,
               barWidth: 50
            },
          ],
          xAxis: [
            {
              data: res.dataName,
              axisLabel: {
                interval: 0,
                rotate: 0,
              },
            },
          ],
          yAxis: [
            {
              type: "value",
              data: res.dataValue, 
              splitNumber: 4,
            },
          ],
        });
      });
    }
  },
  computed: {
    width() {
      return "width:" + this.$props.options.w;
    },
  },
};
</script>

<style lang="scss" scoped>
.chart {
  //   width: 500px;
  //   height: 350px;
  //   background-color: #fff;
  border-radius: 20px;
  canvas {
    border-radius: 20px;
  }
}
</style>
