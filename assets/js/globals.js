import Vue from 'vue'

const globals = Vue.observable({
  userId: null,
  flash: {
    info: null,
    error: null
  }
})

export default globals