<template>
  <a-layout-content :style="{ margin: '24px 16px 0' }">
    <div :style="{ padding: '24px', background: '#fff', minHeight: '360px' }">
      <div>
        <div class="my-5">
          <a-select style="width: 300px"
                    show-search
                    option-filter-prop="children"
                    :filter-option="filterOption"
                    placeholder="Select a Restaurant"
                    @change="handleChangeRestaurant"
          >
            <a-select-option v-for="restaurant in restaurants" :value="restaurant.id">
              {{ restaurant.name }}
            </a-select-option>
          </a-select>

          <a-select style="width: 300px"
                    show-search
                    option-filter-prop="children"
                    :filter-option="filterOption"
                    placeholder="Select a Category"
                    @change="handleChangeCategory"
          >
            <a-select-option v-for="category in categories" :value="category.id">
              {{ category.name }}
            </a-select-option>
          </a-select>
        </div>
        <a-button type="primary" class="editable-add-btn"
                  @click="addDish">
          Add
        </a-button>
        <a-button type="primary" class="editable-add-btn"
                  @click="showAllDish">
          All dish
        </a-button>
        <a-modal v-model="visible" :title="titleModal" :footer="null">
          <FormDish
            :rules="rules"
            :editItem="editItem"
            :isEdit="isEdit"
            @updateVisible="updateVisible"
            @updateListAfterUpdated="updateListAfterUpdated"
            @getDataRestaurant="getDataRestaurant"
          />
        </a-modal>
        <a-table bordered :data-source="desserts"
                 :columns="columns"
                 :row-key="(record) => record.id"
        >
          <template slot="image" slot-scope="image">
        <span>
          <a-avatar shape="square" :size="100" :src="image" />
        </span>
          </template>
          <template slot="action" slot-scope="text, record">
            <a-button @click="editDish(record)" :size="'small'"
                      :type="'primary'"
            >
              <a-icon type="edit"/>
            </a-button>
            <a-popconfirm
              title="Delete this Category?"
              ok-text="Delete"
              cancel-text="Cancel"
              @confirm="deleteDish(record)"
            >
              <a-button size="small" type="danger">
                <a-icon type="delete"/>
              </a-button>
            </a-popconfirm>
          </template>
        </a-table>
      </div>
    </div>
  </a-layout-content>
</template>

<script>
  import axios from "axios";
  import {URLS} from "../utils/url"
  import FormDish from "./forms/FormDish"
  const newDish = {
    id: '',
    name: '',
    price:'',
    category_ids:[],
    images_attributes: [],
    images_ids: []
  }
  export default {
    name: "Dishes",
    data() {
      return {
        categories:[],
        restaurants: [],
        rules: {
          name: [
            { required: true,
              message: 'Please input name', trigger: 'blur' },
            { min: 3,
              message: 'Length should be 3',
              trigger: 'blur' },
          ],
          restaurant: [{ required: false, message: 'Please select Restaurant', trigger: 'change' }],

        },
        editItem: {},
        isEdit: false,
        desserts: [],
        visible: false,
        columns: [
          {
            title: 'Name',
            dataIndex: 'name',
          },
          {
            title: 'Price',
            dataIndex: 'price',
          },
          {
            title: 'Image',
            dataIndex: 'images_attributes[0].url',
            scopedSlots: { customRender: "image" },
          },
          {
            title: 'Action',
            dataIndex: 'action',
            scopedSlots: {customRender: 'action'},
          },
        ],
      };
    },
    components:{
      FormDish,
    },
    watch: {},
    computed: {
      titleModal() {
        return this.isEdit ? 'Edit Dish' : 'Create Dish'
      }
    },
    mounted() {
      this.initialize()
      this.getDataRestaurant()
    },
    methods: {
      initialize() {
        return axios
          .get(URLS.DISHES())
          .then(response => {
            this.desserts = response.data;
          })
          .catch(e => {
          });
      },
      addDish(){
        this.visible = true;
        this.isEdit = false
        this.editItem = Object.assign({}, newDish);
      },
      editDish(record) {
        this.isEdit = true;
        this.visible = true;
        this.editItem = Object.assign({}, record);
      },
      updateVisible(value) {
        this.visible = value;
      },
      deleteDish(item) {
        axios
          .delete(URLS.DISH(item.id))
          .then((res) => {
            this.$message.success('Deleted success');
            this.initialize()
          })
          .catch(error => {
          });
      },
      updateListAfterUpdated() {
        this.initialize()
      },
      getDataRestaurant(){
        return axios
          .get(URLS.RESTAURANTS())
          .then(response => {
            this.restaurants = response.data;
          })
          .catch(e => {
          });
      },
      getDataCategory(value){
        return axios
          .get(URLS.RESTAURANTSEARCH(value))
          .then(response => {
            this.categories = response.data;
          })
          .catch(e => {
          });
      },
      searchDish(value){
        return axios
          .get(URLS.CATEGORYSEARCH(value))
          .then(response => {
            this.desserts = response.data;
          })
          .catch(e => {
          });
      },
      filterOption(input, option) {
        return (
          option.componentOptions.children[0].text.toLowerCase().indexOf(input.toLowerCase()) >= 0
        );
      },
      handleChangeRestaurant(value) {
        this.getDataCategory(value)
      },
      handleChangeCategory(value) {
        this.searchDish(value)
      },
      showAllDish() {
        this.initialize()
      },
    }
  }
</script>

<style scoped>
  .img-dashboard {
    height: 32px;
  }

  #components-layout-demo-responsive .logo {
    height: 32px;
    background: rgba(255, 255, 255, 0.2);
    margin: 16px;
  }

  .ant-input-search {
    margin-top: 20px;
    margin-left: 15px;
  }

  .ant-input-group-wrapper {
    width: 90% !important;
  }

  .editable-cell {
    position: relative;
  }

  .editable-cell-input-wrapper,
  .editable-cell-text-wrapper {
    padding-right: 24px;
  }

  .editable-cell-text-wrapper {
    padding: 5px 24px 5px 5px;
  }

  .editable-cell-icon,
  .editable-cell-icon-check {
    position: absolute;
    right: 0;
    width: 20px;
    cursor: pointer;
  }

  .editable-cell-icon {
    line-height: 18px;
    display: none;
  }

  .editable-cell-icon-check {
    line-height: 28px;
  }

  .editable-cell:hover .editable-cell-icon {
    display: inline-block;
  }

  .editable-cell-icon:hover,
  .editable-cell-icon-check:hover {
    color: #108ee9;
  }

  .editable-add-btn {
    margin-bottom: 8px;
  }

  .ant-table-thead tr th {
    text-align: center !important;
  }
</style>
