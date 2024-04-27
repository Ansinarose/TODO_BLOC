// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/bloc/todo_bloc.dart';
import 'package:todo_app_bloc/models/todo_model.dart';


class AddScreen extends StatefulWidget {
  final TodoModel? todo;
  const AddScreen({
    super.key,
    this.todo,
  });

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController titleController = TextEditingController();
  final descriptionController = TextEditingController();
 

  @override
  void initState() {
    super.initState();
   
    titleController.text = widget.todo != null ? widget.todo!.title : "";
    descriptionController.text =
        widget.todo != null ? widget.todo!.description : "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
           'Add Details ',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: BlocListener<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is ToDoAdded) {
            Navigator.pop(context);
          }
        },
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Title',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                    hintText: 'add title', border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Descriprion',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: descriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                    hintText: 'enter description',
                    border: OutlineInputBorder()),
              ),
              SizedBox(height: 50,),
              Center(
                child: ElevatedButton.icon(
                  
                    onPressed: () {
                    
                           context.read<TodoBloc>().add(AddToDo(
                              title: titleController.text,
                              description: descriptionController.text));
                          
                    },
                    icon: Icon(Icons.send),
                    label: Text('submit', ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white) 
                    ),
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}