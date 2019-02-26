<template>
  <div class="row">
    <div v-for="auction in auctions" v-bind:key="auction.id" class="col s12 m3">
      <p>{{ auction.name }}</p>
      <router-link to="`/auctions/${auction.id}`"></router-link>
    </div>
  </div>
</template>

<script>
import Vue from 'vue'

export default {
    name: "auctions-index",
    data () {
        return {
            auctions: []
        }
    },
    mounted () {
      Vue.http.get("/auctions")
      .then((response)  => {
        this.auctions = response.auctions
      })
    }
}
</script>