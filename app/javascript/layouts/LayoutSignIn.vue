<template>
  <router-view />
</template>

<script>
  import SignIn from "../src/components/Signin";
  import Signup from "../src/components/Signup"
  export default {
    name: "LayoutSignIn",
    components: {SignIn, Signup}
  }
</script>

<style scoped>

</style>
