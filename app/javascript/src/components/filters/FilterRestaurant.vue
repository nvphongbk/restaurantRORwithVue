<template>
  <div class="my-5">
    <a-select style="width: 300px"
              show-search
              option-filter-prop="children"
              :filter-option="filterOption"
              v-model="editItem.restaurant_id"
              placeholder="Select a Restaurant"
              @change="handleChange"
              default-value="undefined"
    >
      <a-select-option v-for="restaurant in restaurants" :value="restaurant.id">
        {{ restaurant.name }}
      </a-select-option>
    </a-select>
  </div>
</template>

<script>
  export default {
    name: "FilterRestaurant",
    props: {
      editItem: {
        type: Object
      },
      restaurants:{
        type: Array
      },
    },
    data() {
      return {
        restaurant_id: undefined
      }
    },
    methods: {
      filterOption(input, option) {
        return (
          option.componentOptions.children[0].text.toLowerCase().indexOf(input.toLowerCase()) >= 0
        );
      },
      handleChange(value) {
        this.$emit('searchCategory',value)
      },
    }
  }
</script>

<style scoped>

</style>
