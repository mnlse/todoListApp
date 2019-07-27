<template>
  <div id="app">
    <div v-if="page === 'todoListsIndex'">
      <div class="list-group w-50 mx-auto mt-5">
        <form @submit="sendForm($event)" action="/todo_lists" class="mb-5">
          <input type="text" name="todo_list[name]" v-model="newTodoListName" class="form-control" autocomplete="off">
          <input type="submit" value="Submit" class="btn btn-primary btn-block w-25 ml-auto">
        </form>
        <TodoList v-for="todolist in todoLists" :name="todolist.name"
        :id="todolist.id"
        @deleteList="deleteList($event)"
        @seeList="seeList($event)"></TodoList>
      </div>
    </div>

    <div v-else>
      <div class="w-50 mx-auto mt-5">
        <a class="btn btn-primary text-white" @click.prevent="page = 'todoListsIndex'">See list</a>
        <ShowTodoList :todo_list="currentTodoList"
                      @newTodoItem="createTodoItem($event)">
          <div class="list-group">
            <TodoListItem v-for="todoListItem in currentTodoListItems" :name="todoListItem.name" 
                          :id="todoListItem.id" 
                          :is_done="todoListItem.is_done"
                          @deleteTodoListItem="deleteTodoListItem($event)">
            </TodoListItem>
        </div>
        </ShowTodoList>
      </div>
    </div>

  </div>
</template>

<script>
import TodoList from 'components/TodoList.vue'
import ShowTodoList from 'components/ShowTodoList.vue'
import TodoListItem from 'components/TodoListItem.vue'

export default {
  data: function () {
    return {
      message: "Hello Vue!",
      todoLists: [],
      page: "todoListsIndex",
      currentTodoList: {},
      currentTodoListItems: [],
      newTodoListName: "",
      ajaxHeaders: {},
    }
  },
  components: {
    TodoList,
    ShowTodoList,
    TodoListItem
  },
  created: function() {
    let headers = {
      'X-CSRF-Token': document.querySelector('[name=csrf-token]').getAttribute("content")
    }

    this.ajaxHeaders = headers;

    this.$http.get('/api/v1/todo_lists').then(response => {
      this.todoLists = response.data;
    });
  },
  methods: {
    sendForm(evt) {

      evt.preventDefault();
      if(this.newTodoListName.length > 0) {
        this.$http.post('/api/v1/todo_lists', {
          name: this.newTodoListName,
        }, this.ajaxHeaders).then(response => {
          if(response.status == 200) {
            this.todoLists.push(response.data)
            this.newTodoListName = "";
            console.log(this.todoLists);
          }
        });
      }
    },
    deleteList(id) {
      this.$http.delete('/api/v1/todo_lists/' + id, {}, this.ajaxHeaders).then(response => {
        console.log(response);
      });

      this.todoLists.forEach((todoList, index, object) => {
        if(todoList.id === id) {
          object.splice(index, 1);
        }
      });
    },
    seeList(id) {
      this.page = "showList"
      this.$http.get('/api/v1/todo_lists/' + id).then(response => {
        this.currentTodoList = response.data.todo_list;
        this.currentTodoListItems = response.data.todo_items;
        console.log(response);
      });
    },
    createTodoItem(data) {
      console.log(data);
      this.currentTodoListItems.push({
        name: data.body.name,
        is_done: data.body.is_done,
        id: data.body.id
      })
    },
    deleteTodoListItem(id) {
      this.$http.delete('/api/v1/todo_lists/' + this.currentTodoList.id + '/todo_items/' + id).then(response => {
        this.currentTodoListItems.forEach((item, index, object) => {
          if(item.id === id) {
            object.splice(index, 1);
          }
        })
      });
    }
  },
}
</script>

<style scoped>
</style>
