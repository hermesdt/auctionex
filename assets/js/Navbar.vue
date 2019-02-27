<template>
  <div class="nav-bar">
    <div class="row" v-if="is_logged_in">
      <span class="greeting">welcome {{name}}</span>
    </div>
    <div class="row" v-else>
      <a href="/auth/google" class="btn col s12 m2 offset-m10">Login</a>
    </div>
  </div>
</template>

<script>
  import Vue from 'vue'
  import globals from './globals'

  export default {
    name: "Navbar",
    data () {
      return {
        is_logged_in: false,
        name: null
      }
    },
    mounted () {
      Vue.http.get("/me")
      .then((response)  => {
        this.is_logged_in = true
        this.name = response.body.name
        globals.userId = response.body.id
      })
    }
  }
</script>

<style lang="scss">
.nav-bar {
  background: black;

  .greeting {
    color: white;
  }
}
</style>
