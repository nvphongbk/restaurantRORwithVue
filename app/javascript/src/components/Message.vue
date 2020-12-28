<template>
  <a-layout-content :style="{ margin: '24px 16px 0' }">
    <div :style="{ padding: '24px', background: '#fff', minHeight: '360px' }">
      <div>
        <a-table bordered :data-source="desserts"
                 :columns="columns"
                 :row-key="(record) => record.id"
        >
          <template slot="image" slot-scope="image">
            <span>
              <a-avatar shape="square" :size="100" :src="image"/>
            </span>
          </template>
          <template slot="action" slot-scope="text, record">
            <a-popconfirm
              title="Delete this Message?"
              ok-text="Delete"
              cancel-text="Cancel"
              @confirm="deleteMessage(record)"
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
  import axios from "axios"
  import {URLS} from "../utils/url";

  export default {
    name: "Message",
    data () {
      return {
        desserts: [],
        columns: [
          {
            title: 'Name',
            dataIndex: 'name',
          },
          {
            title: 'Email',
            dataIndex: 'email',
          },
          {
            title: 'Message',
            dataIndex: 'message',
            scopedSlots: {customRender: "message"},
          },
          {
            title: 'Create at',
            dataIndex: 'created_at',
          },
          {
            title: 'Action',
            dataIndex: 'action',
            scopedSlots: {customRender: 'action'},
          },
        ],
      }
    },
    mounted() {
      this.initialize()
    },
    methods: {
      initialize() {
        return axios
          .get(URLS.MESSAGES())
          .then(response => {
            this.desserts = response.data;
          })
          .catch(e => {
          });
      },
      deleteMessage(message) {
        axios
          .delete(URLS.MESSAGE(message.id))
          .then((res) => {
            this.$message.success('Deleted success');
            this.initialize()
          })
          .catch(error => {
          });
      },
    },
  }
</script>

<style scoped>

</style>
