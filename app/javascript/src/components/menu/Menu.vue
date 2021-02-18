<template>
  <section id="our_menu">
    <!--<Navigation/>-->
    <div class="container-menu pt-0"
         :style="{'background-image':'url(/image/background-menu.jpg)', 'background-size':'cover'}">
      <!--button menu-->
      <div class="menu-header">
        <div class="logo-header">
          <img src="/image/tenHSQ.png" alt="Menu Hoa Sơn Quán mùa Tết" style="height: 100px">
        </div>
        <div class="banner-header">
          <img src="/image/hoaanhdao.png" alt="Menu Hoa Sơn Quán mùa Tết" style="height: 100px">
        </div>
        <div class="filter">
          <a-button-group>
            <a-popover v-model="filterVisible"
                       title="Lựa chọn thực đơn" trigger="click">
              <template slot="content">
                <div
                  class="text-left cursor-pointer ant-popover-inner-content--custom">
                  <div
                    class="category-filter-row d-flex hover:bg-gray-400 py-1"
                    v-for="category in categories"
                    :key="category.id"
                    @click="filterCategory(category.id)"
                  >
                    <div class="category-filter-thumb">
                    </div>
                    <div class="category-filter-item">
                      {{ category.name }}
                    </div>
                  </div>
                </div>
              </template>
              <a-button type="primary" icon="unordered-list" size="large" />
            </a-popover>
            <a-button
              size="large"
              type="primary"
              style="background-color: #233665; color: #ffffffeb"
              v-for="item in display_categories"
              @click="filterCategory(item.id)">
              {{ item.name }}
            </a-button>
            <a-button size="large" type="dashed" @click="resetFilter">
              All
            </a-button>
          </a-button-group>
        </div>
      </div>
      <div class="menu-body">
        <a-row class="w-full md:w-3/6 pr-9">
          <a-col :span="20">
            <a-pagination
              simple
              v-if="total > per_page"
              v-model="current_page" in
              size="large"
              :defaultPageSize="per_page"
              :total="total"
              @change="changePage"
            />
          </a-col>
          <a-col :span="4">
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
          </a-col>
        </a-row>
        <div class="mt-7">
          <show-dish :current_dishes="current_dishes"
                     :ListView="ListView"/>
        </div>
        <a-row>
            <a-pagination
              simple
              v-if="total > per_page"
              v-model="current_page"in
              size="large"
              :defaultPageSize="per_page"
              :total="total"
              @change="changePage"
            />
        </a-row>
      </div>
      <menu-footer />
    </div>
  </section>
</template>

<script>
  import {ApiCaller} from "../../utils/api";
  import {URLS} from "../../utils/url";
  import ACol from "ant-design-vue/es/grid/Col";
  import Navigation from "../../../layouts/partials/Navigation";
  import ShowDish from "./ShowDish"
  import MenuFooter from "./MenuFooter";

  const resetParamsQuery = {
    category_id: ''
  }

  export default {
    name: "Menu",
    components: {MenuFooter, Navigation, ACol, ShowDish},
    data() {
      return {
        menu: '',
        ListView: true,
        MobileView: false,
        current_dishes: [],
        categories: [],
        display_categories: [],
        restaurant: {},
        visible: false,
        filterVisible: false,
        current_page: 1,
        per_page: 20,
        total: 0,
        queryParams: {...resetParamsQuery},
      }
    },
    mounted() {
      this.fetchData();
      this.fetchInfo();
    },
    methods: {
      fetchInfo() {
        return ApiCaller().get(URLS.GUEST_RESTAURANT_INFO(this.$route.params.id))
          .then(response => {
            this.cooking_methods = response.data.cooking_methods
            this.restaurant = response.data.restaurant
            this.categories = response.data.categories
            this.display_categories = response.data.display_categories
            this.main_ingredients = response.data.main_ingredients
          })
          .catch(e => {
            console.log(e);
          });
      },
      fetchData() {
        return ApiCaller().get(URLS.GUEST_DISHES(this.$route.params.id),
          {
            params: Object.assign({},
              {
                page: this.current_page,
                per_page: this.per_page,
                category_id: this.queryParams.category_id
              })
          })
          .then(response => {
            this.current_dishes = response.data.dishes
            this.total = response.data.total
          })
          .catch(e => {
            console.log(e);
          })
      },
      filterCategory(value) {
        this.filterVisible = false
        this.current_page = 1
        this.queryParams.category_id = value
        let self = this
        setTimeout(function () {
          self.fetchData()
        }, 500)
      },
      changePage(value) {
        this.current_page = value
        this.fetchData()
      },
      listView() {
        this.ListView = true
      },
      gridView() {
        this.ListView = false
      },
      resetFilter() {
        this.current_page = 1
        this.queryParams = {...resetParamsQuery}
        this.fetchData()
      },
      hideInfo() {
        this.visible = false;
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
    /*height: 85vh;*/
    background: white;
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
    object-fit: cover;
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

  .category-filter-item {
    padding: 5px 0;
  }

  .category-filter-row {
    border-bottom: 1px solid #e8e8e8;
  }

  .logo-header {
    padding-top: 10px;
    line-height: 70px;
    overflow: hidden;
  }
  .logo-header img {
    max-width: 300px;
    max-height: 60px;
    margin: auto auto;
  }
  .banner-header img {
    position: absolute;
    top: 0;
    right: 0;
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

  .menu-header {
    width: 100%;
    margin: auto;

  }

  @media (min-width: 800px) {
    .menu-header, .menu-body {
      max-width: 800px;
    }

    .menu-page_title h1 {
      font-size: 30px;
    }
  }

</style>
