<template>
  <a-layout-sider v-model="collapsed" :trigger="null" collapsible>
    <div class="logo text-center">
      <router-link :to="{name: 'Dashboard'}">
        Dashboard
      </router-link>
    </div>
    <a-menu theme="dark" mode="inline" :default-selected-keys="['1']">
      <a-menu-item key="Restaurant">
        <router-link :to="{name: 'Restaurants'}">
          <a-icon type="reconciliation"/>
          <span class="nav-text">Danh sách nhà hàng</span>
        </router-link>
      </a-menu-item>
      <a-menu-item key="MainIngredient">
        <router-link :to="{name: 'MainIngredients'}">
          <a-icon type="reconciliation"/>
          <span class="nav-text">Thành phần chính</span>
        </router-link>
      </a-menu-item>
      <a-menu-item key="CookingMethod">
        <router-link :to="{name: 'CookingMethods'}">
          <a-icon type="reconciliation"/>
          <span class="nav-text">Cách chế biến</span>
        </router-link>
      </a-menu-item>
      <a-menu-item key="Category">
        <router-link :to="{name:'Categories'}">
          <a-icon type="unordered-list"/>
          <span class="nav-text">Danh mục thực đơn</span>
        </router-link>
      </a-menu-item>
      <a-menu-item key="Dish">
        <router-link :to="{name: 'Dishes'}">
          <a-icon type="inbox"/>
          <span class="nav-text">Món ăn</span>
        </router-link>
      </a-menu-item>
      <a-menu-item key="import-media">
        <router-link :to="{name: 'ImportMedia'}">
          <a-icon type="import"/>
          <span class="nav-text">Thêm ảnh hàng loạt</span>
        </router-link>
      </a-menu-item>
      <a-menu-item key="Message">
        <router-link :to="{name: 'Message'}">
          <a-icon type="mail"/>
          <span class="nav-text">Tin nhắn</span>
        </router-link>
      </a-menu-item>
    </a-menu>
  </a-layout-sider>
</template>

<script>
  export default {
    name: "LeftMenu",
    props: {
      collapsed: {
        type: Boolean
      }
    }
  }
</script>

<style scoped>

</style>
