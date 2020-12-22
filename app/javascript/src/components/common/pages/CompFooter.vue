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
                <a href="#" class="footer__link">Address</a>
              </li>
              <li class="footer__item">
                <a href="" class="footer__link">Contacts</a>
              </li>
              <li class="footer__item">
                <a href="" class="footer__link">Policy</a>
              </li>
              <li class="footer__item">
                <a href="" class="footer__link">Sponsors</a>
              </li>
            </ul>
          </div>
        </a-col>
        <a-col :span="12" >
          <p class="footer__copyright">
            Copyright by Phong
          </p>
        </a-col>
      </a-row>

    </div>
  </footer>
  </div>
</template>

<script>
  export default {
    name: "CompFooter",
    data (){
      return {
        logo: '/uploads/image/photo/294/logoRestaurant.png',
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
