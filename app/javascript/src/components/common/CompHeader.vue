<template>
  <div class="header-">
  </div>
</template>

<script>
  export default {
    name: "CompHeader",
    data(){
      return{}
    },
    methods: {
      logout() {
        this.$emit('signout')
      },
    },
  }
</script>

<style scoped>

</style>
