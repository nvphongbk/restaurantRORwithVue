<template>
  <div id="contact-us">
    <Navigation/>
    <div class="contact-body">
      <a-row>
        <a-col :span="12">
          <div class="contact--left">
            <h4 class="capitalize contact__title">Liên hệ với Mr Bolat</h4>
            <p class="contact__paragraph">Nhà hàng có một vị trí lý tưởng. Một bên là sự sầm uất và sang trọng của khu
              trung tâm Quận 1, một bên là sông Sài Gòn thơ mộng. Đây là nhà hàng nổi lớn nhất Việt Nam với sức chứa tối
              đa lên đến 750 khách, bao gồm 5 boong 2 thang máy, 2 thang bộ ....</p>
          </div>
          <div class="contact--left">
            <ul class="contact__paragraph contact-list">
              <li>
                <a-icon class="contact__icon" type="mail"/>
                +84 12345678
              </li>
              <li>
                <a-icon class="contact__icon" type="phone"/>
                +84 12345678
              </li>
              <li>
                <a-icon class="contact__icon" type="clock-circle"/>
                +84 12345678
              </li>
              <li>
                <a-icon class="contact__icon" type="facebook"/>
                facebook.com
              </li>
            </ul>
          </div>
        </a-col>
        <a-col :span="12">
          <div>
            <p class="contact__paragraph">Hãy cho chúng tôi biết cách liên lạc với bạn:</p>
          </div>
          <div>
            <a-form-model
              ref="ruleForm"
              :model="message"
              :rules="rules"
              :label-col="labelCol"
              :wrapper-col="wrapperCol"
            >
              <a-form-model-item ref="name" prop="name">
                <a-input class="contact__paragraph" v-model="message.name"
                         placeholder="Your name"/>
              </a-form-model-item>
              <a-form-model-item prop="email" ref="email">
                <a-input v-model="message.email" placeholder="email@gmail.com"
                         type="mail"/>
              </a-form-model-item>
              <a-form-model-item prop="message">
                <a-input v-model="message.message" type="textarea"
                         placeholder="Comment or question"/>
              </a-form-model-item>
              <a-form-model-item :wrapper-col="{ span: 14, offset: 4 }">
                <a-button class="uppercase" type="primary" @click="onSubmit">
                  Gửi
                </a-button>
                <a-button style="margin-left: 10px;" @click="resetForm">
                  Reset
                </a-button>
              </a-form-model-item>
            </a-form-model>
          </div>
        </a-col>
      </a-row>
    </div>
    <Footer/>
  </div>
</template>

<script>
  import axios from "axios"
  import {URLS} from "../utils/url";
  import Footer from "../../layouts/partials/Footer";
  import Navigation from "../../layouts/partials/Navigation";

  export default {
    name: "Contact",
    props: {
      logo: {
        type: String
      }
    },
    data() {
      return {
        labelCol: {span: 4},
        wrapperCol: {span: 14},
        message: {},
        rules: {},
      }
    },
    components: {Navigation, Footer},
    methods: {
      onSubmit() {
        this.$refs.ruleForm.validate(valid => {
          if (valid) {
            axios
              .post(URLS.MESSAGE_CONTACT(), {
                message: this.message
              })
              .then(response => {
                console.log("Created!");
                this.$message.success('Send message success');
                this.resetForm()
              })
              .catch(error => {
                console.log(error);
              });
          } else {
            console.log('error submit!!');
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
  #contact-us {
    background: rgb(24, 22, 20);;
  }

  .contact-body {
    padding: 30px 10px;
    padding-top: 150px;
  }

  .contact--left {
    width: 90%;
  }

  .contact__title {
    font-size: 40px;
    color: white;
  }

  .contact__paragraph {
    color: #6b6164;
  }

  .contact-list {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    align-items: center;
    width: 100%;
  }

  .contact-list li {
    width: 50%;
  }

  .contact__icon {
    color: #C1975D;
  }
</style>
