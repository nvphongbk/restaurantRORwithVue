<template>
  <div id="app">
    <div v-if="layout=='SignIn'">
      <LayoutSignIn />
    </div>
    <div v-else-if="layout=='GuestPage'">
      <LayoutGuest />
    </div>
    <div v-else>
      <LayoutAdmin />
    </div>
  </div>
</template>

<script>
  import LayoutSignIn from "./layouts/LayoutSignIn";
  import LayoutAdmin from "./layouts/LayoutAdmin";
  import LayoutGuest from "./layouts/LayoutGuest";

  export default {
    name: 'App',
    components: {
      LayoutGuest,
      LayoutAdmin,
      LayoutSignIn,
    },
    data() {
      return {};
    },
    computed: {
      layout() {
        return this.$route.meta.openKey || ""
      }
    },
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
  @media only screen and (max-width: 800px) {
    .menu-body {
      width: 100%;
    }
    .menu-dish_img{
      width: 60px;
      height: 60px;
    }
  }
</style>
