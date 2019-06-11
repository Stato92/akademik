import Vue from 'vue'
import App from './App.vue'
import BootstrapVue from 'bootstrap-vue'
import Router from 'vue-router'
import Routes from './routes.js'

Vue.use(Router);


const router = new Router({
  routes: Routes // short for `routes: routes`
});

Vue.use(BootstrapVue);
Vue.config.productionTip = false;
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
new Vue({
  el: '#app',
  render: h => h(App),
  router: router
})
