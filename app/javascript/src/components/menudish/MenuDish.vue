<template>
  <a-layout-content :style="{ margin: '0px 16px 0' }">
    <div :style="{ background: '#fff', minHeight: '360px' }">
      <div>
        <a-button type="primary" class="editable-add-btn"
                  @click="addMenu">
          Thêm
        </a-button>
        <a-modal v-model="visible" :title="titleModal" :footer="null">
          <ModalMenu
            :rules="rules"
            :editItem="editItem"
            :isEdit="isEdit"
            @updateVisible="updateVisible"
            @updateListAfterUpdated="updateListAfterUpdated"
          />
        </a-modal>
        <a-table bordered :data-source="desserts"
                 :columns="columns"
                 :row-key="(record) => record.id"
        >
          <template slot="isActive" slot-scope="text, record">
            <a-switch size="small" v-model="record.is_active" :disabled="record.is_active"
                      @change="changeIsActive(record)"/>
          </template>
          <template slot="action" slot-scope="text, record">
            <a-button @click="editCategory(record)" :size="'small'"
                      :type="'primary'"
            >
              <a-icon type="edit"/>
            </a-button>
            <a-popconfirm
              title="Xoá menu này?"
              ok-text="Xoá"
              cancel-text="Không"
              @confirm="deleteMenu(record)"
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
  import {ApiCaller} from "../../utils/api";
  import {URLS} from "../../utils/url";
  import ModalMenu from "./ModalMenu";
  import {mapGetters, mapActions} from 'vuex'

  const newMenu = {
    id: '',
    name: '',
    restaurant_id: undefined,
    is_active: true
  }
  export default {
    name: "Categories",
    data() {
      return {
        value: undefined,
        restaurants: [],
        rules: {
          name: [
            {
              required: true,
              message: 'Nhập tên menu', trigger: 'blur'
            }
          ],
        },
        editItem: {},
        isEdit: false,
        desserts: [],
        visible: false,
        columns: [
          {
            title: 'Tên',
            dataIndex: 'name',
          },
          {
            title: 'Kích hoạt',
            dataIndex: 'is_active',
            scopedSlots: {customRender: "isActive"}
          },
          {
            title: 'Action',
            dataIndex: 'action',
            scopedSlots: {customRender: 'action'},
          },
        ],
      };
    },
    components: {
      ModalMenu
    },
    computed: {
      ...mapGetters([
        'currentRestaurant'
      ]),
      titleModal() {
        return this.isEdit ? 'Sửa Menu' : 'Thêm mới Menu'
      }
    },
    mounted() {
      this.initialize()
    },
    methods: {
      initialize() {
        return ApiCaller().get(URLS.MENUS())
          .then(response => {
            this.desserts = response.data;
          })
          .catch(e => {
            console.log(e);
          });
      },
      addMenu() {
        this.visible = true;
        this.isEdit = false
        this.editItem = Object.assign({}, newMenu);
        this.editItem.restaurant_id = this.currentRestaurant.id
      },
      editCategory(record) {
        this.isEdit = true;
        this.visible = true;
        this.editItem = Object.assign({}, record);
      },
      updateVisible(value) {
        this.visible = value;
      },
      deleteMenu(item) {
        ApiCaller().delete(URLS.MENU(item.id))
          .then((res) => {
            this.$message.success('Deleted success')
            this.initialize()
          })
          .catch(error => {
            console.log(error);
          });
      },
      updateListAfterUpdated() {
        this.initialize()
      },
      async changeIsActive(item) {
        let response = await ApiCaller().post(URLS.MENU_CHANGE_ACTIVE(item.id), {
          id: item.id,
        })
        if (response.status === 200) {
          this.$message.success("Cập nhật thành công");
        } else {
          this.$message.error(response.message);
        }
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
