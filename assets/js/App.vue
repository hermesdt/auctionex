<template>
  <div class="container">
    <div class="row">
      <nav-bar class="col s12"></nav-bar>
    </div>
    <div class="row">
      <h1 class="col s12">{{ msg }}</h1>
    </div>
  </div>
</template>

<script>
import Navbar from './Navbar.vue'

export default {
  name: 'app',
  data () {
    return {
      msg: 'Welcome to Your Vue.js & Phoenix & GraphQL App'
    }
  },
  components: {
    'nav-bar': Navbar
  }
}
</script>

<style lang="scss">
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
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