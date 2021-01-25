<template>
  <section id="our_menu">
    <Navigation/>
    <div class="container-menu pt-0"
         :style="{'background-image':'url(/uploads/menu/background-menu.jpg)'}">

      <!--button menu-->
      <a-row class="menu-header text-center">
        <a-col :span="24">
          <div>
            <a-button @click="showInfoRestaurant" type="primary">
              Thông tin
            </a-button>
            <a-button @click="filterCookingMethod" type="primary">
              Cách nấu
            </a-button>
            <a-button @click="filterMainIngredient" type="primary">
              Thành phần
            </a-button>
            <a-button @click="filterCategory" type="primary">
              Danh mục
            </a-button>
          </div>
        </a-col>
      </a-row>

      <!--info restaurant-->
      <div v-if="info_restaurant">
        <a-row class="menu-header">
          <a-col :span="24">
            <div class="menu-page_title text-center">
              <h1>{{menu.name}}</h1>
              <p class="menu-page--wifi">Pass Wifi: {{menu.pass_wifi}}</p>
              <div class="menu-single_line"></div>
            </div>
          </a-col>
        </a-row>
      </div>

      <!--cooking method-->
      <div v-if="filter_cooking_method" class="bg-yellow-200 text-center w-1/2 m-auto">
        <a-checkbox-group @change="onChangeCookingMethod" v-model="checkedCookingMethod">
          <a-checkbox :span="24" v-for="(cookingMethod, index) in menu.cooking_methods" :value="cookingMethod.id"
                      :key="index" name="cooking_methods[]">
            <div>
              {{ cookingMethod.name }}
            </div>
          </a-checkbox>
        </a-checkbox-group>
      </div>

      <!--main ingredient-->
      <div v-if="filter_main_ingredient" class="bg-yellow-200 text-center w-1/2 m-auto">
        <a-checkbox-group @change="onChangeMainIngredient" v-model="checkedMainIngredient">
          <a-checkbox :span="24" v-for="(mainIngredient, index) in menu.main_ingredients" :value="mainIngredient.id"
                      :key="index">
            <div>
              {{ mainIngredient.name }}
            </div>
          </a-checkbox>
        </a-checkbox-group>
      </div>

      <!--category-->
      <div v-if="show_filter_category" class="bg-yellow-200 text-center w-1/2 m-auto">
        <a-checkbox-group @change="onChangeCategory" v-model="checkedCategory">
          <a-checkbox :span="24" v-for="(category, index) in menu.categories" :value="category.id"
                      :key="index">
            <div>
              {{ category.name }}
            </div>
          </a-checkbox>
        </a-checkbox-group>
      </div>

      <!--body menu-->
      <div class="menu-body">
        <a-row>
          <a-col span="24">
            <div>
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
                         :ListView="ListView"
              />
            </div>
          </a-col>
        </a-row>
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
        listCategories: [],
        info_restaurant: false,
        checkedCookingMethod: [],
        filter_cooking_method: false,
        filter_main_ingredient: false,
        checkedMainIngredient: [],
        show_filter_category: false,
        checkedCategory: []
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
            this.listCategories = [{id: 0, name: 'All'}].concat(this.menu.categories)
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
      showInfoRestaurant() {
        this.info_restaurant = !this.info_restaurant
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
      onChangeCookingMethod(checkedValues) {

      },
      onChangeMainIngredient(checkedValues) {
      },
      async onChangeCategory(checkedValues) {
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
      }


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

  .single_menu {
    margin: 5px 0;
    display: flex;
    align-items: center;
    position: relative;
    transition: .3s;
    padding: 0 10px;
  }

  .menu-dish_img {
    width: 60px;
    height: 60px;
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
    font-size: 14px;
    font-weight: 500;
    color: #ffff;
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
    width: 100%;
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

  .menu-dish_img--grid {
    margin: 0 auto;
    width: 200px;
    height: 200px;
  }

  .menu-dish_img--grid img {
    height: inherit;
  }

  #our_menu .ant-tabs-bar {
    position: fixed;
  }

  @media (min-width: 800px) {
    .menu-body {
      width: 50%;
    }

    .menu-dish_img {
      width: 30px;
      height: 30px;
    }

    .menu-page_title h1 {
      font-size: 30px;
    }
  }

</style>
