<template>
  <div id="app">
    <div v-if="layout=='SignIn'">
      <router-view/>
    </div>
    <div v-else-if="layout=='HomePage'">
      <router-view/>
    </div>
    <div v-else-if="layout=='About'">
      <router-view/>
    </div>
    <div v-else-if="layout=='Menu'">
      <router-view/>
    </div>
    <div v-else-if="layout=='Contact'">
      <router-view/>
    </div>
    <div v-else>
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
    </div>
  </div>
</template>

<script>
  import SignIn from "./src/components/Signin";
  import LeftMenu from "./src/components/common/LeftMenu"
  import CompHeader from "./src/components/common/CompHeader"
  import HomePage from "./src/components/HomePage"
  import Menu from "./src/components/Menu"
  import axios from "axios"
  import {URLS} from "./src/utils/url";

  export default {
    name: 'App',
    components: {
      HomePage,
      SignIn,
      LeftMenu,
      CompHeader,
      Menu
    },
    data() {
      return {};
    },
    computed: {
      layout() {
        return this.$route.meta.openKey || ""
      }
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
  #components-layout-demo-responsive .logo {
    height: 32px;
    background: rgba(255, 255, 255, 0.2);
    margin: 16px;
  }

  .ant-input-group-wrapper {
    width: 90% !important;
  }

  .editable-cell {
    position: relative;
  }

  .editable-cell-input-wrapper,
  .editable-cell-text-wrapper {
    padding-right: 24px;
  }

  .editable-cell-text-wrapper {
    padding: 5px 24px 5px 5px;
  }

  .editable-cell-icon,
  .editable-cell-icon-check {
    position: absolute;
    right: 0;
    width: 20px;
    cursor: pointer;
  }

  .editable-cell-icon {
    line-height: 18px;
    display: none;
  }

  .editable-cell-icon-check {
    line-height: 28px;
  }

  .editable-cell:hover .editable-cell-icon {
    display: inline-block;
  }

  .editable-cell-icon:hover,
  .editable-cell-icon-check:hover {
    color: #108ee9;
  }

  .editable-add-btn {
    margin-bottom: 8px;
  }

  .ant-table-thead tr th {
    text-align: center !important;
  }
</style>
