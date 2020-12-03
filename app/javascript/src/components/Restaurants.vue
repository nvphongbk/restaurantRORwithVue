<template>
  <a-layout-content :style="{ margin: '24px 16px 0' }">
    <div :style="{ padding: '24px', background: '#fff', minHeight: '360px' }">
      <!--data restaurant-->
      <div>
        <a-button type="primary" class="editable-add-btn"
                  @click="showModal">
          Add
        </a-button>
        <a-modal v-model="visible" :title="titleForm" @ok="handleSubmit"
                 okText="Save">
          <a-form-model :rules="rules" ref="ruleForm"
                        :model="editItem"
                        :label-col="{ span: 5 }"
                        :wrapper-col="{ span: 12 }">
            <a-form-model-item ref="name" label="Name" prop="name">
              <a-input
                v-model="editItem.name" />
            </a-form-model-item>
            <a-form-model-item label="Address" ref="address" prop="address">
              <a-input v-model="editItem.address"/>
            </a-form-model-item>
          </a-form-model>
        </a-modal>
        <a-table bordered :data-source="desserts" :columns="columns"
                 :row-key="(record) => record.id"
        >
          <template slot="action" slot-scope="text, record">
            <a-button @click="editRestaunrant(record)" :size="'small'"
                      :type="'primary'"
            >
              <a-icon type="edit"/>
            </a-button>
            <a-popconfirm
              title="Bạn muốn xoá cửa hàng này?"
              ok-text="Xác nhận"
              cancel-text="Huỷ"
              @confirm="deleteRestaurant(record)"
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

  export default {
    name: "Restaurants",
    data() {
      return {
        rules: {
          name: [
            { required: true,
              message: 'Please input name', trigger: 'blur' },
            { min: 3,
              message: 'Length should be 3',
              trigger: 'blur' },
          ],
          address: [
            {
              required: true,
              message: 'Please input address',
              trigger: 'blur'
            },
            {
              min: 3,
              message: 'Length should be 3',
              trigger: 'blur'
            },
          ],
        },
        editItem: {
          name: "",
          address: ""
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
            title: 'Date Create',
            dataIndex: 'created_at',
          },
          {
            title: 'Address',
            dataIndex: 'address',
          },
          {
            title: 'Action',
            dataIndex: 'action',
            scopedSlots: {customRender: 'action'},
          },
        ],
      };
    },
    mounted() {
      this.initialize()
    },
    computed: {
      titleForm() {
        return this.isEdit ? 'Edit Restaurant' : 'Create Restaurant'
      }
    },
    methods: {
      initialize() {
        return axios
          .get("http://localhost:3000/api/v1/restaurants/")
          .then(response => {
            console.log(response.data);
            this.desserts = response.data;
          })
          .catch(e => {
            console.log(e);
          });
      },
      create(item) {
        this.isEdit = false
        axios
          .post("http://localhost:3000/api/v1/restaurants/", {
            restaurant: item
          })
          .then(response => {
            console.log(response);
            console.log("Created!");
            this.$message.success('Created success');
            this.initialize();

          })
          .catch(error => {
            console.log(error);
          });
      },
      editRestaunrant(item) {
        this.isEdit = true
        this.visible = true
        this.editItem = item
      },
      deleteRestaurant(item) {
        axios
          .delete(`http://localhost:3000/api/v1/restaurants/${item.id}`)
          .then((res) => {
            console.log(res)
            this.$message.success('Deleted success');
            this.initialize()
          })
          .catch(error => {
            console.log(error);
          });
      },
      handleSubmit(e) {
        this.$refs.ruleForm.validate((valid) => {
          if (valid) {
            let valuesSave = Object.assign(this.editItem, {user_id: 1})
            if (this.isEdit) {
              let idItem = this.editItem.id
              axios
                .put(`http://localhost:3000/api/v1/restaurants/${idItem}`, {
                  restaurant: valuesSave
                })
                .then(response => {
                  console.log(response);
                  console.log("Updated!");
                  this.$message.success('Updateed success');
                  this.initialize();
                })
                .catch(error => {
                  console.log(error);
                });
            } else {
              this.create(valuesSave)
            }
          } else {
            return false;
          }
        });
        this.visible = false;
      },
      showModal() {
        this.visible = true
        this.editItem.address = ""
        this.editItem.name = ""
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
