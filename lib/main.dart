import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/bloc/todo_bloc.dart';
import 'package:todo_app_bloc/screens/home_screen.dart';


void main() {
  runApp(BlocProvider(
    create: (context) => TodoBloc(),
    child: const ToDoApplication(),
  ));
}

class ToDoApplication extends StatelessWidget {
  const ToDoApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}