<template>
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
