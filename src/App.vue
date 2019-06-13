<template>
  <div id="app">
    <ul class="text-center">
      <li>
        <router-link to="/">Strona główna</router-link>
      </li>
      <li>
        <router-link to="/Admin">Admin</router-link>
      </li>
    </ul>
    <transition mode="out-in" name="fade">
      <router-view/>
    </transition>
  </div>
</template>

<script>
  import Reserve from './components/Reserve'
  import Dorm from './components/Dorm'

  export default {
    components: {
      Dorm,
      Reserve
    },
    name: 'app'
  }
</script>

<style>
  .fade-enter-active, .fade-leave-active {
    transition: opacity 0.5s ease;
  }

  .fade-enter, .fade-leave-to {
    opacity: 0;
  }

  .fade-leave, .fade-enter-to {
    opacity: 1;
  }
</style>
