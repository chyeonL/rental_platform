<template>
  <div id="myNav">
    <!-- staff -->
      <el-menu
        :default-active="$route.path"
        class="el-menu-vertical-demo"
        background-color="#24292e"
        text-color="#fff"
        active-text-color="#ffd04b"
        router
        :collapse="isCollapse"
        :collapse-transition='false'
        :unique-opened=true
        v-if="role==='staff'"
      >
        <!-- Name  -->
        <el-menu-item class="system" :index="index">
          <template slot="title">
            <i class="iconfont icon-Name-Tag"></i>
            <span class="userName">{{$store.state.Administrator.userInfo.Name}}</span>
          </template>        
        </el-menu-item>
        
        <!-- 首页 -->
        <!-- <el-menu-item index="/staff/home">
          <i class="iconfont icon-shouye"></i>
          <span slot="title">首页</span>
        </el-menu-item> -->

        <!-- 二级菜单  出租屋 -->
        <el-submenu index="/staff/house">
          <template slot="title">
            <i class="iconfont icon-guigeguanli"></i>
            <span slot="title">出租屋</span>
          </template>
          <!-- 三级 出租屋-->
          <el-submenu index="/staff/house/all">
            <template slot="title">
              <i class="iconfont icon-loufangfangzi"></i>
              <span slot="title">信息管理</span>
            </template>
              <el-menu-item index="/staff/house/all">- 所有</el-menu-item>
              <el-menu-item index="/staff/house/new">- 新增</el-menu-item>    
          </el-submenu>
        </el-submenu>

        <!-- 流动人员 -->
        <el-submenu index="/staff/migrant">
          <template slot="title">
            <i class="iconfont icon-liudongrenyuan"></i>
            <span slot="title">流动人员</span>
          </template>
          <el-menu-item index='/staff/migrant/all'>
            <template slot="title">
              <i class="iconfont icon-13"></i>
              <span slot="title">来往记录</span>
            </template>
            </el-menu-item>
        </el-submenu>

        <!-- 安全检查 -->
        <el-submenu index="/staff/inspectation">
          <template slot="title">
            <i class="iconfont icon-anquan"></i>
            <span slot="title">安全检查</span>
          </template>
          <el-submenu index='/staff/inspectation/all'>
            <template slot="title">
              <i class="iconfont icon-jianlixunshi"></i>
              <span slot="title">巡视记录</span>
            </template>
            <el-menu-item index="/staff/inspectation/all">- 所有</el-menu-item>
            <el-menu-item index="/staff/inspectation/new">- 新增</el-menu-item>
            <!-- <el-menu-item index="/staff/inspectation/detail">- 具体/编辑</el-menu-item> -->
          </el-submenu>
        </el-submenu>

        <!-- 二级菜单  收集报告 -->
        <!-- <el-submenu index="/staff/report">
          <template slot="title">
            <i class="iconfont icon-zixun"></i>
            <span slot="title">收集报告</span>
          </template>
          <el-submenu index="/staff/report/problem">
            <template slot="title">
              <i class="iconfont icon-wenti"></i>
              <span slot="title">问题报告</span>
            </template>
              <el-menu-item index="/staff/report/problem/all">- 所有</el-menu-item>
              <el-menu-item index="/staff/report/problem/new">- 新增</el-menu-item>
          </el-submenu>
          <el-submenu index="/staff/report/opinion">
            <template slot="title">
              <i class="iconfont icon-13"></i>
              <span slot="title">群众意见</span>
            </template>
              <el-menu-item index="/staff/report/opinion/all">- 所有</el-menu-item>
              <el-menu-item index="/staff/report/opinion/new">- 新增</el-menu-item>
          </el-submenu>
        </el-submenu>       -->

        <!-- 群众意见 -->
        <el-submenu index="/staff/opinion">
          <template slot="title">
            <i class="iconfont icon-zixun"></i>
            <span slot="title">群众意见</span>
          </template>             
          <el-menu-item index="/staff/opinion/all">          
            <template slot="title">
              <i class="iconfont icon-wenti"></i>
              <span slot="title">反馈回复</span>
            </template> 
          </el-menu-item>
        </el-submenu>

        <!-- 二级菜单 网站管理 -->
        <el-submenu index="/staff/website">
          <template slot="title">
              <i class="iconfont icon-guanfangwangzhan"></i>
              <span slot="title">网站管理</span>
          </template>    
          <el-menu-item index="/staff/website">          
            <template slot="title">
              <i class="iconfont icon-zixun1"></i>
              <span slot="title">村庄资讯</span>
            </template> 
          </el-menu-item>
        </el-submenu>

        <!-- 设置 -->
        <el-submenu index="/staff/my">
          <template slot="title">
            <i class="iconfont icon-shezhi"></i>
            <span slot="title">设置</span>
          </template>
          <el-menu-item index="/staff/my">          
            <template slot="title">
              <i class="iconfont icon-wode"></i>
              <span slot="title">我的信息</span>
            </template> 
          </el-menu-item> 
        </el-submenu>
      </el-menu>

    <!-- landlord -->
      <el-menu
          :default-active="$route.path"
          class="el-menu-vertical-demo"
          background-color="#24292e"
          text-color="#fff"
          active-text-color="#ffd04b"
          router
          :collapse="isCollapse"
          :collapse-transition='false'
          :unique-opened=true
          v-if="role==='landlord'"
        >
          <!-- Name  -->
          <el-menu-item class="system" :index="index">
            <template slot="title">
              <i class="iconfont icon-Name-Tag"></i>
              <span class="userName">{{$store.state.Administrator.userInfo.Name}}</span>
            </template>        
          </el-menu-item>
          
          <!-- 首页 -->
          <el-menu-item index="/landlord/home">
            <i class="iconfont icon-shouye"></i>
            <span slot="title">首页</span>
          </el-menu-item>

          <!-- 二级菜单  签署合同 -->
          <el-submenu index="/landlord/contract">
            <template slot="title">
              <i class="iconfont icon-hetong1"></i>
              <span slot="title">签署合同</span>
            </template>
            <el-submenu index="/landlord/contract/all">
              <template slot="title">
                <i class="iconfont icon-hetong-1"></i>
                <span slot="title">合同管理</span>
              </template>
                <el-menu-item index="/landlord/contract/all">- 所有</el-menu-item>
                <el-menu-item index="/landlord/contract/new">- 新增</el-menu-item>    
              <!-- <el-menu-item index="/staff/information/detail">- 具体/编辑</el-menu-item> -->
            </el-submenu>
          </el-submenu>

          <!-- 二级菜单  房间房型 -->
          <el-submenu index="/landlord/house">
            <template slot="title">
              <i class="iconfont icon-ico_shujuchaxunyutongji_jiudianfangjianruzhutongji"></i>
              <span slot="title">出租房</span>
            </template>
            <!-- 三级 -->
            <el-submenu index="/landlord/house/type">
              <template slot="title">
                <i class="iconfont icon-house"></i>
                <span slot="title">房型管理</span>
              </template>
                <el-menu-item index="/landlord/house/type/all">- 所有</el-menu-item>
                <el-menu-item index="/landlord/house/type/new">- 新增</el-menu-item> 
            </el-submenu>
            <!-- 三级 -->
            <el-submenu index="/landlord/house/room">
              <template slot="title">
                <i class="iconfont icon-fangjianshu"></i>
                <span slot="title">房间管理</span>
              </template>
                <el-menu-item index="/landlord/house/room/all">- 所有</el-menu-item>
                <el-menu-item index="/landlord/house/room/new">- 新增</el-menu-item>
            </el-submenu>
          </el-submenu>      
          
          <!-- 二级菜单  收入租金 -->
          <el-submenu index="/landlord/rent">
            <template slot="title">
              <i class="iconfont icon-a-12chuanbozujinjiesuan"></i>
              <span slot="title">收入租金</span>
            </template>
            <!-- 三级 -->
            <el-submenu index="/landlord/rent/all">
              <template slot="title">
                <i class="iconfont icon-wodejifenbao"></i>
                <span slot="title">月租</span>
              </template>
                <el-menu-item index="/landlord/rent/all">- 所有</el-menu-item>
                <el-menu-item index="/landlord/rent/new">- 新增</el-menu-item>
            </el-submenu>
          </el-submenu>  

          <!-- 二级菜单  流动人员 -->
          <el-submenu index="/landlord/tenant">
            <template slot="title">
              <i class="iconfont icon-liudongrenyuan"></i>
              <span slot="title">流动人员</span>
            </template>
                <el-menu-item index="/landlord/tenant/all">
                  <template slot="title">
                    <i class="iconfont icon-13"></i>
                    <span slot="title">租户</span>
                  </template>
                </el-menu-item>
            <!-- <el-submenu index="/landlord/tenant/all">
              <template slot="title">
                <i class="iconfont icon-13"></i>
                <span slot="title">租户</span>
              </template>
                <el-menu-item index="/landlord/tenant/all">- 所有</el-menu-item>
                <el-menu-item index="/landlord/tenant/new">- 新增</el-menu-item>
            </el-submenu> -->
          </el-submenu>    

          <!-- 二级菜单  意见反馈 -->
          <el-submenu index="/landlord/opinion">
            <template slot="title">
              <i class="iconfont icon-a-quanbusuoyou-08"></i>
              <span slot="title">意见反馈</span>
            </template>
            <!-- 三级 -->
            <el-submenu index="/landlord/opinion/all">
              <template slot="title">
                <i class="iconfont icon-baogao"></i>
                <span slot="title">我的意见</span>
              </template>
                <el-menu-item index="/landlord/opinion/all">- 所有</el-menu-item>
                <el-menu-item index="/landlord/opinion/new">- 新增</el-menu-item>
            </el-submenu>
          </el-submenu>     

          <!-- 网站管理 -->
          <el-menu-item index="/landlord/website">
            <i class="iconfont icon-guanfangwangzhan"></i>
            <span slot="title">网站管理</span>
          </el-menu-item>

          <!-- 设置 -->
          <el-menu-item index="/landlord/my">
            <i class="iconfont icon-shezhi"></i>
            <span slot="title">设置</span>
          </el-menu-item>

        </el-menu>
  </div>
</template>

<script>
import { mapState } from "vuex";
export default {
  name: "MyNav",
  props: ["isCollapse"],
  data() {
    return {
      index: "/" + this.$store.state.Administrator.role,
      staff: [],
      landlord: [],
    };
  },
  computed: {
    ...mapState({
      role: (state) => state.Administrator.role,
    }),
  },
};
</script>

<style lang="scss" scoped>
.system {
  i {
    color: #3292f8;
  }
  .userName {
    color: #ffd04b;
    font-weight: 700;
    font-size: 17px;
  }
}

.el-menu {
  border-right: none;
}

.el-menu-vertical-demo:not(.el-menu--collapse) {
  width: 200px;
  height: 100%;
}

.iconfont {
  color: white;
  font-size: 23px;
  margin-right: 10px;
}
</style>
