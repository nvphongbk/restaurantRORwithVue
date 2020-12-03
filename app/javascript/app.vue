<template>
  <div id="app">
    <div v-if="layout=='SignIn'">
      <router-view />
    </div>
    <div v-else>
      <a-layout id="components-layout-demo-responsive" class="h-screen">
        <a-layout-sider>
          <div class="logo text-center">
            <router-link :to="{name: 'HomePage'}">Dashboard</router-link>
          </div>
          <a-menu theme="dark" mode="inline" :default-selected-keys="['4']">
            <a-menu-item key="Restaurant">
              <router-link :to="{name: 'Restaurants'}">
                <a-icon type="reconciliation"/>
                <span class="nav-text">Restaurant</span>
              </router-link>
            </a-menu-item>
            <a-menu-item key="Category">
              <router-link :to="{name:'Categories'}">
                <a-icon type="unordered-list"/>
                <span class="nav-text">Category</span>
              </router-link>
            </a-menu-item>
            <a-menu-item key="Dish">
              <router-link :to="{name: 'Dishes'}">
                <a-icon type="inbox"/>
                <span class="nav-text">Dish</span>
              </router-link>
            </a-menu-item>
          </a-menu>
        </a-layout-sider>
        <a-layout>
          <!--header-->
          <div class="header-">
            <a-layout-header class="topbar">
              <a-input-search placeholder="input search text" enter-button/>
              <a-row class="float-right">
                <a-popover placement="bottomRight">
                  <template slot="content">
                    <div>
                      <a href="#">
                        <a-icon type="poweroff" style="color: orangered"
                                class="mr-2"/>
                        Đăng xuất</a>
                    </div>
                  </template>
                  <a-avatar style="backgroundColor:#87d068" icon="user"/>
                </a-popover>
              </a-row>
            </a-layout-header>
          </div>

          <a-layout-content class="content">
            <router-view></router-view>
          </a-layout-content>
          <!--<a-layout-footer style="textAlign: center">-->
            <!--Design by P-->
          <!--</a-layout-footer>-->
        </a-layout>
      </a-layout>
    </div>
  </div>
</template>

<script>
  import SignIn from "./src/components/Signin";

  export default {
    name: 'App',
    components: {
      SignIn
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
