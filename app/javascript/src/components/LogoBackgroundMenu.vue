<template>
  <div>
    <a-row>
      <a-col :span="6">
        Thay đổi Logo:
      </a-col>
      <a-col :span="12">
        <a-upload
          name="file"
          list-type="picture-card"
          class="avatar-uploader"
          :show-upload-list="false"
          :action="uploadLogo"
          :before-upload="beforeUpload"
          @change="handleChangeLogo"
        >
          <img v-if="currentLogo" :src="currentLogo" alt="avatar" />
          <div v-else>
            <a-icon :type="loading ? 'loading' : 'plus'" />
            <div class="ant-upload-text">
              Upload
            </div>
          </div>
        </a-upload>
      </a-col>
    </a-row>
    <a-row>
      <a-col :span="6">
        Thay đổi Background:
      </a-col>
      <a-col :span="12">
        <a-upload
          name="file"
          list-type="picture-card"
          class="avatar-uploader"
          :show-upload-list="false"
          :action="uploadBackground"
          :before-upload="beforeUpload"
          @change="handleChangeBackground"
        >
          <img v-if="currentBackground" :src="currentBackground" alt="background menu" />
          <div v-else>
            <a-icon :type="loading ? 'loading' : 'plus'" />
            <div class="ant-upload-text">
              Upload
            </div>
          </div>
        </a-upload>
      </a-col>
    </a-row>
  </div>
</template>
<script>
  import { mapGetters, mapActions } from 'vuex'
  import {URLS} from "../utils/url";
  import Menu from "./menu/Menu"
  import {ApiCaller} from "../utils/api";

  export default {
    components: {Menu},
    data() {
      return {
        loading: false,
        currentLogo: '',
        currentBackground: '',
        uploadLogo: URLS.LOGOS(),
        uploadBackground: URLS.BACKGROUNDS()
      };
    },
    computed: {
      ...mapGetters([
        'currentRestaurant'
      ]),
    },
    mounted() {
      this.initializeLogo()
      this.initializeBackground()
    },
    methods: {
      initializeLogo() {
        return ApiCaller().get(URLS.LOGOS())
          .then(response => {
            this.currentLogo = response.data.photo.url
          })
          .catch(e => {
            console.log(e);
          });
      },
      initializeBackground() {
        return ApiCaller().get(URLS.BACKGROUNDS())
          .then(response => {
            this.currentBackground = response.data.photo.url
          })
          .catch(e => {
            console.log(e);
          });
      },
      handleChangeLogo(info) {
        if (info.file.status === 'uploading') {
          this.loading = true;
          return;
        }
        if (info.file.status === 'done') {
          this.currentLogo = info.file.response.photo.url
          let restaurantId = {restaurant_id: this.currentRestaurant.id}
          ApiCaller().put(URLS.LOGO(info.file.response.id), {
            logo: restaurantId
          })
            .then(response => {
              console.log(response)
              this.$message.success('Cập nhật logo thành công')
            })
            .catch(error => {
              console.log(error);
            });
        }
      },
      handleChangeBackground(info) {
        if (info.file.status === 'uploading') {
          this.loading = true;
          return;
        }
        if (info.file.status === 'done') {
          this.currentBackground = info.file.response.photo.url
          let restaurantId = {restaurant_id: this.currentRestaurant.id}
          ApiCaller().put(URLS.BACKGROUND(info.file.response.id), {
            background: restaurantId
          })
            .then(response => {
              console.log(response)
              this.$message.success('Cập nhật background thành công')
            })
            .catch(error => {
              console.log(error);
            });
        }
      },
      beforeUpload(file) {
        const isJpgOrPng = file.type === 'image/jpeg' || file.type === 'image/png';
        if (!isJpgOrPng) {
          this.$message.error('You can only upload JPG file!');
        }
        const isLt2M = file.size / 1024 / 1024 < 2;
        if (!isLt2M) {
          this.$message.error('Image must smaller than 2MB!');
        }
        return isJpgOrPng && isLt2M;
      },
    },
  };
</script>
<style>
  .avatar-uploader > .ant-upload {
    width: 128px;
    height: 128px;
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
