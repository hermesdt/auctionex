<template>
  <div class="row">
    <div v-for="auction in auctions" v-bind:key="auction.id" class="col s12 m3">
      <router-link :to="{name: 'auction', params: { id: auction.id}}">
        <p>{{ auction.title }}</p>
      </router-link>
    </div>

    <router-link to="/auctions/new" class="btn-floating btn-large waves-effect waves-light red">
        <i class="material-icons">add</i>
    </router-link>
  </div>
</template>

<script>
import Vue from 'vue'

export default {
    name: "auctions-list",
    data () {
        return {
            auctions: []
        }
    },
    mounted () {
        console.log(this.$router)
      Vue.http.get("/auctions")
      .then((response)  => {
        this.auctions = response.body.auctions
      })
    }
}
</script>