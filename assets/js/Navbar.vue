<template>
  <div class="nav-bar">
    <div class="row">
      <a href="/auth/google" class="btn col s12 m2 pull-m1">Login</a>
    </div>
  </div>
</template>

<script>
  import Vue from "vue"

  export default {
    created: () => {
      Vue.http.get("/me")
      .then((response)  => {
        console.log(response)
      }, (error) => {
        console.error(error)
      })
    }
  }
</script>

<style lang="scss">
.nav-bar {
  padding: 0.5em 0;
  background: black;
}
</style>