const { defineConfig } = require('@vue/cli-service')
module.exports = defineConfig({
  transpileDependencies: true,  
  devServer:{
    proxy:{     // 跨域配置
      '/rent':{
        target:'http://localhost:5000',  // 本地服务器，端口号设置为5000
        changeOrigin:true,
        pathRewrite:{
          '^/rent':'/rent'    // 路径重写，/rent前的协议、域名、端口号，通通去掉，换成target
        }
      }
    }
  },
  lintOnSave:false
})
