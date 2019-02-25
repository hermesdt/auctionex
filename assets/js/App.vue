<template>
  <div class="container">
    <div class="row">
      <nav-bar class="col s12"></nav-bar>
    </div>
    <div class="row">
      <router-view></router-view>
    </div>
  </div>
</template>

<script>
import VueRouter from 'vue-router'
import Navbar from './Navbar.vue'
import Landing from './Landing.vue'
import AuctionsIndex from './auctions/Index.vue'

const routes = [
    {
        path: '/', component: Landing,
        path: '/auctions', component: AuctionsIndex
    },
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
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
h1, h2 {
  font-weight: normal;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
