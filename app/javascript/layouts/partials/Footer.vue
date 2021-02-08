<template>
  <div>
  <footer class="footer">
    <div class="footer__logo-box">
      <img :src="logo" class="footer__logo">
    </div>
    <div>
      <a-row>
        <a-col :span="12">
          <div class="footer__navigation">
            <ul class="footer__list">
              <li class="footer__item">
                <router-link :to="{name: 'HomePage'}" class="footer__link" >Trang chủ</router-link>
              </li>
              <li class="footer__item">
                <router-link :to="{name: 'LoginPage'}" class="footer__link" >Đăng ký</router-link>
              </li>
              <li class="footer__item">
                <router-link :to="{name: 'RegistrationPage'}" class="footer__link" >Đăng nhập</router-link>
              </li>
              <li class="footer__item">
                <router-link :to="{name: 'Contact'}" class="footer__link">Liên hệ</router-link>
              </li>
            </ul>
          </div>
        </a-col>
        <a-col :span="12" >
          <p class="footer__copyright">
            Copyright by <a href="https://ment.vn">Ment Company</a>
          </p>
        </a-col>
      </a-row>

    </div>
  </footer>
  </div>
</template>

<script>
  export default {
    name: "Footer",
    data (){
      return {
        logo: '/uploads/logo/logo-ment.png',
      }
    },
  }
</script>

<style scoped>
  .footer {
    background-color: #333;
    padding: 30px 30px;
    font-size: 15px;
    color: white;
  }

  .footer__logo-box {
    text-align: center;
    margin-bottom: 30px;
  }
  .footer__logo{
    margin: 0 auto;
    width: 150px;
  }
  .footer__copyright {
    border-top: 1px solid lightgoldenrodyellow;
    padding-top: 10px;
    width: 70%;
    float: right;
  }
  .footer__navigation {
    border-top: 1px solid lightgoldenrodyellow;
    padding-top: 10px;
    display: inline-block;
    width: 70%;
  }
  .footer__list {
    list-style: none;
    display: flex;
    justify-content: space-between;
  }
  .footer__item {
    display: inline-block;
  }
  .footer__item:not(:last-child) {
    margin-right: 5px;
  }
</style>
