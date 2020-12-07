<template>
  <a-layout-content :style="{ margin: '24px 16px 0' }">
    <div :style="{ padding: '24px', background: '#fff', minHeight: '360px' }">
      <div>
        <FilterRestaurant
          @searchCategory="searchCategory"
          :restaurants="restaurants"
          :editItem="editItem"
        />
        <a-button type="primary" class="editable-add-btn"
                  @click="addCategory">
          Add
        </a-button>
        <a-button type="primary" class="editable-add-btn"
                              @click="showAllCategories">
        All Category
      </a-button>
        <a-modal v-model="visible" :title="titleModal" :footer="null">
          <FormCategory
            :restaurants="restaurants"
            :rules="rules"
            :editItem="editItem"
            :isEdit="isEdit"
            @updateVisible="updateVisible"
            @updateListAfterUpdated="updateListAfterUpdated"
            @getDataRestaurant="getDataRestaurant"
          />
        </a-modal>
        <a-table bordered :data-source="desserts"
                 :columns="columns"
                 :row-key="(record) => record.id"
        >
          <template slot="action" slot-scope="text, record">
            <a-button @click="editCategory(record)" :size="'small'"
                      :type="'primary'"
            >
              <a-icon type="edit"/>
            </a-button>
            <a-popconfirm
              title="Delete this Category?"
              ok-text="Delete"
              cancel-text="Cancel"
              @confirm="deleteCategory(record)"
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
  import FormCategory from "./forms/FormCategory"
  import FilterRestaurant from  "./filters/FilterRestaurant"
  const newCategory = {
    id: '',
    name: '',
    restaurant_id:undefined,
  }
  export default {
    name: "Categories",
    data() {
      return {
        value:undefined,
        restaurants: [],
        rules: {
          name: [
            { required: true,
              message: 'Please input name', trigger: 'blur' },
            { min: 3,
              message: 'Length should be 3',
              trigger: 'blur' },
          ],
          restaurant: [{ required: false, message: 'Please select Restaurant', trigger: 'change' }],

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
            title: 'Action',
            dataIndex: 'action',
            scopedSlots: {customRender: 'action'},
          },
        ],
      };
    },
    components:{
      FilterRestaurant,
      FormCategory,
    },
    computed: {
      titleModal() {
        return this.isEdit ? 'Edit Category' : 'Create Category'
      }
    },
    mounted() {
      this.initialize()
      this.getDataRestaurant()
    },
    methods: {
      initialize() {
        return axios
          .get("http://localhost:3000/api/v1/categories/")
          .then(response => {
            console.log(response.data);
            this.desserts = response.data;
          })
          .catch(e => {
            console.log(e);
          });
      },
      addCategory(){
        this.visible = true;
        this.isEdit = false
        this.editItem = Object.assign({}, newCategory);
      },
      editCategory(record) {
        this.isEdit = true;
        this.visible = true;
        this.editItem = Object.assign({}, record);
      },
      updateVisible(value) {
        this.visible = value;
      },
      deleteCategory(item) {
        axios
          .delete(`http://localhost:3000/api/v1/categories/${item.id}`)
          .then((res) => {
            console.log(res);
            this.$message.success('Deleted success');
            this.searchCategory(this.editItem.restaurant_id)
          })
          .catch(error => {
            console.log(error);
          });
      },
      updateListAfterUpdated() {
        this.searchCategory(this.editItem.restaurant_id)
      },
      searchCategory(value){
          return axios
            .get(`http://localhost:3000/api/v1/restaurants/${value}/categories`)
            .then(response => {
              console.log(response.data);
                this.desserts = response.data;
            })
            .catch(e => {
              console.log(e);
            });
      },
      getDataRestaurant(){
        return axios
          .get("http://localhost:3000/api/v1/restaurants/")
          .then(response => {
            console.log(response.data);
            this.restaurants = response.data;
          })
          .catch(e => {
            console.log(e);
          });
      },
      showAllCategories() {
        this.initialize()
        this.editItem = Object.assign({}, newCategory);
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
