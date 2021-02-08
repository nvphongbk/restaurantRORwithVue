<template>
  <a-form-model
    :rules="rules"
    ref="ruleForm"
    :model="editItem"
    :label-col="{ span: 8 }"
    :wrapper-col="{ span: 16 }">
    <a-form-model-item  label="Restaurant" prop="restaurants">
      <a-select show-search :autoFocus="true"
                option-filter-prop="children"
                :filter-option="filterOption"
                v-model="editItem.restaurant_id" placeholder="Chọn nhà hàng">
        <a-select-option v-for="restaurant in restaurants" :key="restaurant.id">
          {{ restaurant.name }}
        </a-select-option>
      </a-select>
    </a-form-model-item>
    <a-form-model-item ref="name" label="Tên danh mục" prop="name">
      <a-input placeholder="Vui lòng nhập tên danh mục"
        v-model="editItem.name" />
    </a-form-model-item>
    <a-form-model-item label="Hiển thị trang chủ" prop="display_home">
      <a-switch v-model="editItem.display_home" @change="changeDisplayHome(editItem)" />
    </a-form-model-item>
    <a-form-model-item label="Vị trí xuất hiện" prop="position">
      <a-input placeholder="Có thể bỏ qua nếu không cần ưu tiên"
        v-model="editItem.position" />
    </a-form-model-item>
    <a-form-model-item label="Kích hoạt" prop="is_active">
      <a-switch v-model="editItem.is_active" />
    </a-form-model-item>
    <a-form-model-item :wrapperCol="{ offset: 8 }">
      <a-button @click="handleSubmit" type="primary" html-type="submit">
        {{ getTitle }}
      </a-button>
    </a-form-model-item>
  </a-form-model>
</template>
<script>
  import {ApiCaller} from "../../utils/api";
  import {URLS} from "../../utils/url";

  export default {
    name: "FormCategory",
    props: {
      restaurants:{
        type: Array
      },
      rules:{
        type: Object
      },
      isEdit: {
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
      };
    },
    mounted(){
      this.callDataRestaurant()
    },
    computed: {
      getTitle() {
        return this.isEdit ? "Cập nhật" : "Thêm"
      }
    },
    methods: {
      create(item) {
        this.isEdit = false
        ApiCaller().post(URLS.CATEGORIES(), {
            category: item
          })
          .then(response => {
            console.log(response);
            this.$message.success('Cập nhật thành công');
            this.$emit('updateListAfterUpdated', this.editItem);
          })
          .catch(error => {
            console.log(error);
          });
      },
      handleSubmit(e) {
        this.$refs.ruleForm.validate((valid) => {
          if (valid) {
            let valuesSave = Object.assign({}, this.editItem)
            if (this.isEdit) {
              let idItem = this.editItem.id
              ApiCaller().put(URLS.CATEGORY(idItem), {
                  category: valuesSave
                },{headers: {
                    'Content-Type': 'application/json'
                  }})
                .then(response => {
                  console.log(response);
                  this.$message.success('Cập nhật thành công')
                  this.$emit('updateListAfterUpdated', this.editItem);
                })
                .catch(error => {
                  console.log(error);
                });
            } else {
              this.create(valuesSave)
            }
            this.$emit('updateVisible', false);
            this.visible = false;
          } else {
            return false;
          }
        });
      },
      callDataRestaurant(){
        this.$emit('getDataRestaurant')
      },
      filterOption(input, option) {
        return (
          option.componentOptions.children[0].text.toLowerCase().indexOf(input.toLowerCase()) >= 0
        );
      },
      async changeDisplayHome(item) {
        const response = await ApiCaller().post(URLS.CHANGE_CATEGORY_DISPLAY_HOME(item.id))
        if(response) {
          this.$message.success('Bạn đã đổi hiển thị thành công')
        }
      }
    },
  };
</script>
