import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/todo_cubit.dart';
import '../cubit/todo_states.dart';
import '../widgets/task_condition.dart';


class NewTasksScreen extends StatelessWidget {
  const NewTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener:(context,state){},
      builder: (context,state){
        var Tasks=AppCubit.get(context).NewTasks;
        return Buildtaskscondition(Tasks: Tasks,);
      },
    );
  }
}
