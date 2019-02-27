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
    components: {
        'AuctionForm': Form
    },
    data () {
        return {
            auction: {},
            errors: {}
        }
    },
    mounted () {
        Vue.http.get(`/auctions/${this.$route.params.id}`)
        .then((response)  => {
            this.auction = response.body.auction
        })
    },
    methods: {
        submit: function () {
            var data = { title: this.auction.title, description: this.auction.description }
            return Vue.http.put(`/auctions/${this.auction.id}`, { auction: data })
            .then((response)  => {
                this.errors = { title: [], description: []}
                this.$router.push(`/auctions/${this.auction.id}`)
            }, (error) => {
                this.errors = error.body.errors
            })
        }
    }
}
</script>
