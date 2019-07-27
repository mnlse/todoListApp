<template>
  <div>
    <div class="display-4 mb-2">{{ todo_list.name }}</div>
    <form @submit.prevent="newTask" action="#">
      <input type="text" v-model="taskName" class="form-control">
      <input type="submit" class="btn btn-primary btn-block w-25 ml-auto mb-5 mt-2">
    </form>
    <slot></slot>
  </div>
</template>

<script>
import TodoListItem from './TodoListItem.vue'

export default {
  data: function() {
    return {
      taskName: "",
    }
  },
  components: {
    TodoListItem
  },
  props: ['todo_list'],
  methods: {
    newTask(evt) {
      let headers = {
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute("content")
      };

      console.log(headers);

      this.$http.post('/api/v1/todo_lists/' + this.$props.todo_list.id + '/todo_items', {
        name: this.taskName
      }, headers).then(response => {
        this.$emit('newTodoItem', response);
        this.taskName = "";
      });
    }
  }
}

</script>

<style scoped>
</style>
