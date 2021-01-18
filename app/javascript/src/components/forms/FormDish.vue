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
      <a-form-model-item ref="price" label="Giá bán" prop="price">
        <a-input placeholder="Nhập giá bán"
                 v-model="editItem.price"/>
      </a-form-model-item>
      <a-form-model-item label="Kích hoạt" prop="isActive">
        <a-switch v-model="editItem.is_active" />
      </a-form-model-item>
      <a-form-model-item label="Vị trí" prop="position">
        <a-input placeholder="Vị trí xuất hiện"
                 v-model="editItem.position"/>
      </a-form-model-item>
      <a-form-model-item label="Category">
        <a-checkbox-group v-model="editItem.category_ids" @change="onChange">
          <a-checkbox :span="6" v-for="category in categories" :key="category.id"
                      name="category_ids[]" :value="category.id">
            {{ category.name }}
          </a-checkbox>
        </a-checkbox-group>
      </a-form-model-item>
      <div class="clearfix">
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
  export default {
    name: "FormDish",
    props: {
      restaurants: {
        type: Array
      },
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
        categories: [],
        previewVisible: false,

      };
    },
    components: {UploadImage},
    computed: {
      getTitle() {
        return this.isEdit ? "Cập nhật" : "Thêm"
      }
    },
    mounted() {
      this.callDataRestaurant()
      this.getDataCategory()
    },
    watch: {
      visible: {
        handler: function () {
          if(this.isAddNew) {
            this.$refs.refUploadImage.initializeImages()
          }
        }
      }
    },
    methods: {
      create(item) {
        this.isEdit = false
        ApiCaller().post(URLS.DISHES(), {
            dish: item
          })
          .then(response => {
            this.$message.success('Cập nhật thành công');
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
                  this.$message.success('Updated success')
                  this.$emit('updateListAfterUpdated', this.editItem);
                })
                .catch(error => {
                });
            } else {
              this.create(valuesSave)
            }
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
      getDataCategory() {
        return ApiCaller().get(URLS.CATEGORIES())
          .then(response => {
            this.categories = response.data;
          })
          .catch(e => {
          });
      },
      onChange(checkedValues) {
      },
      updateImageList(list) {
        this.editItem.images_ids = list
      }
    },
  };
</script>
