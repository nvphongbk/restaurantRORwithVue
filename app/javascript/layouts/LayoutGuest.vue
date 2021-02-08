<template>
  <div id="fixContent">
    <router-view />
  </div>
</template>

<script>
  import Navigation from "./partials/Navigation"
  import Footer from "./partials/Footer"
  import HomePage from "../src/components/HomePage";
  import LoginPage from "../src/components/Signin";
  import RegistrationPage from "../src/components/Signup";
  import Menu from "../src/components/menu/Menu";
  import About from "../src/components/About";
  import Contact from "../src/components/Contact";
  export default {
    name: "LayoutGuest",
    components: {
      Contact,
      About,
      Menu,
      HomePage,
      Navigation, Footer, LoginPage, RegistrationPage
    },
  }
</script>

<style scoped>

</style>
