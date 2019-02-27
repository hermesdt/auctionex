<template>
    <AuctionForm
        :auction="auction"
        :errors="errors"
        :submit="submit"></AuctionForm>
</template>

<script>
import Vue from 'vue'
import Form from './Form.vue'

export default {
  name: "auctions-new",
  components: {
      'AuctionForm': Form
  },
  data () {
    return {
      auction: {},
      errors: {}
    }
  },
  methods: {
    submit: function () {
      var data = { title: this.auction.title, description: this.auction.description }
      return Vue.http.post("/auctions", { auction: data })
      .then((response)  => {
        this.$router.push(`/auctions/${response.body.auction.id}`)
      }, (error) => {
        this.errors = error.body.errors
      })
    }
  }
}
</script>

<style lang="scss">
</style>
