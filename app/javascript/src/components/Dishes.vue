<template>
  <div id="dish">
    <div class="dish-search">
        <a-select  style="width: 120px" @change="handleRestaurantChange" placeholder="Select a Restaurant">
          <a-select-option v-for="restaurant in restaurantData" :key="restaurant">
            {{ restaurant }}
          </a-select-option>
        </a-select>
        <a-select  v-model="secondCategory" style="width: 120px" placeholder="Select a Category">
          <a-select-option v-for="category in categories" :key="category">
            {{ category }}
          </a-select-option>
        </a-select>
    </div>

    <a-layout-content :style="{ margin: '24px 16px 0' }">
      <div :style="{ padding: '24px', background: '#fff', minHeight: '360px' }">
        <!--data restaurant-->
        <div>
          <a-button class="editable-add-btn" type="primary" @click="showModal">
            Add
          </a-button>
          <a-modal v-model="visible" title="Create New Dish" @ok="handleOk" okText="Save">
            <a-form :form="form" @submit="handleSubmit">
              <a-form-item label="Name Dish">
                <a-input
                />
              </a-form-item>
              <a-form-item>
                <a-select mode="tags" style="width: 100%"
                          placeholder="Select Category"
                          @change="handleChange">
                  <a-select-option v-for="i in 25"
                                   :key="(i + 9).toString(36) + i">
                    {{ (i + 9).toString(36) + i }}
                  </a-select-option>
                </a-select>
              </a-form-item>

              <a-form-item>
                <a-button type="primary" html-type="submit">
                  Submit
                </a-button>
              </a-form-item>
            </a-form>
          </a-modal>
          <a-table bordered :data-source="dataSource" :columns="columns">
            <template slot="name" slot-scope="text, record">
            </template>
            <template slot="operation" slot-scope="text, record">
                <a class="dashboard-action m-3 hover:text-blue-700" href="#">Edit</a>
                <a class="dashboard-action m-3 hover:text-blue-700" href="#">Delete</a>
              </a-popconfirm>
            </template>
          </a-table>
        </div>
      </div>
    </a-layout-content>

  </div>
</template>

<script>
  const restaurantData = ['Res1', 'Res2'];
  const categoryData = {
    Res1: ['sang', 'trua', 'chieu'],
    Res2: ['fish', 'pig', 'chicken'],
  };
  export default {
    name: "Dishes",
    data() {
      return {
        formLayout: 'horizontal',
        form: this.$form.createForm(this, { name: 'coordinated' }),
        visible: false,
        restaurantData,
        categoryData,
        categories: categoryData[restaurantData[0]],
        secondCategory: categoryData[restaurantData[0]][0],
        dataSource: [
          {
            key: '0',
            name: 'Edward King 0',
            price: '10$'
          },
          {
            key: '1',
            name: 'Edward King 1',
            price: '12$'
          },
          {
            key: '2',
            name: 'Edward King 3',
            price: '14$'
          },
        ],
        count: 2,
        columns: [
          {
            title: 'Name',
            dataIndex: 'name',

          },
          {
            title: 'Price',
            dataIndex: 'price'
          },
          {
            title: 'Image',
            dataIndex: 'image'
          },
          {
            title: 'Action',
            dataIndex: 'operation',
            scopedSlots: { customRender: 'operation' },
          },
        ],
      };
    },
    methods: {
      handleRestaurantChange(value) {
        this.categories = categoryData[value];
        this.secondCategory = categoryData[value][0];
      },
      handleSubmit(e) {
        e.preventDefault();
        this.form.validateFields((err, values) => {
          if (!err) {
            console.log('Received values of form: ', values);
          }
        });
      },
      handleChange(value) {
        console.log(`selected ${value}`);
      },
      showModal() {
        this.visible = true;
      },
      handleOk(e) {
        console.log(e);
        this.visible = false;
      },
    }
  }
</script>

<style scoped>
  #dish .dish-search .ant-select{
    margin: 20px;
    width: 200px !important;
  }
</style>
