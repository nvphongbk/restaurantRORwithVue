<template>
  <div>
    <!--<div v-for='category in menu.categories' :key="category.id">-->
      <!--<div class="text-center menu-name_category">{{category.name}}</div>-->
      <div class="menu-view">
        <div class="single_menu w-full" v-for='dish in current_dishes'>
          <img v-if="!dish.images_attributes || dish.images_attributes.length === 0" class="menu-dish_img"
               src="/image/no-image.png">
          <img v-else class="menu-dish_img" :src="dish.images_attributes[0].url">
          <div class="menu_content">
            <h4>{{dish.name}} <span>{{dish.price}} Đ</span></h4>
          </div>
        </div>
      </div>
    <!--</div>-->
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

</style>
