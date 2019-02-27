<template>
  <div class="container">
    <div class="row">
      <nav-bar class="col s12"></nav-bar>
    </div>
    <breadcrumbs />
    <router-view></router-view>
  </div>
</template>

<script>
import VueRouter from 'vue-router'
import Landing from './Landing.vue'
import Navbar from './Navbar.vue'
import AuctionsIndex from './auctions/Index.vue'
import AuctionsList from './auctions/List.vue'
import AuctionsNew from './auctions/New.vue'
import AuctionsEdit from './auctions/Edit.vue'
import AuctionsShow from './auctions/Show.vue'

const routes = [
  { path: '/', component: Landing, name: 'home' },
  {
    path: '/auctions', component: AuctionsIndex,
    meta: { breadcrumb: 'Auctions' },
    children: [
      { path: '', component: AuctionsList },
      { path: 'new', component: AuctionsNew, name: 'auctions-new',
        meta: { breadcrumb: 'New' } },
      { path: ':id/edit', component: AuctionsEdit, name: 'auctions-edit',
        meta: { breadcrumb: 'Edit' } },
      { path: ':id', component: AuctionsShow, name: 'auction',
        meta: { breadcrumb: 'Show'} },
    ]
  }
]

const router = new VueRouter({ routes })

export default {
  name: 'app',
  components: {
    'nav-bar': Navbar
  },
  router
}
</script>

<style lang="scss">
</style>
