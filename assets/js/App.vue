<template>
  <div class="container">
    <div class="row">
      <nav-bar class="col s12"></nav-bar>
    </div>
    <router-view></router-view>
  </div>
</template>

<script>
import VueRouter from 'vue-router'
import Landing from './Landing.vue'
import Navbar from './Navbar.vue'
import AuctionsIndex from './auctions/Index.vue'
import AuctionsNew from './auctions/New.vue'

const routes = [
  { path: '/', component: Landing },
  { path: '/auctions', component: AuctionsIndex },
  { path: '/auctions/new', component: AuctionsNew },
]

const router = new VueRouter({ routes })

export default {
  name: 'app',
  components: {
    'nav-bar': Navbar
  },
  router
}
</script>

<style lang="scss">
</style>
