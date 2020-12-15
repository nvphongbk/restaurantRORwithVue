<template>
  <div>
    <a-upload
      accept=".jpg,.png,.jpeg"
      :action="imageUploadUrl"
      list-type="picture-card"
      :file-list="fileList"
      :multiple="true"
      @preview="handlePreview"
      @change="handleChange"
    >
      <div v-if="fileList.length < 50">
        <a-icon type="plus" />
        <div class="ant-upload-text">
          Upload
        </div>
      </div>
    </a-upload>
    <a-modal :visible="previewVisible" :footer="null" @cancel="handleCancel">
      <img alt="example" style="width: 100%" :src="previewImage" />
    </a-modal>
      <div class="flex flex-wrap">
        <div id="gallery" v-for="(image, i) in images">
          <img class="image" :src="image">
        </div>
      </div>
  </div>
</template>

<script>
  import axios from 'axios'
  import {URLS} from "../../utils/url";
  function getBase64(file) {
    return new Promise((resolve, reject) => {
      const reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = () => resolve(reader.result);
      reader.onerror = error => reject(error);
    });
  }
  export default {
    name: "ImportMedia",
    data() {
      return {
        previewVisible: false,
        previewImage: '',
        fileList: [],
        desserts:'',
        images: [],
        index: 0,
        imageUploadUrl: URLS.IMAGES
      }
    },
    mounted() {
      this.initialize()
    },
    methods: {
      initialize() {
        return axios
          .get(URLS.IMAGES())
          .then(response => {
            const arrUrl=[]
            this.desserts = response.data;
            this.desserts.forEach(function(item){
                arrUrl.push(item.url)
              }
            )
            this.images = arrUrl
          })
          .catch(e => {
          });
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
    }
  }
</script>

<style scoped>
  #gallery{
    display: flex;
    max-width: 100px;
  }
  #gallery .image{
    padding: 3px;
  }
  .ant-upload-select-picture-card i {
    font-size: 32px;
    color: #999;
  }

  .ant-upload-select-picture-card .ant-upload-text {
    margin-top: 8px;
    color: #666;
  }
</style>
