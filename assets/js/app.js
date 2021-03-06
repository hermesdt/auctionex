// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
// import css from "../css/app.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

import Vue from "vue"
import VueResource from 'vue-resource'
import VueRouter from 'vue-router'
import VueBreadcrumbs from 'vue-breadcrumbs'
import globals from './globals'

Vue.use(VueResource);
Vue.use(VueRouter);
Vue.use(VueBreadcrumbs, {
    template: '<nav class="breadcrumb" v-if="$breadcrumbs.length"> ' +
    '<span>&nbsp;/&nbsp;</span>' +
    '<router-link to="/">Home</router-link>' +
    '<span>&nbsp;/&nbsp;</span>' +
    '<router-link class="breadcrumb-item" v-for="(crumb, key) in $breadcrumbs" :to="linkProp(crumb)" :key="key">' +
    '{{ crumb | crumbText }}' +
    '<span v-if="key != $breadcrumbs.length - 1">&nbsp;/&nbsp;</span>' +
    '</router-link> ' +
    '</nav>'
});

Vue.http.interceptors.push(function() {
    return function(response) {
        var {'x-flash': flash} =  response.headers.map
        if (!flash) return

        flash = JSON.parse(flash)
        Object.keys(flash).forEach(function(key){
            window.M.toast({html: flash[key]})
        })
    }
});

import App from './App.vue'

window.app = new Vue({
    el: '#app',
    render: h => h(App)
})
