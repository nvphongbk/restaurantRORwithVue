<template>
  <div class="clearfix" ref="uploadImage">
    <a-upload
      accept=".jpg, .png, .jpeg"
      :action="imageUploadUrl"
      list-type="picture-card"
      :file-list="fileList"
      :multiple="true"
      @preview="handlePreview"
      @change="handleChange"
    >
      <div v-if="fileList.length < 5">
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
</template>
<script>
  import {URLS} from "../utils/url";
  function getBase64(file) {
    return new Promise((resolve, reject) => {
      const reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onerror = error => reject(error);
    });
  }
  export default {
    data() {
      return {
        previewVisible: false,
        previewImage: '',
        fileList: [],
        imageUploadUrl: URLS.IMAGES
      };
    },
    props: {
      editImages: {
        type: Array
      }
    },
    watch: {
      editImages: {
        handler: function () {
          this.initializeImages()
        },
        deep: true
      }
    },
    mounted() {
      this.initializeImages()
    },
    methods: {
      handleCancel() {
        this.previewVisible = false;
        this.updateImageIds()
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
        this.updateImageIds()
      },
      initializeImages(){
        this.fileList = JSON.parse(JSON.stringify(this.editImages))
      },
      updateImageIds() {
        let images_ids = this.fileList.map((object) => {
          if(object.status === 'done') {
            return object.response.id
          } else {
            return object.id
          }
        })
        this.$emit('updateImageList', images_ids)
      }
    },
  };
</script>
<style>
  /* you can make up upload button and sample style by using stylesheets */
  .ant-upload-select-picture-card i {
    font-size: 32px;
    color: #999;
  }

  .ant-upload-select-picture-card .ant-upload-text {
    margin-top: 8px;
    color: #666;
  }
</style>
