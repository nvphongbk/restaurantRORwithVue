<template>
  <a-layout-content :style="{ margin: '24px 16px 0' }">
    <div :style="{ padding: '24px', background: '#fff', minHeight: '360px' }">
      <div>
        <div class="my-5">
          <a-select style="width: 300px"
                    show-search
                    option-filter-prop="children"
                    :filter-option="filterOption"
                    v-model="editItem.restaurant_id"
                    placeholder="Select a Restaurant"
                    @change="handleChange"
          >
            <a-select-option v-for="restaurant in restaurants" :value="restaurant.id">
              {{ restaurant.name }}
            </a-select-option>
          </a-select>
        </div>
        <a-button type="primary" class="editable-add-btn"
                  @click="addDish">
          Add
        </a-button>
        <a-modal v-model="visible" :title="titleModal" :footer="null">
          <FormDish
            ref="child"
            :restaurants="restaurants"
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
          <a-avatar shape="square" :size="100" :src="image.url" />
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
  import FormDish from "./forms/FormDish"
  const newDish = {
    id: '',
    name: '',
    price:'',
    image:'',
  }
  export default {
    name: "Dishes",
    data() {
      return {
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
        editItem: {
        },
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
            dataIndex: 'image',
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
          .get("http://localhost:3000/api/v1/dishes/")
          .then(response => {
            console.log(response.data,"data");
            this.desserts = response.data;
          })
          .catch(e => {
            console.log(e);
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
          .delete(`http://localhost:3000/api/v1/dishes/${item.id}`)
          .then((res) => {
            console.log(res);
            this.$message.success('Deleted success');
            this.initialize()
          })
          .catch(error => {
            console.log(error);
          });
      },
      updateListAfterUpdated() {
        this.initialize()
      },
      getDataRestaurant(){
        return axios
          .get("http://localhost:3000/api/v1/restaurants/")
          .then(response => {
            console.log(response.data);
            this.restaurants = response.data;
          })
          .catch(e => {
            console.log(e);
          });
      },
      filterOption(input, option) {
        return (
          option.componentOptions.children[0].text.toLowerCase().indexOf(input.toLowerCase()) >= 0
        );
      },
      handleChange(value) {
        console.log(`id: ${value}`);
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
