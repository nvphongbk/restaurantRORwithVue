<template>
  <a-form-model
    :rules="rules"
    ref="ruleForm"
    :model="editItem"
    :label-col="{ span: 8 }"
    :wrapper-col="{ span: 16 }">
    <a-form-model-item ref="name" label="Tên Menu" prop="name">
      <a-input placeholder="Vui lòng nhập menu"
               v-model="editItem.name"/>
    </a-form-model-item>
    <a-form-model-item label="Kích hoạt" prop="is_active">
      <a-switch v-model="editItem.is_active"/>
    </a-form-model-item>
    <a-form-model-item :wrapperCol="{ offset: 8 }">
      <a-button @click="handleSubmit" type="primary" html-type="submit">
        {{ getTitle }}
      </a-button>
    </a-form-model-item>
  </a-form-model>
</template>
<script>
  import {ApiCaller} from "../../utils/api";
  import {URLS} from "../../utils/url";

  export default {
    name: "FormCategory",
    props: {
      rules: {
        type: Object
      },
      isEdit: {
        type: Boolean,
        default: false
      },
      visible: {
        type: Boolean,
        default: false
      },
      editItem: {
        type: Object
      },

    },
    data() {
      return {};
    },
    computed: {
      getTitle() {
        return this.isEdit ? "Cập nhật" : "Thêm"
      }
    },
    methods: {
      create(item) {
        this.isEdit = false
        ApiCaller().post(URLS.MENUS(), {
          menu: item
        })
          .then(response => {
            this.$message.success('Cập nhật thành công');
            this.$emit('updateListAfterUpdated', this.editItem);
          })
          .catch(error => {
            console.log(error);
          });
      },
      handleSubmit(e) {
        this.$refs.ruleForm.validate((valid) => {
          if (valid) {
            let valuesSave = Object.assign({}, this.editItem)
            if (this.isEdit) {
              let idItem = this.editItem.id
              ApiCaller().put(URLS.MENU(idItem), {
                menu: valuesSave
              })
                .then(response => {
                  this.$message.success('Cập nhật thành công')
                  this.$emit('updateListAfterUpdated', this.editItem);
                })
                .catch(error => {
                  console.log(error);
                });
            } else {
              this.create(valuesSave)
            }
            this.$emit('updateVisible', false);
            this.visible = false;
          } else {
            return false;
          }
        });
      }
    },
  };
</script>
