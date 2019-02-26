<template>
    <div class="row">
        <div class="col s12">
            <h1>Welcome to AuctionEx!</h1>
        </div>
        <div class="col s12">
            <div class="row">
                <router-link to="auctions" class="col s3 btn" id="look-for-auctions">Auctions</router-link>
                <router-link to="my-auctions" class="col s3 btn">My auctions</router-link>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    name: "landing",
}
</script>

<style lang="scss">
#look-for-auctions {
    height: auto;
}
</style>
