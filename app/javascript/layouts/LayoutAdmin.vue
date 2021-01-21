<template>
  <a-layout id="components-layout-demo-custom-trigger" style="height: 100vh">
    <LeftMenu :collapsed="collapsed"/>
    <a-layout>
      <a-layout-header style="background: #fff; padding: 0">
        <a-icon
        class="trigger"
        :type="collapsed ? 'menu-unfold' : 'menu-fold'"
        @click="toggleCollapse"
        />
        <a-row class="float-right" style="padding: 0 15px">
          <a-popover placement="bottomRight">
            <template slot="content">
              <div>
                <a href="#" @click="signout">
                  <a-icon type="poweroff" style="color: orangered"
                          class="mr-2"/>
                  Sign out</a>
              </div>
            </template>
            <a-avatar style="backgroundColor:#87d068" icon="user"/>
          </a-popover>
        </a-row>
      </a-layout-header>
      <a-layout-content class="content"
        :style="{ margin: '24px 16px', padding: '24px', background: '#fff', minHeight: '280px' }"
      >
        <router-view></router-view>
      </a-layout-content>
      <a-layout-footer :style="{ textAlign: 'center' }">
        Ment Menu ©2021 Created by Ment Company
      </a-layout-footer>
    </a-layout>
  </a-layout>
</template>

<script>
  import {ApiCaller} from "../src/utils/api";
  import {URLS} from "../src/utils/url";
  import LeftMenu from "../src/components/common/LeftMenu";
  import CompHeader from "../src/components/common/CompHeader";
  export default {
    data() {
      return {
        collapsed: false
      }
    },
    name: "LayoutAdmin",
    components: {
      CompHeader,
      LeftMenu,
    },
    methods: {
      signout() {
        localStorage.clear()
        ApiCaller().delete(URLS.SIGNOUT())
          .then((res) => {
            this.$router.push({name: 'SignIn'})
          })
          .catch(error => {
          });
      },
      toggleCollapse() {
        this.collapsed = !this.collapsed
        console.log(this.collapsed)
      }
    }
  }
</script>
<style>
  #components-layout-demo-custom-trigger .trigger {
    font-size: 18px;
    line-height: 64px;
    padding: 0 24px;
    cursor: pointer;
    transition: color 0.3s;
  }

  #components-layout-demo-custom-trigger .trigger:hover {
    color: #1890ff;
  }

  #components-layout-demo-custom-trigger .logo {
    height: 32px;
    background: rgba(255, 255, 255, 0.2);
    margin: 16px;
  }
</style>
