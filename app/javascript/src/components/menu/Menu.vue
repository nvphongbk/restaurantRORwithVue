<template>
  <section id="our_menu">
    <Navigation/>
    <div class="container-menu pt-0"
         :style="{'background-image':'url(/uploads/menu/background-menu.jpg)'}">
      <a-row>
        <a-col :span="24">
          <div class="menu-page_title text-center mb-4">
            <h1>{{menu.name}}</h1>
            <p class="menu-page--wifi">Pass Wifi: {{menu.pass_wifi}}</p>
            <div class="menu-single_line"></div>
          </div>
        </a-col>
      </a-row>
      <a-tabs type="card" class="menu-body">
        <a-tab-pane key="all" tab="All">
          <div class="menu-btn">
            <a @click="listView">
              <svg viewBox="64 64 896 896" data-icon="unordered-list"
                   width="25px" height="25px" fill="currentColor"
                   aria-hidden="true" focusable="false"
                   class="inline-block btn-view-menu">
                <path
                  d="M912 192H328c-4.4 0-8 3.6-8 8v56c0 4.4 3.6 8 8 8h584c4.4 0 8-3.6 8-8v-56c0-4.4-3.6-8-8-8zm0 284H328c-4.4 0-8 3.6-8 8v56c0 4.4 3.6 8 8 8h584c4.4 0 8-3.6 8-8v-56c0-4.4-3.6-8-8-8zm0 284H328c-4.4 0-8 3.6-8 8v56c0 4.4 3.6 8 8 8h584c4.4 0 8-3.6 8-8v-56c0-4.4-3.6-8-8-8zM104 228a56 56 0 1 0 112 0 56 56 0 1 0-112 0zm0 284a56 56 0 1 0 112 0 56 56 0 1 0-112 0zm0 284a56 56 0 1 0 112 0 56 56 0 1 0-112 0z"></path>
              </svg>
            </a>
            <a @click="gridView">
              <svg viewBox="64 64 896 896" data-icon="table" width="25px"
                   height="25px" fill="currentColor" aria-hidden="true"
                   focusable="false" class="inline-block btn-view-menu">
                <path
                  d="M928 160H96c-17.7 0-32 14.3-32 32v640c0 17.7 14.3 32 32 32h832c17.7 0 32-14.3 32-32V192c0-17.7-14.3-32-32-32zm-40 208H676V232h212v136zm0 224H676V432h212v160zM412 432h200v160H412V432zm200-64H412V232h200v136zm-476 64h212v160H136V432zm0-200h212v136H136V232zm0 424h212v136H136V656zm276 0h200v136H412V656zm476 136H676V656h212v136z"></path>
              </svg>
            </a>
          </div>
          <div v-for='category in menu.categories' :key="category.id">
            <div class="text-center menu-name_category">{{category.name}}</div>
            <div v-if="ListView" class="menu-view">
              <div class="single_menu w-full" v-for='dish in category.dishes'>
                <img class="menu-dish_img" :src="dish.images_attributes[0].url">
                <div class="menu_content">
                  <h4>{{dish.name}} <span>${{dish.price}}</span></h4>
                </div>
              </div>
            </div>
            <div v-else class="menu-view">
              <div class="single_menu w-1/2 flex-wrap" v-for='dish in category.dishes'>
                <img class="menu-dish_img--grid" :src="dish.images_attributes[0].url">
                <div class="menu_content">
                  <h4>{{dish.name}} <span>${{dish.price}}</span></h4>
                </div>
              </div>
            </div>
          </div>
        </a-tab-pane>
        <template v-for='category in menu.categories'>
          <a-tab-pane :key="category.id" :tab="category.name">
            <div class="menu-btn">
              <a @click="listView">
                <svg viewBox="64 64 896 896" data-icon="unordered-list"
                     width="25px" height="25px" fill="currentColor"
                     aria-hidden="true" focusable="false"
                     class="inline-block btn-view-menu">
                  <path
                    d="M912 192H328c-4.4 0-8 3.6-8 8v56c0 4.4 3.6 8 8 8h584c4.4 0 8-3.6 8-8v-56c0-4.4-3.6-8-8-8zm0 284H328c-4.4 0-8 3.6-8 8v56c0 4.4 3.6 8 8 8h584c4.4 0 8-3.6 8-8v-56c0-4.4-3.6-8-8-8zm0 284H328c-4.4 0-8 3.6-8 8v56c0 4.4 3.6 8 8 8h584c4.4 0 8-3.6 8-8v-56c0-4.4-3.6-8-8-8zM104 228a56 56 0 1 0 112 0 56 56 0 1 0-112 0zm0 284a56 56 0 1 0 112 0 56 56 0 1 0-112 0zm0 284a56 56 0 1 0 112 0 56 56 0 1 0-112 0z"></path>
                </svg>
              </a>
              <a @click="gridView">
                <svg viewBox="64 64 896 896" data-icon="table" width="25px"
                     height="25px" fill="currentColor" aria-hidden="true"
                     focusable="false" class="inline-block btn-view-menu">
                  <path
                    d="M928 160H96c-17.7 0-32 14.3-32 32v640c0 17.7 14.3 32 32 32h832c17.7 0 32-14.3 32-32V192c0-17.7-14.3-32-32-32zm-40 208H676V232h212v136zm0 224H676V432h212v160zM412 432h200v160H412V432zm200-64H412V232h200v136zm-476 64h212v160H136V432zm0-200h212v136H136V232zm0 424h212v136H136V656zm276 0h200v136H412V656zm476 136H676V656h212v136z"></path>
                </svg>
              </a>
            </div>
            <div class="menu-view" v-if="ListView">
              <div class="single_menu w-full" v-for='dish in category.dishes'>
                <img class="menu-dish_img" :src="dish.images_attributes[0].url">
                <div class="menu_content">
                  <h4>{{dish.name}} <span>${{dish.price}}</span></h4>
                </div>
              </div>
            </div>
            <div class="menu-view" v-else>
              <div class="single_menu w-1/2 flex-wrap" v-for='dish in category.dishes'>
                <img class="menu-dish_img--grid" :src="dish.images_attributes[0].url">
                <div class="menu_content">
                  <h4>{{dish.name}} <span>${{dish.price}}</span></h4>
                </div>
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
  import {URLS} from "../../utils/url";
  import ACol from "ant-design-vue/es/grid/Col";
  import Navigation from "../../../layouts/partials/Navigation";

  export default {
    name: "Menu",
    components: {Navigation, ACol},
    data() {
      return {
        menu: '',
        ListView: true,
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
      listView() {
        this.ListView = true
      },
      gridView() {
        this.ListView = false
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
    font-size: 45px;
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
    margin: 5px 0;
    display: flex;
    align-items: center;
    position: relative;
    transition: .3s;
    padding: 0 10px;
  }

  .menu-dish_img {
    width: 30px;
    height: 30px;
    border: 1px solid #ddd;
    border-radius: 5px;
  }

  .menu_content {
    padding-left: 7px;
    width: 100%;
  }

  .menu_content h4 {
    font-size: 16px;
    font-weight: 500;
    border-bottom: 1px dashed #c0392b;
    line-height: 2;
    text-transform: capitalize;
  }

  .menu_content h4 span {
    font-size: 16px;
    font-weight: 500;
    float: right;
    font-style: italic;
    color: black;
  }

  .menu_content p {
    font-weight: 200;
    font-size: 16px;
    letter-spacing: 1px;
  }
  .menu-page--wifi {
    font-size: 18px;
    font-weight: 500;
    color: #fde3b2;
  }

  .menu-name_category {
    font-size: 20px;
    background: #c0392b;
    color: #fff;
    font-weight: 700;
    border: 1px solid #c0392b;
    text-transform: capitalize;
  }

  .container-menu {
    background-size: cover;
    background-position: center;
    height: 100vh;
    padding: 0 10px;
  }

  .menu-body {
    width: 50%;
    margin: 0 auto;
    height: 75vh;
    background: white;
    overflow: scroll;
    padding: 10px;
    border-radius: 20px;
  }

  .menu-view {
    display: flex;
    flex-wrap: wrap;
  }

  .btn-view-menu {
    margin-bottom: 5px;
  }
  .menu-btn{
    display: flex;
    justify-content: flex-end;
  }

  .menu-btn a {
    margin-right: 5px;
  }

  .menu-btn a:hover {
    color: #1890ff;
  }

  .menu-dish_img--grid{
    width: 100%;
    height: 200px;
  }
  #our_menu .ant-tabs-bar{
    position: fixed;
  }
</style>
