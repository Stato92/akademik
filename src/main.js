import Vue from 'vue'
import App from './App.vue'
import BootstrapVue from 'bootstrap-vue'
import Router from 'vue-router'
import Routes from './routes.js'
import Vuelidate from 'vuelidate'
import VueResource from 'vue-resource';

Vue.use(Router);
Vue.use(Vuelidate);
Vue.use(BootstrapVue);
Vue.use(VueResource);
Vue.http.options.emulateJSON = true;

const router = new Router({
  routes: Routes // short for `routes: routes`
});

Vue.config.productionTip = false;
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
import './assets/animate.css'
new Vue({
  el: '#app',
  render: h => h(App),
  router: router
});
