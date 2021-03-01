<template>
  <a-layout-content :style="{ margin: '0px 16px 0' }">
    <div :style="{ background: '#fff', minHeight: '280px' }">
      <div>
        <div class="my-5">
          <a-select style="width: 300px"
                    show-search
                    option-filter-prop="children"
                    :filter-option="filterOption"
                    placeholder="Chọn danh mục"
                    @change="handleChangeCategory"
          >
            <a-select-option v-for="category in categories" :value="category.id"
                             :key="category.id">
              {{ category.name }}
            </a-select-option>
          </a-select>
          <a-input-search
            placeholder="Tìm kiếm tên món ăn"
            style="width: 200px"
            v-model="search"
          ></a-input-search>
        </div>
        <a-button type="primary" class="editable-add-btn"
                  @click="addDish">
          Thêm
        </a-button>
        <a-button type="primary"
                  class="editable-add-btn"
                  @click="deleteDishSelect"
                  :class="{ activeSelect: isActiveSelect }">
          Xoá
        </a-button>
        <a-button type="primary"
                  class="editable-add-btn"
                  @click="showAllDish">
          Tất cả món ăn
        </a-button>
        <a-button type="dashed"
                  class="editable-add-btn"
                  @click="showModalImport">
          Import
        </a-button>

        <a-modal v-model:visible="visibleImportDish"
                 title="Import data"
                 :footer="null">
          <ImportDish
            @updateListAfterUpdated="updateListAfterUpdated"
          />
        </a-modal>
        <a-modal v-model="visible"
                 :title="titleModal"
                 :footer="null">
          <FormDish
            :visible="visible"
            :rules="rules"
            :editItem="editItem"
            :isAddNew="isAddNew"
            :isEdit="isEdit"
            @updateVisible="updateVisible"
            @updateListAfterUpdated="updateListAfterUpdated"
          />
        </a-modal>
        <a-table :row-selection="rowSelection"
                 bordered :data-source="onSearch"
                 :columns="columns"
                 :row-key="(record) => record.id"
                 :pagination="false"
        >
          <template slot="price" slot-scope="text, record">
            <div v-for="dish in text" :key="dish.id">
              {{dish.menu.name}}: {{dish.price | currency('', 0)}}
            </div>
          </template>
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
              title="Xoá món ăn này?"
              ok-text="Xoá"
              cancel-text="Không"
              @confirm="deleteDish(record)"
            >
              <a-button size="small" type="danger">
                <a-icon type="delete"/>
              </a-button>
            </a-popconfirm>
          </template>
        </a-table>
        <a-pagination size="small"
                      :total="total"
                      v-model="current_page"
                      show-size-changer
                      :pageSize="per_page"
                      :show-total="(total) => `Total ${total} items`"
                      :pageSizeOptions="pageSizeOptions"
                      @change="changePage"
                      @showSizeChange="changePageSize"/>
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
    category_ids: [],
    menu_dishes_attributes: [],
    main_ingredient_id: undefined,
    cooking_method_id: undefined,
    images_attributes: [
      {
        id: undefined,
        name: undefined,
        url: undefined
      }
    ],
    image_ids: [],
    position: undefined,
    is_active: true,
    restaurant_id: [],
  }
  export default {
    name: "Dishes",
    data() {
      return {
        isActiveSelect: false,
        selectedRowKeys: [],
        pageSizeOptions: ['20', '50', '100', '500', '1000'],
        current_page: 1,
        total: 0,
        per_page: 20,
        search: '',
        visibleImportDish: false,
        isAddNew: false,
        categories: [],
        rules: {
          name: [
            {
              required: true,
              message: 'Vui lòng nhập tên món ăn', trigger: 'blur'
            },
          ],
          category_ids: [
            {
              type: 'array',
              required: true,
              message: 'Vui lòng chọn danh mục món ăn',
              trigger: 'change',
            }
          ]
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
            title: 'Tên món ăn',
            dataIndex: 'name',
          },
          {
            title: 'Giá bán',
            dataIndex: 'menu_dishes_attributes',
            scopedSlots: {customRender: 'price'},
            width: '200px'
          },
          {
            title: 'Danh mục thực đơn',
            dataIndex: 'categories',
            scopedSlots: {customRender: 'categories'}
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
      },
      rowSelection() {
        return {
          onChange: (selectedRowKeys, selectedRows) => {
            this.selectedRowKeys = selectedRowKeys
            if (selectedRowKeys == 0) {
              this.isActiveSelect = false
            } else {
              this.isActiveSelect = true
            }
          },
        };
      },

      onSearch() {
        if (this.search) {
          return this.desserts.filter((item) => {
            return this.search.toLowerCase().split(' ').every(v => item.name.toLowerCase().includes(v))
          })
        } else {
          return this.desserts;
        }
      }
    },
    mounted() {
      this.initialize()
    },
    methods: {
      initialize() {
        return ApiCaller().get(URLS.DISHES(), {params: {page: this.current_page, per_page: this.per_page}})
          .then(response => {
            this.desserts = response.data.dishes;
            this.total = response.data.total
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
      changePage(value) {
        this.current_page = value
        this.initialize()
      },
      changePageSize(value, pageSize) {
        this.per_page = pageSize
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
      },
      async deleteDishSelect() {
        let response = await ApiCaller().delete(URLS.DESTROY_SELECT_DISH(this.selectedRowKeys))
        if (response.status == 200) {
          this.$message.success('Xoá thành công');
          this.initialize()
        } else {
          this.$message.error(response.message);
        }
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

  .activeSelect {
    background: #FF0000;
    border-color: #FF0000;
  }
</style>
