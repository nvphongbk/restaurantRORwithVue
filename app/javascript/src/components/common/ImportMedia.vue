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
        <div id="gallery" v-for="(image, i) in images" :key="image.id">
          <a-popconfirm
            class="pop-delete-image"
            title="Bạn muốn xoá hình này?"
            ok-text="Xoá"
            cancel-text="Không"
            @confirm="deleteImage(image.id)"
          >
            <a href="#">x</a>
          </a-popconfirm>
          <img class="image" :src="image.url">
        </div>
      </div>
  </div>
</template>

<script>
  import {ApiCaller} from "../../utils/api";
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
        images:'',
        index: 0,
        imageUploadUrl: URLS.IMAGES
      }
    },
    mounted() {
      this.initialize()
    },
    methods: {
      initialize() {
        return ApiCaller().get(URLS.IMAGES())
          .then(response => {
            this.images = response.data;
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
      deleteImage(id) {
        return ApiCaller().delete(URLS.IMAGE(id))
          .then((res) => {
            this.$message.success('Đã xoá thành công');
            this.initialize()
          })
          .catch(error => {
            console.log(error);
          });
      },
    }
  }
</script>

<style scoped>
  #gallery{
    display: flex;
    max-width: 100px;
    position: relative;
  }
  #gallery .image{
    padding: 3px;
  }

  #gallery:hover .pop-delete-image {
    display: block;
  }

  .pop-delete-image {
    display: none;
    position: absolute;
    right: 3px;
    top: -5px;
    font-size: 25px;
    font-weight: 600;
    color: #E63543;
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
