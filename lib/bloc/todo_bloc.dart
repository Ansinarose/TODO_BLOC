import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:todo_app_bloc/models/todo_model.dart';
import 'package:todo_app_bloc/services/repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    on<AddToDo>(addTodo);
    on<InitialToDo>(initialToDoFetch);

  }

  initialToDoFetch(InitialToDo event, Emitter<TodoState> emit) async {
    emit(ToDoLoading());
    try {
      final values = await fetchdata();
      final List<TodoModel> items = [];
      for (int i = 0; i < values.length; i++) {
        items.add(TodoModel(
            id: values[i]["_id"],
            title: values[i]['title'],
            description: values[i]['description']));
      }
      emit(ToDoFetched(todoList: items));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  addTodo(AddToDo event, Emitter<TodoState> emit) async {
    emit(ToDoAdded());
    emit(ToDoLoading());
    try {
      final result = await submitData(event.title, event.description);
      if (result == 'success') {
        emit(Addsuccess());
        add(InitialToDo());
      }
    } catch (e) {
      emit(ToDoAddingError(e.toString()));
      add(InitialToDo());
    }
  }

  
  @override
  void onTransition(Transition<TodoEvent, TodoState> transition) {
    if (kDebugMode) {
      print(transition);
    }
    super.onTransition(transition);
  }
}