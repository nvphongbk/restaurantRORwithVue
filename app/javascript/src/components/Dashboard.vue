<template>
  <a-layout id="components-layout-demo-responsive" class="h-screen">
    <a-layout-sider
      breakpoint="lg"
      collapsed-width="0"
      @collapse="onCollapse"
      @breakpoint="onBreakpoint"
    >
      <div class="img-dashboard" />
      <a-menu theme="dark" mode="inline" :default-selected-keys="['4']">
        <a-menu-item key="1">
          <a-icon type="user" />
          <span class="nav-text">Restaurant</span>
        </a-menu-item>
        <a-menu-item key="2">
          <a-icon type="video-camera" />
          <span class="nav-text">Category</span>
        </a-menu-item>
        <a-menu-item key="3">
          <a-icon type="upload" />
          <span class="nav-text">Dish</span>
        </a-menu-item>
      </a-menu>
    </a-layout-sider>
    <a-layout>
      <div class="w-full mt-2">
        <a-input-search placeholder="input search text" enter-button  />
        <a-avatar :size="64" icon="user" class="w-2/12" />
      </div>

      <a-layout-content :style="{ margin: '24px 16px 0' }">
        <div :style="{ padding: '24px', background: '#fff', minHeight: '360px' }">
          <!--data restaurant-->
          <div>
            <a-button class="editable-add-btn" >
              Add
            </a-button>
            <a-table bordered :data-source="dataSource" :columns="columns">
              <template slot="name" slot-scope="text, record">
              </template>
              <template slot="operation" slot-scope="text, record">
                <a-popconfirm
                  v-if="dataSource.length"
                  title="Sure to delete?"
                  @confirm="() => onDelete(record.key)"
                >
                  <a class="dashboard-action m-3 hover:text-blue-700" href="#">Edit</a>
                  <a class="dashboard-action m-3 hover:text-blue-700" href="#">Delete</a>
                </a-popconfirm>
              </template>
            </a-table>
          </div>
        </div>
      </a-layout-content>
      <a-layout-footer style="textAlign: center">
        Design by P
      </a-layout-footer>
    </a-layout>
  </a-layout>
</template>

<script>

  export default {
    components: {
    },
    data() {
      return {
        dataSource: [
          {
            key: '0',
            name: 'Edward King 0',
            age: '12',
            address: 'London, Park Lane no. 0',
          },
          {
            key: '1',
            name: 'Edward King 1',
            age: '32',
            address: 'London, Park Lane no. 1',
          },
          {
            key: '2',
            name: 'Edward King 3',
            age: '12',
            address: 'London, Park Lane no. 2',
          },
        ],
        count: 2,
        columns: [
          {
            title: 'Name',
            dataIndex: 'name',

          },
          {
            title: 'Date Create',
            dataIndex: 'age',
          },
          {
            title: 'address',
            dataIndex: 'address',
          },
          {
            title: 'Action',
            dataIndex: 'operation',
            scopedSlots: { customRender: 'operation' },
          },
        ],
      };
    },
    methods: {
      onCollapse(collapsed, type) {
        console.log(collapsed, type);
      },
      onBreakpoint(broken) {
        console.log(broken);
      },

      onDelete(key) {
        const dataSource = [...this.dataSource];
        this.dataSource = dataSource.filter(item => item.key !== key);
      },
    }
  }
</script>
<style>
  .img-dashboard{
    height: 32px;
  }
  #components-layout-demo-responsive .logo {
    height: 32px;
    background: rgba(255, 255, 255, 0.2);
    margin: 16px;
  }
  .ant-input-search {
    margin-top: 20px;
    margin-left: 15px;
  }
  .ant-input-group-wrapper{
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
