<template>
  <section id="our_menu">
    <Compnavigation/>
    <div class="container-menu pt-0"
         :style="{'background-image':'linear-gradient(to right bottom, rgba(142, 158, 252, .8),rgba(28, 62, 255, .8)),url(http://localhost:3000/uploads/image/photo/4/background-menu.jpg'}">
      <a-row>
        <a-col :span="24">
          <div class="menu-page_title text-center mb-4">
            <h1>our menu</h1>
            <div class="menu-single_line"></div>
          </div>
        </a-col>
      </a-row>
      <a-tabs type="card">
        <a-tab-pane key="all" tab="All">
          <div v-for='category in menu'>
            <div class="text-center menu-name_category">{{category.name}}</div>
            <div class="single_menu" v-for='dish in category.dishes'>
              <img class="menu-dish_img" :src="dish.images_attributes[0].url">
              <div class="menu_content">
                <h4>{{dish.name}} <span>${{dish.price}}</span></h4>
              </div>
            </div>
          </div>
        </a-tab-pane>
        <template v-for='category in menu'>
          <a-tab-pane :key="category.id" :tab="category.name">
            <div class="single_menu" v-for='dish in category.dishes'>
              <img class="menu-dish_img" :src="dish.images_attributes[0].url">
              <div class="menu_content">
                <h4>{{dish.name}} <span>${{dish.price}}</span></h4>
              </div>
            </div>
          </a-tab-pane>
        </template>
      </a-tabs>
    </div>
  </section>
</template>

<script>
  import axios from 'axios'
  import {URLS} from "../utils/url";
  import ACol from "ant-design-vue/es/grid/Col";
  import Compnavigation from "./common/pages/CompNavigation"

  export default {
    name: "Menu",
    components: {ACol, Compnavigation},
    data() {
      return {
        menu: ''
      }
    },
    mounted() {
      this.showMenu()
    },
    methods: {
      showMenu() {
        return axios
          .get(URLS.MENU(this.$route.params.id))
          .then(response => {
            console.log(response.data);
            this.menu = response.data;
            console.log(this.menu, 'menu')
          })
          .catch(e => {
            console.log(e);
          });
      },
    },
  }
</script>

<style scoped>
  #our_menu {
    padding: 0px;
    margin: 0px;
  }

  .menu-page_title h1 {
    font-size: 60px;
    color: #9b2c2c;
    font-weight: 700;
    line-height: 2;
    margin-bottom: 0;
    position: relative;
    text-transform: capitalize;
  }

  .menu-page_title h1::before {
    background: #c0392b;
    width: 70px;
    height: 2px;
    position: absolute;
    content: '';
    top: 90%;
    left: 50%;
    transform: translate(-50%, -50%);
  }

  .menu-page_title h1::after {
    position: absolute;
    content: '';
    background: #fbc531;
    width: 30px;
    height: 2px;
    top: 90%;
    left: 50%;
    transform: translate(-50%, -50%);
  }

  .single_menu {
    margin-top: 20px;
    display: flex;
    align-items: center;
    position: relative;
    margin-bottom: 20px;
    transition: .3s;
  }

  .single_menu:last-child {
    margin-bottom: 30px;
  }

  .single_menu:hover img {
    -webkit-clip-path: polygon(0% 0%, 100% 0, 100% 50%, 100% 100%, 0% 100%);
    clip-path: polygon(0% 0%, 100% 0, 100% 50%, 100% 100%, 0% 100%);

  }

  .single_menu img {
    width: 25%;
    height: 170px;
    -webkit-clip-path: polygon(0% 0%, 75% 0%, 100% 50%, 75% 100%, 0% 100%);
    clip-path: polygon(0% 0%, 75% 0%, 100% 50%, 75% 100%, 0% 100%);
    transition: .3s;
    border: 1px solid #ddd;
    border-radius: 5px;
  }

  .menu_content {
    padding-left: 5%;
    width: 100%;
  }

  .menu_content h4 {
    font-size: 25px;
    font-weight: 700;
    border-bottom: 1px dashed #c0392b;
    line-height: 2;
    text-transform: capitalize;
  }

  .menu_content h4 span {
    font-size: 25px;
    font-weight: 800;
    float: right;
    font-style: italic;
    color: black;
  }

  .menu_content p {
    font-weight: 200;
    font-size: 16px;
    letter-spacing: 1px;
  }

  .menu-name_category {
    font-size: 35px;
    background: #c0392b;
    color: #fff;
    font-weight: 700;
    border: 1px solid #c0392b;
    text-transform: capitalize;
  }

  .container-menu {
    background-size: cover;
    background-position: center;
    height: 100%;
    padding: 0 10px;
  }
</style>
