<template>
  <div class="row">
    <div class="col s12">
      <div cass="row">
        <div class="input-field col s12">
          <input placeholder="Placeholder" id="title" type="text" class="validate">
          <label for="title">Title</label>
          <span v-for="(error, index) in errors.title" :key="index" class="helper-text" data-error="wrong" data-success="right">
            {{ error }}
          </span>
        </div>
      </div>
    </div>

    <div class="col s12">
      <div class="row">
        <div class="input-field col s12">
          <textarea id="description" class="materialize-textarea"></textarea>
          <label for="description">Description</label>
          <span v-for="(error, index) in errors.description" :key="index" class="helper-text" data-error="wrong" data-success="right">
            {{ error }}
          </span>
        </div>
      </div>
    </div>

    <div class="col s12">
      <div class="row">
        <div class="col s12">
          <button class="btn waves-effect waves-light" type="submit" name="action">Submit
            <i class="material-icons right">send</i>
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Vue from 'vue'

export default {
  name: "auctions-new",
  data () {
    return {
      errors: { title: [], description: [] }
    }
  },
  mounted () {
    Vue.http.post("/auctions")
    .then(()  => {

    }, ({errors}) => {

    })
  }
}
</script>

<style lang="scss">
</style>
