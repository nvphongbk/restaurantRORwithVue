<template>
  <div v-if="ListView" class="menu-view list-view">
    <div class="single_menu w-full" v-for='dish in current_dishes'>
      <img v-if="!dish.images_attributes || dish.images_attributes.length === 0" class="menu-dish_img"
           src="/image/no-image.png">
      <img v-else class="menu-dish_img" :src="dish.images_attributes[0].url">
      <div class="menu_content">
        <h4>{{dish.name}} <span>{{dish.price}} Đ</span></h4>
      </div>
    </div>
  </div>
  <div v-else class="menu-view grid-view">
    <div class="single_menu w-1/2 flex-wrap" v-for='dish in current_dishes'>
      <div class="menu-dish_img--grid">
        <img v-if="!dish.images_attributes || dish.images_attributes.length === 0" class="menu-dish_img"
             src="/image/no-image.png">
        <img v-else class="menu-dish_img" :src="dish.images_attributes[0].url">
      </div>
      <div class="menu_content">
        <h4>{{dish.name}} <span>{{dish.price}} Đ</span></h4>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    name: "ShowDish",
    props: {
      current_dishes: {
        type: Array
      },
      ListView: {
        type: Boolean
      },
    }
  }
</script>

<style scoped>

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

  .menu-view {
    height: 73vh;
    overflow: scroll;
  }

  .grid-view {
    display: flex;
    flex-wrap: wrap;
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
    width: 100%;
    height: inherit;
  }

  @media (min-width: 800px) {

    .menu-dish_img {
      width: 30px;
      height: 30px;
    }

    .menu-view {
      height: 67vh;
    }

  }

</style>
