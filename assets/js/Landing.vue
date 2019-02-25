<template>
    <div>
        <div class="row">
            <h1 class="col s12">Welcome to AuctionEx!</h1>
        </div>
        <div class="row">
            <router-link to="auctions" class="col s3 btn" id="look-for-auctions">Auctions</router-link>
            <router-link to="my-auctions" class="col s3 btn">My auctions</router-link>
        </div>
    </div>
</template>

<script>
export default {
    name: "landing"
}
</script><
<style lang="scss">
#look-for-auctions {
    height: auto;
}
</style>