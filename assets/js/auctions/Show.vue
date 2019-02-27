<template>
    <div class="row auction">
        <div class="col s12">
            <div class="row">
                <router-link v-if="auction.user_id == $user_id"
                    :to="editLink(auction.id)"
                    class="btn">
                    Edit
                </router-link>
            </div>
        </div>
        <div class="col s12 title">
            <h2>{{ auction.title }}</h2>
        </div>
        <div class="col s12 description">
            {{ auction.description }}
        </div>
    </div>
</template>

<script>
import Vue from 'vue'

export default {
    name: "auction",
    data() {
        return {
            auction: {}
        }
    },
    mounted () {
        Vue.http.get(`/auctions/${this.$route.params.id}`)
        .then((response)  => {
            this.auction = response.body.auction
        })
    },
    methods: {
        editLink: function(id) {
            return `/auctions/${id}/edit`
        }
    }
}
</script>
