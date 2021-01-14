<template>
  <div id="compnavigation">
    <div class="navigation-header-logo-box">
        <img :src="logo" class="navigation-header-logo-box__img" alt="logo">
    </div>
  </div>

</template>

<script>
  export default {
    name: "Navigation",
    data() {
      return {
        logo: '/uploads/logo/logoRestaurant.png',
      }
    }
  }
</script>

<style scoped>
  .navigation-header-logo-box {
    position: absolute;
    top: 30px;
    left: 10px;
  }

  .navigation-header-logo-box__img {
    height: 90px;
  }

  .navigation__checkbox {
    display: none;
  }

  .navigation__button {
    background-color: whitesmoke;
    height: 70px;
    width: 70px;
    position: fixed;
    top: 30px;
    right: 10px;
    border-radius: 50%;
    z-index: 2000;
    cursor: pointer;
    text-align: center;
    box-shadow: 0 3px 9px rgba(0, 0, 0, .15);
  }

  .navigation__background {
    height: 60px;
    width: 60px;
    border-radius: 50%;
    position: fixed;
    top: 33px;
    right: 12px;
    background-image: radial-gradient(deepskyblue, aliceblue);
    z-index: 1000;
    transition: transform .3s;
  }

  .navigation__nav {
    height: 100vh;
    position: fixed;
    top: 0;
    right: 0;
    z-index: 1500;
    opacity: 0;
    width: 0;
    transition: all .3s;
  }

  .navigation__list {
    list-style: none;
    text-align: center;
    display: flex;
    flex-wrap: wrap;
    height: 100vh;
    align-content: center;

  }

  .navigation__item {
    margin: 5px;
    width: 100%;
  }

  .navigation__link:link, .navigation__link:visited {
    display: inline-block;
    border-radius: 65px;
    font-size: 40px;
    font-weight: 300;
    padding: 10px 20px;
    color: white;
    text-decoration: none;
    text-transform: uppercase;
    background-image: radial-gradient(150% 200% ellipse at 115%,
    white 0%,
    white 50%,
    transparent 50%);
    background-size: 252%;
    transition: all .4s;
  }

  .navigation__link:hover {
    background-position: 100%;
    color: deepskyblue;
    transform: translateX(1rem);
  }

  .navigation__checkbox:checked ~ .navigation__background {
    transform: scale(80);
  }

  .navigation__checkbox:checked ~ .navigation__nav {
    opacity: 1;
    width: 100%;
  }

  .navigation__icon {
    position: relative;
    margin-top: 33px;
  }

  .navigation__icon, .navigation__icon::before, .navigation__icon::after {
    width: 40px;
    height: 4px;
    background-color: lightslategrey;
    display: inline-block;
  }

  .navigation__icon::before, .navigation__icon::after {
    content: "";
    position: absolute;
    left: 0;
    transition: all .2s;
  }

  .navigation__icon::before {
    top: -.8rem;
  }

  .navigation__icon::after {
    top: .8rem;
  }

  .navigation__button:hover .navigation__icon::before {
    top: -1rem;
  }

  .navigation__button:hover .navigation__icon::after {
    top: 1rem;
  }

  .navigation__checkbox:checked + .navigation__button .navigation__icon {
    background-color: transparent;
  }

  .navigation__checkbox:checked + .navigation__button .navigation__icon::before {
    top: 0;
    transform: rotate(135deg);
  }

  .navigation__checkbox:checked + .navigation__button .navigation__icon::after {
    top: 0;
    transform: rotate(-135deg);
  }
</style>
