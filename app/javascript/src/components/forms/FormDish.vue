<template>
  <div>
    <a-form-model
      :rules="rules"
      ref="ruleForm"
      :model="editItem"
      :label-col="{ span: 8 }"
      :wrapper-col="{ span: 16 }">
      <a-form-model-item ref="name" label="Tên món ăn" prop="name">
        <a-input placeholder="Vui lòng nhập tên món ăn"
                 v-model="editItem.name"/>
      </a-form-model-item>
      <a-form-model-item ref="dish_code" label="Mã món ăn" prop="dish_code">
        <a-input placeholder="Vui lòng nhập Mã món ăn"
                 v-model="editItem.dish_code"/>
      </a-form-model-item>
      <a-form-model-item label="Kích hoạt" prop="isActive">
        <a-switch v-model="editItem.is_active"/>
      </a-form-model-item>
      <a-form-model-item label="Vị trí" prop="position">
        <a-input placeholder="Vị trí xuất hiện"
                 v-model="editItem.position"/>
      </a-form-model-item>
      <a-form-model-item label="Danh mục thực đơn" prop="category_ids">
        <a-checkbox-group v-model="editItem.category_ids" @change="onChange">
          <a-checkbox :span="6" v-for="category in categories" :key="category.id"
                      name="category_ids[]" :value="category.id">
            {{ category.name }}
          </a-checkbox>
        </a-checkbox-group>
      </a-form-model-item>
      <div class="ant-form-item-control">
        <table width="100%">
          <thead class="ant-table-thead">
          <tr>
            <th width="50%">
              Chọn Menu
            </th>
            <th width="50%">
              Giá món ăn
            </th>
            <th></th>
          </tr>
          </thead>
          <tbody class="ant-table-tbody">
          <tr class="ant-table-row" v-for="(menu_dish, index) in editItem.menu_dishes_attributes"
              :key="menu_dish.menu_id">
            <td class="small">
              <a-select
                show-search
                placeholder="Chọn menu"
                option-filter-prop="children"
                style="width: 200px"
                :filter-option="filterOption"
                v-model="menu_dish.menu_id"
                @focus="filterMenus"
              >
                <a-select-option v-for="menu in result" :key="menu.id">
                  {{ menu.name }}
                </a-select-option>
              </a-select>
            </td>
            <td class="small">
              <a-input v-model="menu_dish.price" :value="menu_dish.price" suffix="VNĐ"/>
            </td>
            <td class="small">
              <a-popconfirm
                title="Bạn muốn xoá menu này?"
                ok-text="Xác nhận"
                cancel-text="Huỷ"
                @confirm="deleteMenuDish(menu_dish)"
              >
                <a-button :size="'small'" type="danger">
                  <a-icon type="delete"/>
                </a-button>
              </a-popconfirm>
            </td>
          </tr>
          </tbody>
          <tfoot class="center">
          <tr>
            <td colspan="3">
              <a-button @click="addMenuDish">
                <a-icon type="plus"/>
              </a-button>
            </td>
          </tr>
          </tfoot>
        </table>
      </div>
      <div class="clearfix mt-5">
        <UploadImage
          ref="refUploadImage"
          :editImages="editItem.images_attributes"
          @updateImageList="updateImageList"
        />
      </div>

      <a-form-model-item :wrapperCol="{ offset: 8 }">
        <a-button @click="handleSubmit" type="primary" html-type="submit">
          {{ getTitle }}
        </a-button>
        <a-button style="margin-left: 10px;" @click="resetForm">
          Reset
        </a-button>
      </a-form-model-item>
    </a-form-model>
  </div>
</template>
<script>
  import {ApiCaller} from "../../utils/api";
  import {URLS} from "../../utils/url"
  import UploadImage from "../UploadImage"
  import AFormModelItem from "ant-design-vue/es/form-model/FormItem"
  import {mapGetters, mapActions} from 'vuex'

  const newMenuDish = {
    id: '',
    menu: {
      id: undefined,
      name: ''
    },
    price: '',
    dish_id: '',
    menu_id: ''
  }

  export default {
    name: "FormDish",
    props: {
      rules: {
        type: Object
      },
      isEdit: {
        type: Boolean,
        default: false
      },
      isAddNew: {
        type: Boolean,
        default: false
      },
      visible: {
        type: Boolean,
        default: false
      },
      editItem: {
        type: Object
      },
    },
    data() {
      return {
        ingredients: [],
        cooking_methods: [],
        previewVisible: false,
        menus: [],
        result: [],
      };
    },
    components: {AFormModelItem, UploadImage},
    computed: {
      ...mapGetters([
        'categories'
      ]),
      getTitle() {
        return this.isEdit ? "Cập nhật" : "Thêm"
      }
    },
    mounted() {
      this.fetchData()
      this.fetchMenu()
    },
    watch: {
      visible: {
        handler: function () {
          if (this.isAddNew) {
            this.$refs.refUploadImage.initializeImages()
          }
        }
      }
    },
    methods: {
      ...mapActions([
        'getRestaurantInfo'
      ]),
      filterMenus() {
        const select_ids = this.editItem.menu_dishes_attributes.map(e => e.menu_id)
        let lastMenus = []
        this.menus.forEach(menu => {
          if (select_ids.findIndex(object => object === menu.id) === -1) {
            lastMenus.push(menu)
          }
        })
        this.result = lastMenus
      },
      fetchData() {
        this.callDataRestaurant()
      },
      create(item) {
        this.isEdit = false
        ApiCaller().post(URLS.DISHES(), {
          dish: item
        })
          .then(response => {
            this.$message.success('Tạo món ăn thành công');
            this.$emit('updateListAfterUpdated', this.editItem);
          })
          .catch(error => {
          });
      },
      handleSubmit(e) {
        this.$refs.ruleForm.validate((valid) => {
          if (valid) {
            let valuesSave = Object.assign({}, this.editItem)
            if (this.isEdit) {
              let idItem = this.editItem.id
              ApiCaller().put(URLS.DISH(idItem), {
                dish: valuesSave
              })
                .then(response => {
                  this.$message.success('Cập nhật thành công')
                  this.$emit('updateListAfterUpdated');
                })
                .catch(error => {
                });
            } else {
              this.create(valuesSave)
            }
            this.clearMenuDishes()
            this.fetchMenu()
            this.$emit('updateVisible', false);
          } else {
            return false;
          }
        });
      },
      resetForm() {
        this.$refs.ruleForm.resetFields();
      },
      callDataRestaurant() {
        this.$emit('getDataRestaurant')
      },
      filterOption(input, option) {
        return (
          option.componentOptions.children[0].text.toLowerCase().indexOf(input.toLowerCase()) >= 0
        );
      },
      onChange(checkedValues) {
      },
      updateImageList(list) {
        this.editItem.images_ids = list
      },
      fetchMenu() {
        return ApiCaller().get(URLS.MENUS())
          .then(response => {
            this.menus = response.data
            this.result = response.data
          })
          .catch(e => {
          });
      },
      addMenuDish() {
        this.editItem.menu_dishes_attributes.push({...newMenuDish})
      },
      async deleteMenuDish(menu) {
        let response = await ApiCaller().delete(URLS.MENU(menu.id))
        if (response.status == 200) {
          this.$message.success('Xoá thành công');
        } else {
          this.$message.error(response.message);
        }
        const index = this.editItem.menu_dishes_attributes.findIndex(obj => obj === menu)
        this.editItem.menu_dishes_attributes.splice(index, 1)
      },
      clearMenuDishes() {
        this.editItem.menu_dishes_attributes.splice(0)
      }
    },
  };
</script>
