<template>
  <a-form-model
    :rules="rules"
    ref="ruleForm"
    :model="editItem"
    :label-col="{ span: 5 }"
    :wrapper-col="{ span: 12 }">
    <a-form-model-item ref="name" label="Name" prop="name">
      <a-input placeholder="Please input name dish" :autoFocus="true"
               v-model="editItem.name" />
    </a-form-model-item>
    <a-form-model-item ref="price" label="Price" prop="price">
      <a-input placeholder="Please input price dish"
               v-model="editItem.price" />

      {{this.editItem.image}}
    </a-form-model-item>
    <div class="clearfix">
      <a-upload
        :before-upload="beforeUpload"
        list-type="picture-card"
        :file-list="fileList"
        @preview="handlePreview"
        @change="handleChange"
      >
        <div v-if="fileList.length < 8">
          <a-icon type="plus" />
          <div class="ant-upload-text">
            Upload
          </div>
        </div>
      </a-upload>
      <a-modal :visible="previewVisible" :footer="null" @cancel="handleCancel">
        <img alt="example" style="width: 100%" :src="previewImage" />
      </a-modal>
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
</template>
<script>
  function getBase64(file) {
    return new Promise((resolve, reject) => {
      const reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = () => resolve(reader.result);
      reader.onerror = error => reject(error);
    });
  }
  import axios from "axios";
  // import DishImage from "./DishImage"
  export default {
    name: "FormDish",
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
        previewVisible: false,
        previewImage: '',
        fileList: [
          {
            uid: '-1',
            name: 'image.png',
            status: 'done',
            url: this.editItem.image.url
          }
        ],
      };
    },
    components: {
      // DishImage
    },
    computed: {
    },
    mounted(){
      this.callDataRestaurant()
    },
    methods: {
      create(item) {
        let formData = new FormData();
        formData.append("dish[name]", item.name)
        formData.append("dish[price]", item.price)
        formData.append("dish[image]", this.fileList[0].originFileObj)
        this.isEdit = false
        axios
          .post("http://localhost:3000/api/v1/dishes/", formData, {
            headers: {
              "Content-Type": "application/json"
            }
          })
          .then(response => {
            console.log(response);
            console.log("Created!");
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
            console.log(valuesSave.image,"valuesa")
            if (this.isEdit) {
              let idItem = this.editItem.id
              let formData = new FormData();
              formData.append("dish[name]", valuesSave.name)
              formData.append("dish[price]", valuesSave.price)
              formData.append("dish[image]", this.fileList[0].originFileObj)
              axios
                .put(`http://localhost:3000/api/v1/dishes/${idItem}`, formData, {
                  headers: {
                    "Content-Type": "application/json"
                  }
                })
                .then(response => {
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
        console.log(this.editItem.image.url, "sdsd")
      },
      callDataRestaurant(){
        this.$emit('getDataRestaurant')
      },
      filterOption(input, option) {
        return (
          option.componentOptions.children[0].text.toLowerCase().indexOf(input.toLowerCase()) >= 0
        );
      },

      handleCancel() {
        this.previewVisible = false;
      },
      async handlePreview(file) {
        if (!file.url && !file.preview) {
          file.preview = await getBase64(file.originFileObj);
        }
        this.previewImage = file.url || file.preview;
        this.previewVisible = true;
      },
      handleChange({ fileList }) {
        this.fileList = fileList;
      },
      beforeUpload(file) {
        this.fileList = [...this.fileList, file];
        return false;
      },



    },
  };
</script>

