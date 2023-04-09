<template>
  <div id="Shome">
    工作人员
    <button @click="logout">logout</button>
  </div>
</template>

<script>
export default {
    name:'SHome',
    methods: {
      logout(){
        this.$store.dispatch('Logout')
        this.$router.push('/login')
      }
    },
}
</script>

<style scoped lang='scss'>

</style>