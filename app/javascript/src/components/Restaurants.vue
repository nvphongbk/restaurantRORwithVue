<template>
  <a-layout-content :style="{ margin: '24px 16px 0' }">
    <div :style="{ padding: '24px', background: '#fff', minHeight: '360px' }">
      <div>
        <a-button type="primary" class="editable-add-btn"
                  @click="addRestaurant">
          Add
        </a-button>
        <a-modal v-model="visible" :title="titleModal" :footer="null">
          <FormRestaurant
            :rules="rules"
            :editItem="editItem"
            :isEdit="isEdit"
            @updateVisible="updateVisible"
            @updateListAfterUpdated="updateListAfterUpdated"
          />
        </a-modal>
        <a-table bordered :data-source="desserts" :columns="columns"
                 :row-key="(record) => record.id"
        >
          <template slot="action" slot-scope="text, record">
            <a-button @click="editRestaurant(record)" :size="'small'"
                      :type="'primary'"
            >
              <a-icon type="edit"/>
            </a-button>
            <a-popconfirm
              title="Delete this Category?"
              ok-text="Delete"
              cancel-text="Cancel"
              @confirm="deleteRestaurant(record)"
            >
              <a-button size="small" type="danger">
                <a-icon type="delete"/>
              </a-button>
            </a-popconfirm>
          </template>
        </a-table>
      </div>
    </div>
  </a-layout-content>
</template>

<script>
  import axios from "axios";
  import FormRestaurant from "./forms/FormRestaurant"
  import {URLS} from "../utils/url"
  const newRestaurant = {
    id: '',
    name: '',
    address:'',
  }
  export default {
    name: "Restaurants",
    data() {
      return {
        rules: {
          name: [
            { required: true,
              message: 'Please input name', trigger: 'blur' },
            { min: 3,
              message: 'Length should be 3',
              trigger: 'blur' },
          ],
          address: [
            {
              required: true,
              message: 'Please input address',
              trigger: 'blur'
            },
            {
              min: 3,
              message: 'Length should be 3',
              trigger: 'blur'
            },
          ],
        },
        editItem: {
        },
        isEdit: false,
        desserts: [],
        visible: false,
        columns: [
          {
            title: 'Name',
            dataIndex: 'name',
          },
          {
            title: 'Date Create',
            dataIndex: 'created_at',
          },
          {
            title: 'Address',
            dataIndex: 'address',
          },
          {
            title: 'Action',
            dataIndex: 'action',
            scopedSlots: {customRender: 'action'},
          },
        ],
      };
    },
    components:{
      FormRestaurant
    },
    mounted() {
      this.initialize()
    },
    computed: {
      titleModal() {
        return this.isEdit ? 'Edit Category' : 'Create Category'
      }
    },
    methods: {
      initialize() {
        return axios
          .get(URLS.RESTAURANTS())
          .then(response => {
            console.log(response.data);
            this.desserts = response.data;
          })
          .catch(e => {
            console.log(e);
          });
      },
      addRestaurant(){
        this.visible = true;
        this.isEdit = false
        this.editItem = Object.assign({}, newRestaurant);
      },
      editRestaurant(record) {
        this.isEdit = true;
        this.visible = true;
        this.editItem = Object.assign({}, record);
      },
      updateVisible(value) {
        this.visible = value;
      },
      updateListAfterUpdated() {
        this.initialize()
      },
      deleteRestaurant(item) {
        axios
          .delete(URLS.RESTAURANT(item.id))
          .then((res) => {
            console.log(res)
            this.$message.success('Deleted success');
            this.initialize()
          })
          .catch(error => {
            console.log(error);
          });
      },
    }
  }
</script>

<style scoped>
  .img-dashboard {
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
