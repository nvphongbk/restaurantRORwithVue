<template>
  <a-layout-content :style="{ margin: '0px 16px 0' }">
    <div :style="{ background: '#fff', minHeight: '360px' }">
      <div>
        <a-button type="primary" class="editable-add-btn"
                  @click="addRestaurant">
          Thêm mới
        </a-button>
        <a-input-search
          placeholder="Tìm tên nhà hàng"
          style="width: 200px"
          v-model="search"
        ></a-input-search>
        <a-modal v-model="visible" :title="titleModal" :footer="null">
          <FormRestaurant
            :rules="rules"
            :editItem="editItem"
            :isEdit="isEdit"
            @updateVisible="updateVisible"
            @updateListAfterUpdated="updateListAfterUpdated"
          />
        </a-modal>

        <a-modal v-model="visible_qrcode" :title=this.editItem.name :footer="null">
          <QrRestaurant :editItem="editItem" />
        </a-modal>

        <a-table bordered :data-source="onSearch" :columns="columns"
                 :row-key="(record) => record.id">
          <template slot="qrcode" slot-scope="text, record">
            <a-button @click="getQrCode(record)" :size="'small'"
                      :type="'primary'"
            >
              <a-icon type="qrcode"/>
            </a-button>
          </template>
          <template slot="action" slot-scope="text, record">
            <a-button @click="editRestaurant(record)" :size="'small'"
                      :type="'primary'"
            >
              <a-icon type="edit"/>
            </a-button>
            <a-popconfirm
              title="Delete this Category?"
              ok-text="Delete"
              cancel-text="Cancel"
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
  import {ApiCaller} from "../utils/api";
  import FormRestaurant from "./forms/FormRestaurant"
  import {URLS} from "../utils/url"
  import QrRestaurant from "./QrRestaurant";
  const newRestaurant = {
    id: '',
    name: '',
    address:'',
    pass_wifi: '',
    user_id:'',
    phone: '',
  }
  export default {
    name: "Restaurants",
    data() {
      return {
        search: '',
        rules: {
          name: [
            { required: true,
              message: 'Điền tên nhà hàng', trigger: 'blur' },
            { min: 3,
              message: 'Chiều dài tên cửa hàng lớn hơn 3',
              trigger: 'blur' },
          ],
          address: [
            {
              required: true,
              message: 'Điền địa chỉ',
              trigger: 'blur'
            },
            {
              min: 3,
              message: 'Chiều dài lớn hơn 3',
              trigger: 'blur'
            },
          ],
        },
        editItem: {
        },
        isEdit: false,
        desserts: [],
        visible: false,
        visible_qrcode: false,
        columns: [
          {
            title: 'Tên',
            dataIndex: 'name',
          },
          {
            title: 'Ngày tạo',
            dataIndex: 'created_at',
          },
          {
            title: 'Đường dẫn',
            dataIndex: 'slug',
          },
          {
            title: 'Địa chỉ ',
            dataIndex: 'address',
          },
          {
            title: 'Số điện thoại',
            dataIndex: 'phone',
          },
          {
            title: 'Pass wifi',
            dataIndex: 'pass_wifi',
          },
          {
            title: 'QR CODE',
            dataIndex: 'qrcode',
            scopedSlots: {customRender: 'qrcode'},
          },
          {
            title: 'Sửa/Xoá',
            dataIndex: 'action',
            scopedSlots: {customRender: 'action'},
          },
        ],
      };
    },
    components:{
      QrRestaurant,
      FormRestaurant
    },
    mounted() {
      this.initialize()
    },
    computed: {
      titleModal() {
        return this.isEdit ? 'Sửa thông tin nhà hàng ' : 'Tạo nhà hàng mới'
      },
      onSearch() {
        if(this.search){
          return this.desserts.filter((item)=>{
            return this.search.toLowerCase().split(' ').every(v => item.name.toLowerCase().includes(v))
          })
        }else{
          return this.desserts;
        }
      }
    },
    methods: {
      initialize() {
        return ApiCaller().get(URLS.RESTAURANTS())
          .then(response => {
            console.log(response.data);
            this.desserts = response.data;
          })
          .catch(e => {
            console.log(e);
          });
      },
      addRestaurant(){
        this.visible = true;
        this.isEdit = false
        this.editItem = Object.assign({}, newRestaurant);
      },
      editRestaurant(record) {
        this.isEdit = true;
        this.visible = true;
        this.editItem = Object.assign({}, record);
      },
      getQrCode(record){
        this.visible_qrcode = true;
        this.editItem = Object.assign({}, record);
      },
      updateVisible(value) {
        this.visible = value;
      },
      updateListAfterUpdated() {
        this.initialize()
      },
      deleteRestaurant(item) {
        return ApiCaller().delete(URLS.RESTAURANT(item.id))
          .then((res) => {
            console.log(res)
            this.$message.success('Đã xoá thành công');
            this.initialize()
          })
          .catch(error => {
            console.log(error);
          });
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
