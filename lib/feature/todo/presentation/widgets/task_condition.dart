import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/feature/todo/presentation/widgets/task_item.dart';

import 'custom_divider.dart';

Widget Buildtaskscondition({
  required List<Map>Tasks,
})=>
    ConditionalBuilder(
      condition: Tasks.length > 0,
      builder:
          (context) => ListView.separated(
        itemBuilder:
            (context, index) => TaskItem(model: Tasks[index]),
        separatorBuilder: (context, index) => MyDivider(),
        itemCount: Tasks.length,
      ),
      fallback:
          (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu_outlined,
              size: 100.0,
              color: Colors.grey[400],
            ),
            Text(
              'NO Tasks Yet , Please Add Task',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.grey[400],

              ),
            ),
          ],
        ),
      ),
    );