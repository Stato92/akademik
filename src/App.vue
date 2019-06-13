<template>
  <div id="app">
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
