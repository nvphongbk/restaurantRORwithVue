<template>
  <a-form-model
    :rules="rules"
    ref="ruleForm"
    :model="editItem"
    :label-col="{ span: 5 }"
    :wrapper-col="{ span: 12 }">
    <a-form-model-item ref="name" label="Name" prop="name">
      <a-input placeholder="Nhập tên nhà hàng"
               v-model="editItem.name" />
    </a-form-model-item>
    <a-form-model-item ref="address" label="Address" prop="address">
      <a-input placeholder="Địa chỉ nhà hàng"
               v-model="editItem.address" />
    </a-form-model-item>
    <a-form-model-item ref="pass_wifi" label="Pass wifi" prop="pass_wifi">
      <a-input placeholder="Mật khẩu wifi"
               v-model="editItem.pass_wifi" />
    </a-form-model-item>
    <a-form-model-item ref="phone" label="Phone Number" prop="phone">
      <a-input placeholder="Số điện thoại"
               v-model="editItem.phone" />
    </a-form-model-item>

    <a-form-model-item :wrapperCol="{ offset: 8 }">
      <a-button @click="handleSubmit" type="primary" html-type="submit">
        Submit
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
    name: "FormRestaurant",
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
      return{}
    },
    methods:{
      create(item) {
        this.isEdit = false
          return ApiCaller().post(URLS.RESTAURANTS(), {
            restaurant: item
          })
          .then(response => {
            console.log(response);
            this.$message.success('Cập nhật thành công');
            this.$emit('updateListAfterUpdated', this.editItem);
            window.location.reload()
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
                ApiCaller().put(URLS.RESTAURANT(idItem), {
                  restaurant: valuesSave
                },{headers: {
                    'Content-Type': 'application/json'
                  }})
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
