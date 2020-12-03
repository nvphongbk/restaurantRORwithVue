<template>
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
</template>

<script>
  export default {
    name: "CompHeader",
    data(){
      return{}
    }
  }
</script>

<style scoped>

</style>
