<template>
  <div id="app">
    <router-view/>
  </div>
</template>

<script>
  import Dorm from './components/Dorm'
  import Reserve from './components/Reserve'
export default {
  name: 'app',
  components: [
    Dorm,
    Reserve
  ]
}
</script>

<style>
</style>
