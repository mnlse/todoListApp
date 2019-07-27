<template>
  <div id="app">
    <form @submit="sendForm($event)" action="/todo_lists">
      <input type="text" name="todo_list[name]" v-model="newTodoListName">
      <input type="submit" value="Submit">
    </form>

    <TodoList v-for="todolist in todolists" :name="todolist.name"></TodoList>
  </div>
</template>

<script>
import TodoList from 'components/TodoList.vue'

export default {
  data: function () {
    let token = document.querySelector('[name=csrf-token]');

    let headers = {
      'csrf-token': token.getAttribute('content')
    }

    var data = {
      todolists: []
    }
    this.$http.get('/api/v1/todo_lists', {}, headers).then(response => {
      data['todolists'] = response;
    });

    console.log(data.todolists);

    return {
      message: "Hello Vue!",
      todolists: [],
      newTodoListName: "",
    }
  },
  components: {
    TodoList
  },
  created: function() {
    let token = document.querySelector('[name=csrf-token]');

    let headers = {
      'csrf-token': token.getAttribute('content')
    }

    this.$http.get('/api/v1/todo_lists', {}, headers).then(response => {
      this.todolists = response.data;
    });
  },
  methods: {
    sendForm(evt) {
      let token = document.querySelector('[name=csrf-token]');

      let headers = {
        'X-CSRF-Token': token.getAttribute('content')
      }

      evt.preventDefault();
      this.$http.post('/api/v1/todo_lists', {
        name: this.newTodoListName,
        'csrf-token': token.getAttribute('content')
      }, headers).then(response => {
        if(response.status == 200) {
          this.todolists.push(response.data)
          console.log(this.todolists);
        }
      });
    },
  }
}
</script>

<style scoped>
</style>
