<template>
  <div id="homepage">
    <header class="homepage-header"
            :style="{'background-image':'linear-gradient(to right bottom, rgba(142, 158, 252, .4),rgba(28, 62, 255, .4)),url(/uploads/image/photo/295/background-header.jpg)'}">
      <div class="homepage-header-text-box">
        <h3 class="homepage-header-heading-primary">
          <span class="homepage-header-heading-primary__main">
               Restaurant
          </span>
          <span class="homepage-header-heading-primary__sub">
              is how you survive
          </span>
        </h3>
        <a href="#" class="btn btn-white btn-animated">See our Restaurant</a>
      </div>
    </header>
    <CompNavigation/>
    <div class="homepage-our-story">
      <div class="text-center">
        <h2 class="homepage__heading-secondary">
          Our Store US
        </h2>
      </div>
      <a-row>
        <a-col :span="12">
          <h3 class="homepage-our-story__heading-tertiary">
            from zero to hero
          </h3>
          <p class="homepage-our-story__paragraph">
            Lorem ipsum dolor sit amet,
            consectetur adipisicing elit.
            Fuga cumque autem officiis distinctio,
            voluptate qui minima.
            Magnam tenetur suscipit eius beatae dolore nihil
            repudiandae atque vero,
            rem, labore ullam ipsa incidunt enim id necessitatibus at dolor!
            Incidunt sequi nihil amet.
          </p>
          <h3 class="homepage-our-story__heading-tertiary">
            master your skills
          </h3>
          <p class="homepage-our-story__paragraph">
            Lorem ipsum dolor sit amet,
            consectetur adipisicing elite.
          </p>
        </a-col>
        <a-col :span="12">
          <div class="homepage-our-story-composition">
            <img src="/uploads/our-story/our-story-us-1.jpg" alt="photo1"
                 class="homepage-our-story-composition__photo homepage-our-story-composition__photo--p1">
            <img src="/uploads/our-story/our-story-us-2.jpg" alt="photo2"
                 class="homepage-our-story-composition__photo homepage-our-story-composition__photo--p2">
            <img src="/uploads/our-story/our-story-us-3.jpg" alt="photo3"
                 class="homepage-our-story-composition__photo homepage-our-story-composition__photo--p3">
          </div>
        </a-col>
      </a-row>
    </div>
    <div class="homepage-our-restaurant"
         :style="{'background-image':'url(/uploads/image/photo/295/background-header.jpg)'}"
    >
      <div class="text-center">
        <h2 class="homepage__heading-secondary mt-5">
          Our Restaurant
        </h2>
      </div>
      <a-row>
        <div class="homepage-card-restaurant" v-for="restaurant in restaurants"
             :value="restaurant.id">
          <a-col class="col-card" :span="6">

            <div class="homepage-card-restaurant-card">
              <h4 class="homepage__restaurant-name">{{restaurant.name}}</h4>
              <p>Address: {{restaurant.address}}</p>
              <router-link :to="{name: 'Menu', params: {id: restaurant.id }}">
                <span class="nav-text"><a href="#" class="btn btn-white">See menu</a></span>
              </router-link>
            </div>
          </a-col>
        </div>
      </a-row>
    </div>
    <div class="section-testimonials">
      <div class="text-center">
        <h2 class="homepage__heading-secondary">
          testimonials
        </h2>
      </div>
      <div class="row">
        <div class="testimonial">
          <figure class="testimonial__shape">
            <img src="/uploads/our-story/our-story-us-1.jpg"
                 class="testimonial__img" alt="photo1">
            <figcaption class="testimonial__caption">
              Mr Sach
            </figcaption>
          </figure>
          <div class="testimonial__text">
            <h3 class="heading-tertiary u-margin-bottom-small">
              thank for your guide
            </h3>
            <p>
              Lorem ipsum dolor sit amet consectetur adipisicing elit.
              Incidunt repellat tenetur officia quis quasi,
              temporibus neque reiciendis quaerat exercitationem quibusdam?
              Lorem ipsum dolor sit amet consectetur adipisicing elit.
              Possimus dolorem labore nam?
            </p>
          </div>
        </div>
        <div class="testimonial">
          <figure class="testimonial__shape">
            <img src="/uploads/our-story/our-story-us-1.jpg"
                 class="testimonial__img" alt="photo2">
            <figcaption class="testimonial__caption">
              Mr Phuc
            </figcaption>
          </figure>
          <div class="testimonial__text">
            <h3 class="heading-tertiary u-margin-bottom-small">
              Dish very good
            </h3>
            <p>
              Lorem ipsum dolor sit amet consectetur adipisicing elit.
              Incidunt repellat tenetur officia quis quasi,
              temporibus neque reiciendis quaerat exercitationem quibusdam?
              Lorem ipsum dolor sit amet consectetur adipisicing elit.
              Possimus dolorem labore nam?
            </p>
          </div>
        </div>
      </div>
    </div>
    <CompFooter/>
  </div>
</template>

<script>
  import axios from 'axios'
  import {URLS} from "../utils/url";
  import ACol from "ant-design-vue/es/grid/Col";
  import CompFooter from "./common/pages/CompFooter"
  import CompNavigation from "./common/pages/CompNavigation"

  export default {
    name: 'HomePage',
    components: {CompNavigation, CompFooter, ACol},
    data() {
      return {
        restaurants: '',
        restaurant_id: String
      };
    },
    props: {
      logo: {
        type: String
      }
    },
    mounted() {
      this.DataRestaurant();
    },
    methods: {
      DataRestaurant() {
        return axios
          .get(URLS.RESTAURANTS())
          .then(response => {
            console.log(response.data);
            this.restaurants = response.data;
            console.log(this.restaurants)
          })
          .catch(e => {
            console.log(e);
          });
      },
    },
  }
