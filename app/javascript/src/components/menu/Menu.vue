<template>
  <section id="our_menu">
    <!--<Navigation/>-->
    <div class="container-menu pt-0"
         :style="{'background-image':'url(/uploads/menu/background-menu.jpg)', 'background-size':'cover'}">

      <!--button menu-->
      <a-row class="menu-header text-center">
        <a-col :span="24">
          <div>
            <a-popover v-model="visible"
                       :title=menu.name trigger="click">
              <template slot="content">
                <div class="text-left">
                  <p>Địa chỉ: {{menu.address}}</p>
                  <p>Pass Wifi: {{menu.pass_wifi}}</p>
                  <p>Số điện thoại: {{menu.phone}}</p>
                </div>
                <div class="text-right">
                  <a-button class="mt-3" @click="hideInfo" type="primary">
                    ok
                  </a-button>
                </div>
              </template>
              <a class="btn-filter">Thông tin</a>
            </a-popover>
            <a @click="filterCookingMethod" class="btn-filter">Cách nấu</a>
            <a @click="filterMainIngredient" class="btn-filter">Thành phần</a>
            <a @click="filterCategory" class="btn-filter">Danh mục</a>
            <a @click="resetFilter" class="btn-reset bg-red-500 hover:bg-red-700">Reset</a>
          </div>
        </a-col>
      </a-row>

      <!--cooking method-->
      <div v-if="filter_cooking_method" class="bg-yellow-200 text-center w-1/2 m-auto my-3 position: relative">
        <a @click="closeFilterCookingMethod" class="close"></a>
        <a-checkbox-group @change="onChangefilter" v-model="checkedCookingMethod">
          <a-row>
            <a-col class="pt-3 mt-4" :span="24">
              <a-checkbox v-for="(cookingMethod, index) in menu.cooking_methods" :value="cookingMethod.id"
                          :key="index" name="cooking_methods[]">
                <div>
                  {{ cookingMethod.name }}
                </div>
              </a-checkbox>
            </a-col>
          </a-row>

        </a-checkbox-group>
      </div>

      <!--main ingredient-->
      <div v-if="filter_main_ingredient" class="bg-yellow-200 text-center w-1/2 m-auto my-3 position: relative">
        <a href="#" @click="closeFilterMainIngredient" class="close"></a>
        <a-checkbox-group @change="onChangefilter" v-model="checkedMainIngredient">
          <a-row>
            <a-col class="pt-3 mt-4" :span="24">
              <a-checkbox :span="24" v-for="(mainIngredient, index) in menu.main_ingredients"
                          :value="mainIngredient.id"
                          :key="index">
                <div>
                  {{ mainIngredient.name }}
                </div>
              </a-checkbox>
            </a-col>
          </a-row>
        </a-checkbox-group>
      </div>

      <!--category-->
      <div v-if="show_filter_category" class="bg-yellow-200 text-center w-1/2 m-auto my-3 position: relative">
        <a href="#" @click="closeFilterCategory" class="close"></a>
        <a-checkbox-group @change="onChangefilter" v-model="checkedCategory">
          <a-row>
            <a-col class="pt-3 mt-4" :span="24">
              <a-checkbox :span="24" v-for="(category, index) in menu.categories" :value="category.id"
                          :key="index">
                <div>
                  {{ category.name }}
                </div>
              </a-checkbox>
            </a-col>
          </a-row>
        </a-checkbox-group>
      </div>

      <!--body menu-->
      <div class="menu-body">
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
        <show-dish :current_dishes="current_dishes"
                   :ListView="ListView"/>
      </div>
    </div>
  </section>
</template>

