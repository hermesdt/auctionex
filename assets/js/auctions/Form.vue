<template>
  <div class="row">
    <div class="col s12">
      <div cass="row">
        <div class="input-field col s12">
          <input v-model="auction.title" placeholder="Placeholder" id="title" type="text" class="validate">
          <label for="title">Title</label>
          <span v-for="(error, index) in errors.title" :key="index" class="helper-text" data-error="wrong">
            {{ error }}
          </span>
        </div>
      </div>
    </div>

    <div class="col s12">
      <div class="row">
        <div class="input-field col s12">
          <textarea v-model="auction.description" id="description" class="materialize-textarea"></textarea>
          <label for="description">Description</label>
          <span v-for="(error, index) in errors.description" :key="index" class="helper-text" data-error="wrong">
            {{ error }}
          </span>
        </div>
      </div>
    </div>

    <div class="col s12">
      <div class="row">
        <div class="col s12">
          <button v-on:click="submit()" class="btn waves-effect waves-light" type="submit" name="action">Submit
            <i class="material-icons right">send</i>
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
    name: 'AuctionForm',
    props: {
        auction: { type: Object, required: true },
        errors: { type: Object, required: false,
            default: function () {
                return { title: [], description: [] }
            }},
        submit: { type: Function, required: true}
    }
}
</script>
