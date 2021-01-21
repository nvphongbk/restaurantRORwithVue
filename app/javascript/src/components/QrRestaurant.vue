<template >
  <div id="qrcoderestaurant">
    <vue-html2pdf
      :float-layout="true"
      :enable-download="true"
      :paginate-elements-by-height="1400"
      :filename="editItem.name"
      :pdf-quality="2"
      :manual-pagination="false"
      pdf-format="a5"
      pdf-orientation="landscape"
      pdf-content-width="800px"
      ref="html2Pdf"
    >
        <section slot="pdf-content">
          <div class="text-center">
            <div class="pdf-name">
              {{editItem.name}}
            </div>
            <div class="imageqrcode">
              <VueQRCodeComponent :width="width" :text="editItemUrl"/>
            </div>
          </div>
        </section>
    </vue-html2pdf>
    <div class="imageqrcode">
      <VueQRCodeComponent :width="width" :text="editItemUrl"/>
    </div>
    <a-button @click="generateReport" type="primary">
      Download QRCODE
    </a-button>
  </div>
</template>

<script>
  import {HOME_URL} from "../utils/constant";
  import {URLS} from "../utils/url";
  import VueQRCodeComponent from 'vue-qrcode-component';
  import VueHtml2pdf from 'vue-html2pdf'

  export default {
    name: "QrRestaurant",
    props: {
      editItem: {
        type: Object
      },
    },
    data() {
      return {
        text: HOME_URL,
        width: 400
      }
    },
    components: {
      VueQRCodeComponent,
      VueHtml2pdf
    },
    computed: {
      editItemUrl() {
        return URLS.RESTAURANT_URL(this.editItem.id)
      },
    },
    methods: {
      generateReport () {
        this.$refs.html2Pdf.generatePdf()
      },
    }
  }
</script>

<style scoped>
  #qrcoderestaurant {
    text-align: center;
  }

  #qrcoderestaurant img {
    display: block;
    margin: 0 auto;
  }
  .pdf-name{
    margin-top: 50px;
    text-transform: capitalize;
    font-size: 40px;
    font-weight: 500;
  }
  .imageqrcode{
    display: flex;
    justify-content: center;
    align-items: center;
    height: 300px;
    margin: 20px 0;
  }
</style>
