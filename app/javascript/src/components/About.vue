<template>
  <div id="aboutpage">
    <header class="aboutpage-header"
            :style="{'background-image':'url(/uploads/about/background-header-about.jpg)'}">
      <div class="aboutpage-header-text-box">
        <h3 class="aboutpage-header-heading-primary">
          <span class="aboutpage-header-heading-primary__main">
               Giới thiệu
          </span>
          <span class="aboutpage-header-heading-primary__sub">
              Mr Bolat - Thưởng thức theo cách của bạn
          </span>
        </h3>
      </div>
    </header>
    <Navigation/>
    <div class="aboutpage-intro">
      <a-row>
        <a-col :span="13">
          <div class="aboutpage-our-story-composition">
            <img src="/uploads/about/our-story-us-1.jpg" alt="photo1"
                 class="aboutpage-our-story-composition__photo aboutpage-our-story-composition__photo--p1">
            <img src="/uploads/about/our-story-us-2.jpg" alt="photo2"
                 class="aboutpage-our-story-composition__photo aboutpage-our-story-composition__photo--p2">
            <img src="/uploads/about/our-story-us-3.jpg" alt="photo3"
                 class="aboutpage-our-story-composition__photo aboutpage-our-story-composition__photo--p3">
          </div>
        </a-col>
        <a-col :span="10" :offset="1">
          <div class="aboutpage-intro-content">
            <h4 class="intro-content__title">Câu chuyện của chúng </h4>
            <p class="intro-content__paragraph">
              Được tọa lạc ngay giữa trung tâm nhộn nhịp,
              nhà hàng Mr Bolat là một không gian tuyệt vời để thực khách có thể
              xua tan hết mọi áp lực cuộc sống khi tận hưởng những món ăn đậm
              chất văn hoá của ẩm thực Việt Nam.
              Trong tiềm thức nhiều người, hình ảnh món Việt thường luôn gắn
              liền với không gian dân dã và đậm chất thôn quê, nhưng đến với Dì
              Mai, bạn sẽ không khỏi bất ngờ trước lối thiết kế giao hòa, tinh
              tế và độc đáo giữa nét quê mộc mạc và kiến trúc Đông Dương. Nét ấn
              tượng nhất ngay tại trung tâm là bàn ăn được thiết kế từ chiếc xe
              lam; gợi nên hình ảnh đường phố Sài Gòn năm xưa. Hơn thế nữa, sự
              chăm chút tỉ mỉ về trang phục qua tà áo dài cách tân của nhân viên
              phục vụ và những chiếc tạp dề mang hoạ tiết đậm chất Việt của đầu
              bếp đã góp phần hoàn thiện phong cách độc đáo cho nhà hàng
            </p>
          </div>
          <div>
            <h5 class="uppercase text-white text-lg">Đặc biệt</h5>
            <ul class="text-white flex flex-wrap">
              <li class="w-2/4">
                <a-icon class="intro__icon" type="sketch"/>
                Ăn tối
              </li>
              <li class="w-2/4">
                <a-icon class="intro__icon" type="sketch"/>
                Dịch vụ ăn
              </li>
              <li class="w-2/4">
                <a-icon class="intro__icon" type="sketch"/>
                Giao đồ ăn
              </li>
              <li class="w-2/4">
                <a-icon class="intro__icon" type="sketch"/>
                Lễ Cưới
              </li>
            </ul>
          </div>
        </a-col>
      </a-row>
    </div>
    <div>
      <a-row class="aboutpage-archie">
        <a-col :span="10">
          <div>
            <h4 class="intro-content__title">Thành tựu</h4>
            <p class="intro-content__paragraph">
              Được thành lập ngày 02/04/2010, trải qua nhiều khó khăn và thử thách, đến nay nhà hàng Mr Bolat đã
              trở thành một trong những nhà hàng hàng đầu tại Việt Nam trong ngành ẩm thực và có sức ảnh hưởng lớn
              đến nhiều nước trên thế giới.
            </p>
          </div>
        </a-col>
        <a-col :span="13" :offset="1">
          <div class="composition">
            <img src="/uploads/about/our-story-us-4.jpg" alt="photo1"
                 class="w-3/4">
          </div>
        </a-col>
      </a-row>
      <div>
        <a-row>
          <div class="aboutpage-quote text-center">
            <p class="text-white aboutpage-quote__text">"Với tham vọng của bản thân, việc đi và học nấu nướng chưa bao
              giờ là đủ."</p>
            <p class="uppercase aboutpage-quote__author">ANTHELME
              BRILLAT-SAVARIN</p>
          </div>
        </a-row>
      </div>
      <Footer
        :logo="logo"
      />
    </div>
  </div>
</template>

<script>
  import ARow from "ant-design-vue/es/grid/Row";
  import ACol from "ant-design-vue/es/grid/Col";
  import Footer from "../../layouts/partials/Footer";
  import Navigation from "../../layouts/partials/Navigation";

  export default {
    name: "About",
    components: {Navigation, Footer, ACol, ARow},
    props: {
      logo: {
        type: String
      },
    }
  }
</script>

<style scoped>
  #aboutpage {
    background: rgb(24, 22, 20);
  }

  .aboutpage-header {
    background-size: cover;
    background-position: top;
    position: relative;
    height: 100vh;
    clip-path: ellipse(60% 65% at 50% 33%);
  }

  .intro-content__title {
    font-size: 40px;
    bold: 700;
    color: white;
  }

  .intro-content__paragraph {
    font-size: 14px;
    color: #6B615A;
  }

  .aboutpage-header-text-box {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    text-align: center;
  }

  .aboutpage-header-heading-primary {
    color: #fff;
    text-transform: uppercase;
    margin-bottom: 60px;
  }

  .aboutpage-header-heading-primary__main {
    display: block;
    font-size: 62px;
    font-weight: 400;
    letter-spacing: 15px;
    animation: moveInLeft 1s ease-out;
  }

  .aboutpage-header-heading-primary__sub {
    display: block;
    font-size: 20px;
    font-weight: 700;
    letter-spacing: 18px;
    animation: moveInRight 1s ease-out
  }

  .aboutpage-intro {
    margin: 30px 10px;
    height: 350px;
  }

  .aboutpage-archie {
    margin: 30px 10px;
    height: 450px;
  }

  .aboutpage-our-story-composition {
    position: relative;
  }

  .aboutpage-our-story-composition__photo {
    width: 50%;
    box-shadow: 0 3px 5px rgba(192, 192, 192, .4);
    border-radius: 3px;
    position: absolute;
    z-index: 10;
  }

  .aboutpage-our-story-composition__photo--p1 {
    left: 0;
    top: -6px;
  }

  .aboutpage-our-story-composition__photo--p2 {
    right: 5px;
    top: 30px;
  }

  .aboutpage-our-story-composition__photo--p3 {
    left: 15%;
    top: 50px;
  }

  .aboutpage-our-story-composition__photo:not(:hover) {
    transform: scale(.9)
  }

  .aboutpage-our-story-composition__photo:hover {
    outline: 2px solid cornflowerblue;
    transform: scale(1.05);
    box-shadow: 0 7px 12px rgba(192, 192, 192, .5);
    z-index: 100;
  }

  .intro__icon {
    margin-top: 4px;
    margin-right: 2px;
  }

  .aboutpage-quote {
    width: 60%;
    height: 300px;
    padding: 100px;
    margin-left: 20%;
  }

  .aboutpage-quote__text {
    font-size: 23px;
    font-style: italic;
  }

  .aboutpage-quote__author {
    font-size: 20px;
    color: #C1975D;
  }
</style>
