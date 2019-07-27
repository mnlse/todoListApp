<template>
  <div class="list-group-item">
    <div class="d-flex align-items-center justify-content-between">
      <div class="list-name">
        {{ name }}
      </div>
      <div class="btn-group justify-self-end">
        <div class="btn btn-primary" style="height: fit-content;" @click="$emit('seeList', id)">See</div>
        <div class="btn btn-danger" style="height: fit-content;" @click="$emit('deleteList', id)">Delete</div>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    data: function () {
      return {
      }
    },
    props: ['name', 'id']
  }
</script>

<style scoped>
.list-name {
  font-size: 20px;
}
</style>

