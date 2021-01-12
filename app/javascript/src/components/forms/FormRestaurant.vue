<template>
  <a-form-model
    :rules="rules"
    ref="ruleForm"
    :model="editItem"
    :label-col="{ span: 5 }"
    :wrapper-col="{ span: 12 }">
    <a-form-model-item ref="name" label="Name" prop="name">
      <a-input placeholder="Please input name Restaurant"
               v-model="editItem.name" />
    </a-form-model-item>
    <a-form-model-item ref="address" label="Address" prop="address">
      <a-input placeholder="Please input address restaurant"
               v-model="editItem.address" />
    </a-form-model-item>
    <a-form-model-item ref="pass_wifi" label="Pass wifi" prop="pass_wifi">
      <a-input placeholder="Please input pass wifi restaurant"
               v-model="editItem.pass_wifi" />
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
  import axios from "axios";
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
        axios
          .post(URLS.RESTAURANTS(), {
            restaurant: item
          })
          .then(response => {
            console.log(response);
            this.$message.success('Created success');
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
              axios
                .put(URLS.RESTAURANT(idItem), {
                  restaurant: valuesSave
                },{headers: {
                    'Content-Type': 'application/json'
                  }})
                .then(response => {
                  console.log(response);
                  console.log("Updated!");
                  this.$message.success('Updated success')
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
