<template>
  <a-layout-content :style="{ margin: '0px 16px 0' }">
    <div :style="{ background: '#fff', minHeight: '360px' }">
      <div>
        <FilterRestaurant
          @searchCategory="searchCategory"
          :restaurants="restaurants"
          :editItem="editItem"
        />
        <a-button type="primary" class="editable-add-btn"
                  @click="addCategory">
          Thêm danh mục
        </a-button>
        <a-button type="primary" class="editable-add-btn"
                              @click="showAllCategories">
        Tất cả danh mục
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
          <template slot="isActive" slot-scope="text, record">
            <a-switch size="small" v-model="record.is_active" @change="changeIsActive(record)"/>
          </template>
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
  import {ApiCaller} from "../utils/api";
  import FormCategory from "./forms/FormCategory"
  import FilterRestaurant from  "./filters/FilterRestaurant"
  import {URLS} from "../utils/url";

  const newCategory = {
    id: '',
    name: '',
    restaurant_id: undefined,
    position: undefined,
    is_active: true
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
            { min: 1,
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
            title: 'Tên',
            dataIndex: 'name',
          },
          {
            title: 'Sắp xếp',
            dataIndex: 'position',
          },
          {
            title: 'Kích hoạt',
            dataIndex: 'is_active',
            scopedSlots: {customRender: "isActive"}
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
        return ApiCaller().get(URLS.CATEGORIES())
          .then(response => {
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
          ApiCaller().delete(URLS.CATEGORY(item.id))
          .then((res) => {
            this.$message.success('Deleted success')
            this.initialize()
          })
          .catch(error => {
            console.log(error);
          });
      },
      updateListAfterUpdated() {
        this.initialize()
      },
      searchCategory(value){
          return ApiCaller().get(URLS.RESTAURANT_SEARCH(value))
            .then(response => {
                this.desserts = response.data;
            })
            .catch(e => {
              console.log(e);
            });
      },
      getDataRestaurant(){
        return ApiCaller().get(URLS.RESTAURANTS())
          .then(response => {
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
      async changeIsActive(item) {
        let response = await ApiCaller().post(URLS.CATEGORY_CHANGE_ACTIVE(item.id), {
          id: item.id,
          is_active: item.is_active
        })
        if (response.status === 200) {
          this.$message.success("Cập nhật thành công");
        } else {
          this.$message.error(response.message);
        }
      }
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
