<template>
  <a-layout-content :style="{ margin: '24px 16px 0' }">
    <div style="margin-bottom: 10px">
      <a-button type="primary" class="editable-add-btn"
                @click="addCookingMethod">
        Thêm
      </a-button>
      <a-input-search
        placeholder="Tìm kiếm..."
        style="width: 200px"
        v-model="search"
      ></a-input-search>
      <a-modal v-model="visible" :title="titleModal" :footer="null">
        <FormCookingMethod
          :rules="rules"
          :editItem="editItem"
          :isEdit="isEdit"
          @updateVisible="updateVisible"
          @updateListAfterUpdated="updateListAfterUpdated"
        />
      </a-modal>
    </div>
    <a-table bordered :data-source="onSearch" :columns="columns"
               :row-key="(record) => record.id"
      >
        <template slot="isActive" slot-scope="text, record">
          <a-switch v-model="record.is_active" @change="changeIsActive(record)"></a-switch>

        </template>
        <template slot="action" slot-scope="text, record">
          <a-button @click="editCookingMethod(record)" :size="'small'"
                    :type="'primary'"
          >
            <a-icon type="edit"/>
          </a-button>
          <a-popconfirm
            title="Bạn muốn xoá thành phần này?"
            ok-text="Xoá"
            cancel-text="Huỷ"
            @confirm="deleteCookingMethod(record)"
          >
            <a-button size="small" type="danger">
              <a-icon type="delete"/>
            </a-button>
          </a-popconfirm>
        </template>
      </a-table>
  </a-layout-content>
</template>

<script>
  import {ApiCaller} from "../utils/api";
  import FormCookingMethod from "./forms/FormCookingMethod"
  import {URLS} from "../utils/url"
  const newCookingMethod = {
    id: '',
    name: '',
    position: undefined,
    is_active: true,
    restaurant_id: undefined
  }
  export default {
    name: "CookingMethods",
    data() {
      return {
        search: '',
        rules: {
          name:
            [
              {
                required: true,
                message: 'Vui lòng điền tên thành phần', trigger: 'blur'
              }
            ],
          restaurant_id:
            [{
              required: true,
              message: 'Vui lòng chọn cửa hàng',
              trigger: 'blur'
            }]
        },
        editItem: {},
        isEdit: false,
        ingredients: [],
        visible: false,
        columns: [
          {
            title: 'Name',
            dataIndex: 'name',
          },
          {
            title: 'Sắp xếp',
            dataIndex: 'position',
          },
          {
            title: 'Kích hoạt',
            dataIndex: 'is_active',
            scopedSlots: {customRender: 'isActive'},
          },
          {
            title: '',
            dataIndex: 'action',
            scopedSlots: {customRender: 'action'},
          },
        ],
      };
    },
    components:{
      FormCookingMethod
    },
    mounted() {
      this.initialize()
    },
    computed: {
      titleModal() {
        return this.isEdit ? 'Cập nhật lại thành phần' : 'Thêm thành phần mới'
      },
      onSearch() {
        if(this.search){
          return this.ingredients.filter((item)=>{
            return this.search.toLowerCase().split(' ').every(v => item.name.toLowerCase().includes(v))
          })
        }else{
          return this.ingredients;
        }
      }
    },
    methods: {
      initialize() {
        return ApiCaller().get(URLS.COOKING_METHODS())
          .then(response => {
            this.ingredients = response.data;
          })
          .catch(e => {
            console.log(e);
          });
      },
      addCookingMethod(){
        this.visible = true;
        this.isEdit = false
        this.editItem = Object.assign({}, newCookingMethod);
      },
      editCookingMethod(record) {
        this.isEdit = true;
        this.visible = true;
        this.editItem = Object.assign({}, record);
      },
      updateVisible(value) {
        this.visible = value;
      },
      updateListAfterUpdated() {
        this.initialize()
      },
      async changeIsActive(item) {
        let response = await ApiCaller().post(URLS.COOKING_METHOD_CHANGE_ACTIVE(item.id), {
          id: item.id,
          is_active: item.is_active
        })
        if (response.status === 200) {
          this.$message.success("Cập nhật thành công");
        } else {
          this.$message.error(response.message);
        }
      },
      deleteCookingMethod(item) {
        return ApiCaller().delete(URLS.COOKING_METHOD(item.id))
          .then((res) => {
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

</style>
