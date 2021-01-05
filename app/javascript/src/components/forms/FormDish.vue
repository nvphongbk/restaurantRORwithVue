<template>
  <div>
    <a-form-model
      :rules="rules"
      ref="ruleForm"
      :model="editItem"
      :label-col="{ span: 5 }"
      :wrapper-col="{ span: 12 }">
      <a-form-model-item ref="name" label="Name" prop="name">
        <a-input placeholder="Please input name dish" :autoFocus="true"
                 v-model="editItem.name"/>
      </a-form-model-item>
      <a-form-model-item ref="price" label="Price" prop="price">
        <a-input placeholder="Please input price dish"
                 v-model="editItem.price"/>
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
          :editImages="editItem.images_attributes"
          @updateImageList="updateImageList"
        />
      </div>

      <a-form-model-item :wrapperCol="{ offset: 8 }">
        <a-button @click="handleSubmit" type="primary" html-type="submit">
          Submit
        </a-button>
        <a-button style="margin-left: 10px;" @click="resetForm">
          Reset
        </a-button>
      </a-form-model-item>
    </a-form-model>
  </div>
</template>
<script>


  import axios from "axios";
  import {URLS} from "../../utils/url"
  import UploadImage from "../UploadImage"
  import reqwest from 'reqwest'
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
    computed: {},
    mounted() {
      this.callDataRestaurant()
      this.getDataCategory()
    },

    methods: {
      create(item) {
        this.isEdit = false

        axios
          .post(URLS.DISHES(), {
            dish: item
          })
          .then(response => {
            this.$message.success('Created success');
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

              axios
                .put(URLS.DISH(idItem), {
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
            this.visible = false;
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
        return axios
          .get(URLS.CATEGORIES())
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