</script>
<style>

  * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
  }

  .homepage-header {
    background-size: cover;
    background-position: top;
    position: relative;
    height: 100vh;
    clip-path: ellipse(60% 65% at 50% 33%);
  }

  .homepage-header-text-box {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    text-align: center;
  }

  .homepage-header-heading-primary {
    color: #fff;
    text-transform: uppercase;
    margin-bottom: 60px;
  }

  .homepage-header-heading-primary__main {
    display: block;
    font-size: 62px;
    font-weight: 400;
    letter-spacing: 15px;
    animation: moveInLeft 1s ease-out;
  }

  .homepage-header-heading-primary__sub {
    display: block;
    font-size: 20px;
    font-weight: 700;
    letter-spacing: 18px;
    animation: moveInRight 1s ease-out
  }

  .btn,
  .btn:link,
  .btn:visited {
    height: 55px;
    text-transform: uppercase;
    text-decoration: none;
    padding: 15px 40px;
    display: inline-block;
    border-radius: 100px;
    font-size: 16px;
    position: relative;
  }

  .btn::after {
    content: "";
    display: inline-block;
    height: 100%;
    width: 100%;
    top: 0;
    left: 0;
  }

  .btn:hover {
    transform: translateY(-3px);
    box-shadow: 0 5px 20px rgba(0, 0, 0, .2);
    background: whitesmoke;
  }

  .btn:active {
    outline: none;
    transform: translateY(-1px);
    box-shadow: 0 5px 10px rgba(0, 0, 0, .2);
  }

  .btn-animated {
    animation: moveInBottom .5s ease-out .75s;
    animation-fill-mode: backwards;
  }

  .btn-white {
    color: #777777;
    background-color: #fff;
  }

  .homepage-our-story {
    height: 410px;
    margin: 0 10px;
  }

  .homepage__heading-secondary {
    font-size: 45px;
    text-transform: uppercase;
    font-weight: 700;
    display: inline-block;
    letter-spacing: .2rem;
    background-image: linear-gradient(to right,
    blue, #b2f5ea);
    color: transparent;
    -webkit-background-clip: text;
  }

  .homepage-our-story__heading-tertiary {
    font-size: 25px;
    font-weight: 300;
    text-transform: uppercase;
  }

  .homepage-our-story-composition {
    position: relative;
  }

  .homepage-our-story-composition__photo {
    width: 50%;
    box-shadow: 0 3px 5px rgba(192, 192, 192, .4);
    border-radius: 3px;
    position: absolute;
    z-index: 10;
  }

  .homepage-our-story-composition__photo--p1 {
    left: 0;
    top: -6px;
  }

  .homepage-our-story-composition__photo--p2 {
    right: 5px;
    top: 30px;
  }

  .homepage-our-story-composition__photo--p3 {
    left: 15%;
    top: 50px;
  }

  .homepage-our-story-composition__photo:not(:hover) {
    transform: scale(.9)
  }

  .homepage-our-story-composition__photo:hover {
    outline: 2px solid cornflowerblue;
    transform: scale(1.05);
    box-shadow: 0 7px 12px rgba(192, 192, 192, .5);
    z-index: 100;
  }

  .homepage-card-restaurant .ant-col-6 {
    padding: 15px;
  }

  .homepage-card-restaurant-card {
    background-image: linear-gradient(to left bottom, rgba(217, 167, 199, .5), rgba(255, 252, 220, .5));
    background-color: rgba(256, 256, 256, .6);
    background-size: cover;
    background-position: center;
    position: relative;
    padding: 5px;
    height: 200px;
    text-align: center;
    border-radius: 10px;
    box-shadow: 0 5px 20px rgba(0, 0, 0, .15);
  }

  .homepage-card-restaurant-card:hover {
    cursor: pointer;
    transform: scale(1.02);
    background-color: rgba(256, 256, 256, .8);
  }

  .homepage__restaurant-name {
    font-size: 30px;
  }

  .section-testimonials {
    position: relative;
    padding: 40px 0;
  }

  .testimonial {
    width: 60%;
    height: 160px;
    padding: 18px;
    margin: 0 auto;
    margin-top: 10px;
    box-shadow: 0 9px 18px rgba(256, 256, 256, .15);
    border-radius: 100px;
    background-color: rgba(0, 0, 0, .1);
    padding-left: 25px;
  }

  .testimonial__shape {
    width: 125px;
    height: 125px;
    background-color: orangered;
    float: left;
    clip-path: circle(50% at 50% 50%);
    transform: translateX(-9px);
    shape-outside: circle(60% at 50% 50%);
  }

  .testimonial__img {
    width: 100%;
    transition: all .3s;
  }

  .testimonial:hover .testimonial__img {
    transform: scale(1.05);
    filter: blur(1.5px) brightness(70%);
  }

  .testimonial__caption {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, 20%);
    color: white;
    text-transform: uppercase;
    font-size: 20px;
    text-align: center;
    opacity: 0;
    transition: all .3s;
  }

  .testimonial:hover .testimonial__caption {
    opacity: 1;
    transform: translate(-50%, -50%);
  }

  @keyframes moveInLeft {
    0% {
      opacity: 0;
      transform: translateX(-100px);
    }

    80% {
      transform: translateX(10px)
    }

    100% {
      opacity: 1;
      transform: translateX(0);
    }
  }

  @keyframes moveInRight {
    0% {
      opacity: 0;
      transform: translateX(100px);
    }

    80% {
      transform: translateX(-10px)
    }

    100% {
      opacity: 1;
      transform: translateX(0);
    }
  }

  @keyframes moveInBottom {
    0% {
      opacity: 0;
      transform: translateY(30px);
    }

    100% {
      opacity: 1;
      transform: translateY(0);
    }
  }
</style>
