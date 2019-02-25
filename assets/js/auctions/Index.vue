<template>
</template>

<script>
import Vue from 'vue'

export default {
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