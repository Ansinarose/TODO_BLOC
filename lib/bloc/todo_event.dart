part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

final class AddToDo extends TodoEvent {
  final String title;
  final String description;
  AddToDo({required this.title, required this.description});
}


final class InitialToDo extends TodoEvent {}