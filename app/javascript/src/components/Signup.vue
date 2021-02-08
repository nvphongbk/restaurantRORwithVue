<template>
  <div class="signin-form text-center h-screen bg-gradient-to-r from-yellow-400 via-red-500 to-pink-500">
    <a-alert
      v-show="isShowError"
      type="error"
      message="Wrong password or account"
      banner
    />
    <div class="container-form">
      <a-row class="form-row">
        <a-col :span="16" :offset="4" class="form-col">
          <h1 class="text-center form-title">Đăng ký</h1>
          <a-form-model layout="inline" ref="formsignup" :model="formsignup" @submit="handleSubmit" :rules="rules">
            <a-form-model-item prop="email">
              <a-input v-model="formsignup.email" placeholder="Email">
                <a-icon slot="prefix" type="mail" style="color:rgba(0,0,0,.25)"/>
              </a-input>
            </a-form-model-item>
            <a-form-model-item prop="password">
              <a-input v-model="formsignup.password" type="password" placeholder="Mật khẩu">
                <a-icon slot="prefix" type="lock" style="color:rgba(0,0,0,.25)"/>
              </a-input>
            </a-form-model-item>
            <a-form-model-item prop="checkpass">
              <a-input v-model="formsignup.checkpass" type="password" placeholder="Nhập lại mật khẩu">
                <a-icon slot="prefix" type="lock" style="color:rgba(0,0,0,.25)"/>
              </a-input>
            </a-form-model-item>
            <a-form-model-item>
              <a-row>
                <a-col :span="16" :offset="4">
                  <a-button type="primary" html-type="submit" class="login-form-button">
                    Gửi
                  </a-button>
                </a-col>
              </a-row>
            </a-form-model-item>
          </a-form-model>
        </a-col>
      </a-row>
    </div>
  </div>

</template>
<script>
  import axios from 'axios'
  import {URLS} from "../utils/url";

  export default {
    name: "Signup",
    data() {
      let validatePass = (rule, value, callback) => {
        if (value === '') {
          callback(new Error('Vui lòng nhập mật khẩu'));
        } else {
          if (this.formsignup.checkpass !== '') {
            this.$refs.ruleForm.validateField('checkpass');
          }
          callback();
        }
        callback();
      };
      let validatePass2 = (rule, value, callback) => {
        if (value === '') {
          callback(new Error('Vui lòng nhập lại mật khẩu '));
        } else if (value !== this.formsignup.password) {
          callback(new Error("Hai mật khẩu không khớp nhau"));
        } else {
          callback();
        }
      };
      let validEmail = (rule, value, callback) => {
        if (value === '') {
          callback(new Error('Vui lòng nhập email'));
        } else {
          callback();
        }
      };
      return {
        formsignup: {
          email: '',
          password: '',
          checkpass: ''
        },
        rules: {
          email: [{validator: validEmail, trigger: 'change'}],
          password: [{validator: validatePass, trigger: 'change'}],
          checkpass: [{validator: validatePass2, trigger: 'change'}],
        },
        isShowError: false
      };
    },
    methods: {
      handleSubmit(e) {
        e.preventDefault();
        isShowError:false
        if (this.formsignup.password === this.formsignup.checkpass) {
          axios
            .post(URLS.SIGNUP(), {user: this.formsignup})
            .then(response => {
              this.submitSuccessful(response);
              this.$router.push({path: '/signin'})
            })
            .catch(error => {
              console.log(error)
              this.$message.error('Email đã tồn tại')
              this.isShowError = true;
            });
        } else {
          this.$message.error('Mật khẩu và mật khẩu xác nhận phải giống nhau')
        }
      },
      submitSuccessful(response) {
        this.$message.success('Đăng ký thành công')
      },
    },
  }
</script>

<style scoped>
</style>
