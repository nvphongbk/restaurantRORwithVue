<template>
  <div id="aboutpage">
    <header class="aboutpage-header"
            :style="{'background-image':'url(/uploads/image/photo/5/background-header-about.jpg)'}">
      <div class="aboutpage-header-text-box">
        <h3 class="aboutpage-header-heading-primary">
          <span class="aboutpage-header-heading-primary__main">
               Restaurant
          </span>
          <span class="aboutpage-header-heading-primary__sub">
              is how you survive
          </span>
        </h3>
      </div>
    </header>
    <CompNavigation/>
    <div class="aboutpage-intro">
      <a-row>
        <a-col :span="13">
          <div class="aboutpage-our-story-composition">
            <img src="/uploads/our-story/our-story-us-1.jpg" alt="photo1"
                 class="aboutpage-our-story-composition__photo aboutpage-our-story-composition__photo--p1">
            <img src="/uploads/our-story/our-story-us-2.jpg" alt="photo2"
                 class="aboutpage-our-story-composition__photo aboutpage-our-story-composition__photo--p2">
            <img src="/uploads/our-story/our-story-us-3.jpg" alt="photo3"
                 class="aboutpage-our-story-composition__photo aboutpage-our-story-composition__photo--p3">
          </div>
        </a-col>
        <a-col :span="10" :offset="1">
          <div class="aboutpage-intro-content">
            <h4 class="intro-content__title">The Story</h4>
            <p class="intro-content__paragraph">
              Lorem ipsum dolor sit amet, consectetur adipisicing elit.
              Accusantium aut dolore ea eaque eius eligendi est explicabo fugit,
              in incidunt labore laborum, minima mollitia nam nesciunt numquam
              repellat, sit vel.
            </p>
          </div>
          <div>
            <h5 class="uppercase text-white text-lg">specialities</h5>
            <ul class="text-white flex flex-wrap">
              <li class="w-2/4">
                <a-icon class="intro__icon" type="sketch"/>
                Fine Dining
              </li>
              <li class="w-2/4">
                <a-icon class="intro__icon" type="sketch"/>
                Food Catering
              </li>
              <li class="w-2/4">
                <a-icon class="intro__icon" type="sketch"/>
                Food Delivery
              </li>
              <li class="w-2/4">
                <a-icon class="intro__icon" type="sketch"/>
                Wedding Ceremony
              </li>
            </ul>
          </div>
        </a-col>
      </a-row>
    </div>
    <div>
      <a-row class="aboutpage-archie">
        <a-col :span="10">
          <div>
            <h4 class="intro-content__title">The achievement</h4>
            <p class="intro-content__paragraph">
              Lorem ipsum dolor sit amet, consectetur adipisicing elit.
              Accusantium aut dolore ea eaque eius eligendi est explicabo fugit,
              in incidunt labore laborum, minima mollitia nam nesciunt numquam
              repellat, sit vel.
            </p>
          </div>
        </a-col>
        <a-col :span="13" :offset="1">
          <div class="composition">
            <img src="/uploads/our-story/our-story-us-1.jpg" alt="photo1"
                 class="w-3/4">
          </div>
        </a-col>
      </a-row>
      <div>
        <a-row>
          <div class="aboutpage-quote text-center">
            <p class="text-white aboutpage-quote__text">"The discovery of a new
              dish does more for the happiness of mankind than the discovery of
              a star."</p>
            <p class="uppercase aboutpage-quote__author">ANTHELME
              BRILLAT-SAVARIN</p>
          </div>
        </a-row>
      </div>
      <Footer
        :logo="logo"
      />
    </div>
  </div>
</template>

<script>
  import CompNavigation from "./common/pages/CompNavigation"
  import ARow from "ant-design-vue/es/grid/Row";
  import ACol from "ant-design-vue/es/grid/Col";
  import Footer from "./common/pages/CompFooter"

  export default {
    name: "About",
    components: {ACol, ARow, CompNavigation, Footer},
    props: {
      logo: {
        type: String
      },
    }
  }
</script>

<style scoped>
  #aboutpage {
    background: rgb(24, 22, 20);
  }

  .aboutpage-header {
    background-size: cover;
    background-position: top;
    position: relative;
    height: 100vh;
    clip-path: ellipse(60% 65% at 50% 33%);
  }

  .intro-content__title {
    font-size: 40px;
    bold: 700;
    color: white;
  }

  .intro-content__paragraph {
    font-size: 14px;
    color: #6B615A;
  }

  .aboutpage-header-text-box {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    text-align: center;
  }

  .aboutpage-header-heading-primary {
    color: #fff;
    text-transform: uppercase;
    margin-bottom: 60px;
  }

  .aboutpage-header-heading-primary__main {
    display: block;
    font-size: 62px;
    font-weight: 400;
    letter-spacing: 15px;
    animation: moveInLeft 1s ease-out;
  }

  .aboutpage-header-heading-primary__sub {
    display: block;
    font-size: 20px;
    font-weight: 700;
    letter-spacing: 18px;
    animation: moveInRight 1s ease-out
  }

  .aboutpage-intro {
    margin: 30px 10px;
    height: 350px;
  }

  .aboutpage-archie {
    margin: 30px 10px;
    height: 450px;
  }

  .aboutpage-our-story-composition {
    position: relative;
  }

  .aboutpage-our-story-composition__photo {
    width: 50%;
    box-shadow: 0 3px 5px rgba(192, 192, 192, .4);
    border-radius: 3px;
    position: absolute;
    z-index: 10;
  }

  .aboutpage-our-story-composition__photo--p1 {
    left: 0;
    top: -6px;
  }

  .aboutpage-our-story-composition__photo--p2 {
    right: 5px;
    top: 30px;
  }

  .aboutpage-our-story-composition__photo--p3 {
    left: 15%;
    top: 50px;
  }

  .aboutpage-our-story-composition__photo:not(:hover) {
    transform: scale(.9)
  }

  .aboutpage-our-story-composition__photo:hover {
    outline: 2px solid cornflowerblue;
    transform: scale(1.05);
    box-shadow: 0 7px 12px rgba(192, 192, 192, .5);
    z-index: 100;
  }

  .intro__icon {
    margin-top: 4px;
    margin-right: 2px;
  }

  .aboutpage-quote {
    width: 60%;
    height: 300px;
    padding: 100px;
    margin-left: 20%;
  }

  .aboutpage-quote__text {
    font-size: 23px;
    font-style: italic;
  }

  .aboutpage-quote__author {
    font-size: 20px;
    color: #C1975D;
  }
</style>
