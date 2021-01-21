<template>
  <a-form-model
    :rules="rules"
    ref="ruleForm"
    :model="editItem"
    :label-col="{ span: 8 }"
    :wrapper-col="{ span: 16 }">
    <a-form-model-item label="Chọn nhà hàng" prop="restaurant_id">
      <a-select v-model="editItem.restaurant_id" placeholder="Chọn nhà hàng">
        <a-select-option v-for="restaurant in restaurants" :key="restaurant.id">
          {{ restaurant.name }}
        </a-select-option>
      </a-select>
    </a-form-model-item>
    <a-form-model-item label="Tên cách chế biến" prop="name">
      <a-input placeholder="Vui lòng điền tên thành phần"
               v-model="editItem.name" />
    </a-form-model-item>
    <a-form-model-item label="Vị trí hiển thị" prop="position">
      <a-input placeholder="Vui lòng điền vị trí" v-model="editItem.position" />
    </a-form-model-item>
    <a-form-model-item label="Kích hoạt" prop="is_active">
      <a-switch v-model="editItem.is_active"></a-switch>
    </a-form-model-item>
    <a-form-model-item :wrapperCol="{ offset: 8 }">
      <a-button @click="handleSubmit" type="primary" html-type="submit">
        Lưu
      </a-button>
      <a-button style="margin-left: 10px;" @click="resetForm">
        Reset
      </a-button>
    </a-form-model-item>
  </a-form-model>
</template>

<script>
  import {ApiCaller} from "../../utils/api";
  import {URLS} from "../../utils/url"
  export default {
    name: "FormCookingMethod",
    props: {
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
    data(){
      return{
        restaurants: [],
      }
    },
    mounted() {
      this.initialize()
    },
    methods: {
      async initialize() {
        let response = await ApiCaller().get(URLS.RESTAURANTS())
        this.restaurants = response.data
      },
      create(item) {
        this.isEdit = false
          return ApiCaller().post(URLS.COOKING_METHODS(), {
            cooking_method: item
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
                ApiCaller().put(URLS.COOKING_METHOD(idItem), {
                  cooking_method: valuesSave
                })
                .then(response => {
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
      resetForm() {
        this.$refs.ruleForm.resetFields();
      },
    },
  }
</script>

<style scoped>

</style>
