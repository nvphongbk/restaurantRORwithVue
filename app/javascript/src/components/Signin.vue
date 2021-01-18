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
          <h1 class="text-center form-title">Sign in</h1>
          <a-form-model layout="inline" :model="formsignin" @submit="handleSubmit">
            <a-form-model-item>
              <a-input v-model="formsignin.email" placeholder="Email">
                <a-icon slot="prefix" type="mail" style="color:rgba(0,0,0,.25)" />
              </a-input>
            </a-form-model-item>
            <a-form-model-item>
              <a-input v-model="formsignin.password" type="password" placeholder="Password">
                <a-icon slot="prefix" type="lock" style="color:rgba(0,0,0,.25)" />
              </a-input>
            </a-form-model-item>
            <a-form-model-item>
              <a-row>
                <a-col :span="16" :offset="4">
                  <a-button type="primary" html-type="submit" class="login-form-button">
                    Sign in
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
  import {JWT_KEY} from "../utils/constant";
  import ARow from "ant-design-vue/es/grid/Row";
  import ACol from "ant-design-vue/es/grid/Col";

  export default {
    name: 'SignIn',
    components: {ACol, ARow},
    data() {
      return {
        formsignin:{
          email:'tester@ment.vn',
          password:'123456'
        },
        isShowError:false,
      };
    },
    methods: {
      handleSubmit(e) {
        e.preventDefault();
        isShowError:false
        axios
          .post(URLS.SIGNIN(), this.formsignin)
          .then(response => {
            this.submitSuccessful(response);
          })
          .catch(error => {
            console.log(error);
            this.isShowError = true;
          });
      },
      submitSuccessful(response){
        this.$message.success('Sign in success')
        setTimeout(() => {
          localStorage.setItem(JWT_KEY, response.data.auth_token);
          this.$router.push({ name: "Dashboard" });
        }, 100)
      },
    },
  };
</script>
<style>
  .container-form{
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100%;
  }
  .form-title{
    font-size: 45px;
    bold: 700;
    margin-top: 30px;
  }
  .ant-form-item{
    width: 100%;
  }
  .ant-form-item-control-wrapper{
    width: 100%;
  }
  .form-row{
    background-color: white;
    border-radius: 30px;
    box-shadow: 5px 5px 10px 5px #888888;
  }
  .form-col{
    height: 500px;
  }
  .login-form-button
  {
    width: 100%;
  }
</style>

