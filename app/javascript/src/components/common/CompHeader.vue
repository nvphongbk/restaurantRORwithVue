<template>
  <div class="header-">
    <a-layout-header class="topbar">
      <a-row class="float-right">
        <a-popover placement="bottomRight">
          <template slot="content">
            <div>
              <a href="#" @click="logout">
                <a-icon type="poweroff" style="color: orangered"
                        class="mr-2"/>
                Sign out</a>
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
    },
    methods: {
      logout() {
        this.$emit('signout')
      },
    },
  }
</script>

<style scoped>

</style>