<script>
  import {ApiCaller} from "../../utils/api";
  import {URLS} from "../../utils/url";
  import ACol from "ant-design-vue/es/grid/Col";
  import Navigation from "../../../layouts/partials/Navigation";
  import ShowDish from "./ShowDish"

  export default {
    name: "Menu",
    components: {Navigation, ACol, ShowDish},
    data() {
      return {
        menu: '',
        ListView: true,
        MobileView: false,
        current_dishes: [],
        checkedCookingMethod: [],
        filter_cooking_method: false,
        filter_main_ingredient: false,
        checkedMainIngredient: [],
        show_filter_category: false,
        checkedCategory: [],
        visible: false,
      }
    },
    mounted() {
      this.fetchData();
    },
    computed: {
      allDishes: function () {
        return this.menu.categories.map(e => e.dishes).flat()
      },
    },
    methods: {
      fetchData() {
        return ApiCaller().get(URLS.MENU(this.$route.params.id))
          .then(response => {
            this.menu = response.data.restaurant;
            this.current_dishes = this.allDishes
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
      filterCookingMethod() {
        this.filter_cooking_method = !this.filter_cooking_method
      },
      filterMainIngredient() {
        this.filter_main_ingredient = !this.filter_main_ingredient
      },
      filterCategory() {
        this.show_filter_category = !this.show_filter_category
      },

      async onChangefilter(checkedValues) {
        let restaurant_id = this.$route.params.id
        let cooking_method_ids = this.checkedCookingMethod
        let main_ingredient_ids = this.checkedMainIngredient
        let category_ids = this.checkedCategory

        let response = await ApiCaller().post(URLS.DISHES_FILTER(), {
          restaurant_id,
          cooking_method_ids,
          main_ingredient_ids,
          category_ids
        })
        this.current_dishes = response.data
      },
      resetFilter() {
        this.checkedCategory = []
        this.checkedCookingMethod = []
        this.checkedMainIngredient = []
        this.fetchData()
      },
      hideInfo() {
        this.visible = false;
      },
      closeFilterCookingMethod() {
        this.filter_cooking_method = false
      },
      closeFilterMainIngredient() {
        this.filter_main_ingredient = false
      },
      closeFilterCategory() {
        this.show_filter_category = false
      },

    },
  }
</script>

<style scoped>
  #our_menu {
    padding: 0px;
    margin: 0px;
  }

  .menu-header {
    line-height: 50px;
  }

  .menu-page_title h1 {
    font-size: 18px;
    color: #ffff;
    font-weight: 700;
    line-height: 2;
    margin-bottom: 0;
    position: relative;
    text-transform: capitalize;
    margin: 0 auto;
    width: 50%;
    padding-top: 20px;
  }

  .menu-page_title h1::before {
    background: #c0392b;
    width: 70px;
    height: 2px;
    position: absolute;
    content: '';
    top: 100%;
    left: 50%;
    transform: translate(-50%, -50%);
  }

  .menu-page_title h1::after {
    position: absolute;
    content: '';
    background: #fbc531;
    width: 30px;
    height: 2px;
    top: 100%;
    left: 50%;
    transform: translate(-50%, -50%);
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
    font-size: 14px;
    font-weight: 500;
    color: #000000;
  }

  .container-menu {
    background-size: cover;
    background-position: center;
    min-height: 100vh;
    padding: 0 10px;
    padding-bottom: 20px;
  }

  .menu-body {
    width: 100%;
    margin: 0 auto;
    height: 90vh;
    background: white;
    overflow: scroll;
    padding: 10px;
    border-radius: 20px;
  }

  .btn-view-menu {
    margin-bottom: 5px;
  }

  .menu-btn {
    display: flex;
    justify-content: flex-end;
  }

  .menu-btn a {
    margin-right: 5px;
  }

  .menu-btn a:hover {
    color: #1890ff;
  }

  .menu-dish_img--grid img {
    width: 100%;
    height: inherit;
  }

  .btn-filter {
    padding: 8px;
    border-radius: 6px;
    background: #1890ff;
    color: #fff
  }

  .btn-filter:hover {
    background-color: #439cff;
  }

  .btn-reset {
    padding: 8px;
    border-radius: 6px;
    color: #fff
  }

  .close {
    position: absolute;
    right: 10px;
    top: 5px;
    width: 20px;
    height: 32px;
    opacity: 0.3;
    z-index: 100
  }

  .close:hover {
    opacity: 1;
  }

  .close:before, .close:after {
    position: absolute;
    left: 15px;
    content: ' ';
    height: 21px;
    width: 2px;
    background-color: #333;
  }

  .close:before {
    transform: rotate(45deg);
  }

  .close:after {
    transform: rotate(-45deg);
  }

  @media (min-width: 800px) {
    .menu-body {
      width: 50%;
    }

    .menu-page_title h1 {
      font-size: 30px;
    }
  }

</style>
