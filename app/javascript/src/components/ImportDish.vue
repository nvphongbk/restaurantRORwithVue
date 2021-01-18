<template>
  <div class="clearfix">
    <h4> Sample Form:
      <a-button
        @click="downloadSampleform()">
        <a-icon type="download"/>
      </a-button>
    </h4>
    <a-upload :file-list="fileList" :remove="handleRemove"
              :before-upload="beforeUpload">
      <a-button :disabled="fileList.length > 0">
        <a-icon type="upload"/>
        Select file
      </a-button>
    </a-upload>
    <a-button
      type="primary"
      :disabled="fileList.length === 0"
      :loading="uploading"
      style="margin-top: 16px"
      @click="handleUpload"
    >
      {{ uploading ? 'Uploading' : 'Start Upload' }}
    </a-button>
  </div>
</template>

<script>
  import {ApiCaller} from "../utils/api";
  import axios from "axios";
  import reqwest from "reqwest";
  import {URLS} from "../utils/url";

  export default {
    name: "ImportDish",
    data() {
      return {
        fileList: [],
        uploading: false,
      }
    },
    methods: {
      handleRemove(file) {
        const index = this.fileList.indexOf(file);
        const newFileList = this.fileList.slice();
        newFileList.splice(index, 1);
        this.fileList = newFileList;
      },
      beforeUpload(file) {
        this.fileList = [...this.fileList, file];
        return false;
      },
      handleUpload() {
        const {fileList} = this;
        const formData = new FormData();
        fileList.forEach(file => {
          formData.append('files[]', file);
        });
        this.uploading = true;
        ApiCaller() ({
          url: URLS.IMPORT_DATA(),
          method: 'post',
          processData: false,
          data: formData,
        }).then((response) => {
          console.log('ok')
          this.fileList = [];
          this.uploading = false;
          this.$message.success('upload thành công.');
          this.$emit('updateListAfterUpdated', '');
        }).catch(e => {
          console.log(e)
          this.uploading = false;
          this.$message.error('upload thất bại.');
        });
      },
      downloadSampleform() {
        axios({
          url: URLS.FILE_XAMPLE_IMPORT_DATA(),
          method: 'GET',
          responseType: 'blob',
        }).then((response) => {
          var fileURL = window.URL.createObjectURL(new Blob([response.data]));
          var fileLink = document.createElement('a');

          fileLink.href = fileURL;
          fileLink.setAttribute('download', URLS.FILE_XAMPLE_IMPORT_DATA());
          document.body.appendChild(fileLink);

          fileLink.click();
        });
      },
    },

  }
</script>

<style scoped>

</style>
