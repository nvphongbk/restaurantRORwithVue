<template>
  <a-layout-content :style="{ margin: '0px 16px 0' }">
    <div :style="{ background: '#fff', minHeight: '280px' }">
      <div>
        <div class="my-5">
          <a-select style="width: 300px"
                    show-search
                    option-filter-prop="children"
                    :filter-option="filterOption"
                    placeholder="Select a Restaurant"
                    @change="handleChangeRestaurant"
          >
            <a-select-option v-for="restaurant in restaurants"
                             :value="restaurant.id" :key="restaurant.id">
              {{ restaurant.name }}
            </a-select-option>
          </a-select>

          <a-select style="width: 300px"
                    show-search
                    option-filter-prop="children"
                    :filter-option="filterOption"
                    placeholder="Select a Category"
                    @change="handleChangeCategory"
          >
            <a-select-option v-for="category in categories" :value="category.id"
                             :key="category.id">
              {{ category.name }}
            </a-select-option>
          </a-select>
        </div>
        <a-button type="primary" class="editable-add-btn"
                  @click="addDish">
          Add
        </a-button>
        <a-button type="primary" class="editable-add-btn"
                  @click="showAllDish">
          All dish
        </a-button>
        <a-button type="dashed" class="editable-add-btn"
                  @click="showModalImport">
          Import
        </a-button>

        <a-modal v-model:visible="visibleImportDish" title="Import data"
                 :footer="null">
          <ImportDish
            @updateListAfterUpdated="updateListAfterUpdated"
            :restaurants="restaurants"
          />
        </a-modal>
        <a-modal v-model="visible" :title="titleModal" :footer="null">
          <FormDish
            :visible="visible"
            :rules="rules"
            :editItem="editItem"
            :isAddNew="isAddNew"
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
          <template slot="categories" slot-scope="text, record">
            <div v-for="desert in text" :key="desert.id">
              {{ desert.name }}
            </div>
          </template>
          <template slot="isActive" slot-scope="text, record">
            <a-switch size="small" v-model="record.is_active" @change="changeIsActive(record)"/>
          </template>
          <template slot="image" slot-scope="image">
            <span>
              <a-avatar shape="square" :size="50" :src="image"/>
            </span>
          </template>
          <template slot="action" slot-scope="text, record">
            <a-button @click="editDish(record)" :size="'small'"
                      :type="'primary'"
            >
              <a-icon type="edit"/>
            </a-button>
            <a-popconfirm
              title="Delete this Category?"
              ok-text="Delete"
              cancel-text="Cancel"
              @confirm="deleteDish(record)"
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
  import {URLS} from "../utils/url"
  import FormDish from "./forms/FormDish"
  import ImportDish from "./ImportDish"

  const newDish = {
    id: '',
    name: '',
    price: '',
    category_ids: [],
    main_ingredient_id: undefined,
    cooking_method_id: undefined,
    images_attributes: [],
    image_ids: [],
    position: undefined,
    is_active: true,
  }
  export default {
    name: "Dishes",
    data() {
      return {
        visibleImportDish: false,
        isAddNew: false,
        categories: [],
        restaurants: [],
        rules: {
          name: [
            {
              required: true,
              message: 'Please input name', trigger: 'blur'
            },
            {
              min: 3,
              message: 'Length should be 3',
              trigger: 'blur'
            },
          ],
          restaurant: [{
            required: false,
            message: 'Please select Restaurant',
            trigger: 'change'
          }],

        },
        editItem: {},
        isEdit: false,
        desserts: [],
        visible: false,
        columns: [
          {
            title: 'Ảnh món ăn',
            dataIndex: 'images_attributes[0].url',
            scopedSlots: {customRender: "image"},
          },
          {
            title: 'Danh mục thực đơn',
            dataIndex: 'categories',
            scopedSlots: { customRender: 'categories' }
          },
          {
            title: 'Tên món ăn',
            dataIndex: 'name',
          },
          {
            title: 'Giá bán',
            dataIndex: 'price',
          },
          {
            title: 'Thành phần chính',
            dataIndex: 'main_ingredient.name',
          },
          {
            title: 'Cách chế biến',
            dataIndex: 'cooking_method.name',
          },
          {
            title: 'Sắp xếp',
            dataIndex: 'position',
          },
          {
            title: 'Kích hoạt',
            dataIndex: 'is_active',
            scopedSlots: {customRender: "isActive"},
          },
          {
            title: '',
            dataIndex: 'action',
            scopedSlots: {customRender: 'action'},
          },
        ],
      };
    },
    components: {
      FormDish, ImportDish
    },
    watch: {},
    computed: {
      titleModal() {
        return this.isEdit ? 'Edit Dish' : 'Create Dish'
      }
    },
    mounted() {
      this.initialize()
      this.getDataRestaurant()
    },
    methods: {
      initialize() {
        return ApiCaller().get(URLS.DISHES())
          .then(response => {
            this.desserts = response.data;
            console.log(this.desserts)
          })
          .catch(e => {
          });
      },
      addDish() {
        this.visible = true;
        this.isEdit = false
        this.isAddNew = true
        this.editItem = Object.assign({}, newDish);
      },
      showModalImport() {
        this.visibleImportDish = true
      },
      editDish(record) {
        this.isEdit = true;
        this.visible = true;
        this.isAddNew = false
        this.editItem = Object.assign({}, record);
      },
      updateVisible(value) {
        this.visible = value;
      },
      deleteDish(item) {
          ApiCaller().delete(URLS.DISH(item.id))
          .then((res) => {
            this.$message.success('Deleted success');
            this.initialize()
          })
          .catch(error => {
          });
      },
      updateListAfterUpdated() {
        this.initialize()
      },
      getDataRestaurant() {
        return ApiCaller().get(URLS.RESTAURANTS())
          .then(response => {
            this.restaurants = response.data;
          })
          .catch(e => {
          });
      },
      getDataCategory(value) {
        return ApiCaller().get(URLS.RESTAURANT_SEARCH(value))
          .then(response => {
            this.categories = response.data;
          })
          .catch(e => {
          });
      },
      searchDish(value) {
        return ApiCaller().get(URLS.CATEGORY_SEARCH(value))
          .then(response => {
            this.desserts = response.data;
          })
          .catch(e => {
          });
      },
      filterOption(input, option) {
        return (
          option.componentOptions.children[0].text.toLowerCase().indexOf(input.toLowerCase()) >= 0
        );
      },
      handleChangeRestaurant(value) {
        this.getDataCategory(value)
      },
      handleChangeCategory(value) {
        this.searchDish(value)
      },
      showAllDish() {
        this.initialize()
      },
      async changeIsActive(item) {
        let response = await ApiCaller().post(URLS.DISH_CHANGE_ACTIVE(item.id), {
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
