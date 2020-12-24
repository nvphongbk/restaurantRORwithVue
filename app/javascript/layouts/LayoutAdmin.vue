<template>
  <a-layout id="components-layout-demo-responsive" class="h-screen">
    <LeftMenu/>
    <a-layout>
      <CompHeader
        @signout="signout"
      />
      <a-layout-content class="content">
        <router-view></router-view>
      </a-layout-content>
    </a-layout>
  </a-layout>
</template>

<script>
  import axios from "axios";
  import {URLS} from "../src/utils/url";
  import LeftMenu from "../src/components/common/LeftMenu";
  import CompHeader from "../src/components/common/CompHeader";
  export default {
    name: "LayoutAdmin",
    components: {
      CompHeader,
      LeftMenu,
    },
    methods: {
      signout() {
        localStorage.clear()
        axios
          .delete(URLS.SIGNOUT())
          .then((res) => {
            this.$router.push({name: 'SignIn'})
          })
          .catch(error => {
          });
      },
    }
  }
</script>

<style scoped>

</style>
