<template>
    <a-layout-sider>
      <div class="logo text-center">
        <router-link :to="{name: 'Dashboard'}">Dashboard</router-link>
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
        <a-menu-item key="import-media">
          <router-link :to="{name: 'ImportMedia'}">
            <a-icon type="import"/>
            <span class="nav-text">Import Media</span>
          </router-link>
        </a-menu-item>
        <a-menu-item key="Message">
          <router-link :to="{name: 'Message'}">
            <a-icon type="mail"/>
            <span class="nav-text">Message</span>
          </router-link>
        </a-menu-item>

      </a-menu>
    </a-layout-sider>
</template>

<script>
  export default {
    name: "LeftMenu",
    data(){
      return{}
    }
  }
</script>

<style scoped>

</style>
