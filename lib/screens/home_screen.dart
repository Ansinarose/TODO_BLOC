import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/bloc/todo_bloc.dart';
import 'package:todo_app_bloc/screens/add_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TodoBloc>().add(InitialToDo());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'ToDo App',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blueGrey,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueGrey,
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddScreen()));
          },
          child: const Icon(Icons.add),
        ),
        body: BlocConsumer<TodoBloc, TodoState>(
          listener: (context, state) {
            
         
            if (state is Addsuccess) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                  "Added successfully",
                  style: TextStyle(color: Colors.black),
                ),
                backgroundColor: Colors.green,
              ));
            }
          },
          builder: (context, state) {
            if (state is ToDoLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ToDoFetched) {
              if (state.todoList.isEmpty) {
                return const Center(
                  child: Text("No Data"),
                );
              }
              return ListView.builder(
                  itemCount: state.todoList.length,
                  itemBuilder: (context, index) {
                    final item = state.todoList[index];
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                            backgroundColor: Colors.blueGrey,
                            child: Text(
                              "${index + 1}",
                            )),
                        title: Text(item.title),
                        subtitle: Text(item.description),
                       
                      ),
                    );
                  });
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}