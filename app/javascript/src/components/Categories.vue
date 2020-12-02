<template>
  <div id="category">
    <div class="category-search">
      <a-select placeholder="Select a Restaurant">
        <a-select-option value="jack">
          Jack
        </a-select-option>
        <a-select-option value="lucy">
          Lucy
        </a-select-option>
        <a-select-option value="tom">
          Tom
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
          <a-modal v-model="visible" title="Create New Category" @ok="handleOk">

            <a-form :form="form" @submit="handleSubmit">
              <a-form-item label="Name Category">
                <a-input
                />
              </a-form-item>
              <a-form-item>
                <a-select mode="tags" style="width: 100%"
                          placeholder="Select Restaurant"
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
              <a-popconfirm
                v-if="dataSource.length"
                title="Sure to delete?"
                @confirm="() => onDelete(record.key)"
              >
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
  export default {
    name: "Categories",
    data() {
      return {
        formLayout: 'horizontal',
        form: this.$form.createForm(this, { name: 'coordinated' }),
        visible: false,
        dataSource: [
          {
            key: '0',
            name: 'Edward King 0',
          },
          {
            key: '1',
            name: 'Edward King 1',
          },
          {
            key: '2',
            name: 'Edward King 3',
          },
        ],
        count: 2,
        columns: [
          {
            title: 'Name',
            dataIndex: 'name',

          },
          {
            title: 'Action',
            dataIndex: 'operation',
            scopedSlots: {customRender: 'operation'},
          },
        ],
      };
    },
    methods: {
      handleSubmit(e) {
        e.preventDefault();
        this.form.validateFields((err, values) => {
          if (!err) {
            const {keys, names} = values;
            console.log('Received values of form: ', values);
            console.log(
              'Merged values:',
              keys.map(key => names[key]),
            );
          }
        });
      },
      showModal() {
        this.visible = true;
      },
      handleChange(value) {
        console.log(`selected ${value}`);
      },
      handleOk(e) {
        console.log(e);
        this.visible = false;
      },
    }
  }
</script>
<style scoped>
  #category .category-search .ant-select {
    margin: 20px;
    width: 50%;
  }
</style>
