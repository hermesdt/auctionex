<template>
    <div class="row auction">
        <div class="col s12">
            <div class="row">
                <router-link v-if="sameUser"
                    :to="editLink(auction.id)"
                    class="btn col s12 m1">
                    Edit
                </router-link>
                <button class="btn red col s12 m1"
                    v-if="sameUser"
                    v-on:click="destroy(auction.id)">Delete</button>
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
import globals from '../globals'

export default {
    name: "auction",
    data() {
        return {
            auction: {},
        }
    },
    beforeMount () {
        Vue.http.get(`/auctions/${this.$route.params.id}`)
        .then((response)  => {
            this.auction = response.body.auction
        })
    },
    computed: {
        sameUser: function() {
            return this.auction.user_id == globals.userId
        }

    },
    methods: {
        editLink: function(id) {
            return `/auctions/${id}/edit`
        },
        destroy: function(id) {
            Vue.http.delete(`/auctions/${this.$route.params.id}`)
            .then((response)  => {
                this.$router.push('/auctions')
            })
        }
    }
}
</script>
