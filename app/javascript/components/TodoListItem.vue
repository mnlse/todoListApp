<template>
  <div class="list-group-item">
    <p class="todoListItemName">{{ name }}</h4>
    <div class="btn-group ml-auto">
      <div class="btn btn-danger" @click='$emit("deleteTodoListItem", id)'>Delete</div>
    </div>
  </div>
</template>

<script>
export default {
  data: function() {
    return {
    }
  },
  props: ['name', 'is_done', 'id']
}
</script>

<style scoped>
.todoListItemName {
  font-size: 20px;
}
</style>
