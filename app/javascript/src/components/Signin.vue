<template>
  <div class="max-w-sm m-auto my-8 bg-gray-400">
    <div class="border p-10 border-grey-light shadow rounded">
      <h3 class="text-2xl mb-6 items-center justify-center text-grey-200">Sign In Your Restaurant</h3>
      <form @submit.prevent="signin">
         <div class="text-red" v-if="error">{{ error }}</div>

        <div class="mb-6">
          <input type="email" v-model="email" class="input w-full rounded-sm" id="email" placeholder="Email">
        </div>
        <div class="mb-6">
          <input type="password" v-model="password" class="inpu w-full rounded-sm" id="password" placeholder="Password">
        </div>
        <button type="submit" class="font-sans bg-green-600 font-bold px-4 rounded cursor-pointer no-underline hover: block w-full py-4 items-center justify-center">Sign In</button>
        <a href="http://localhost:3000/dashboard" class="w-1/2 text-black mt-2 float-right">Forgot password</a>
      </form>
    </div>
  </div>
</template>

<script>
export default {
  name: 'signIn',
  title: 'Sign in',
  data () {
    return {
      email: '',
      password: '',
      error: ''
    }
  }
}
</script>
