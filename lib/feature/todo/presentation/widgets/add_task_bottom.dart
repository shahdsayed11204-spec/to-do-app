import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'default_TextFormField.dart';

class AddTaskBottomSheet extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController timeController;
  final TextEditingController dateController;

  const AddTaskBottomSheet({
    super.key,
    required this.formKey,
    required this.titleController,
    required this.timeController,
    required this.dateController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DefaultTextFormField(
              controller: titleController,
              type: TextInputType.text,
              label: 'Task title',
              prefix: Icons.title,
              validator: (value) =>
              value!.isEmpty ? 'title must not be empty' : null,
            ),
            const SizedBox(height: 15),

            DefaultTextFormField(
              controller: timeController,
              type: TextInputType.datetime,
              label: 'Task time',
              prefix: Icons.watch_later_outlined,
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode());

                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (time != null) {
                  timeController.text = time.format(context);
                }
              },
              validator: (value) =>
              value!.isEmpty ? 'time must not be empty' : null,
            ),
            const SizedBox(height: 15),

            DefaultTextFormField(
              controller: dateController,
              type: TextInputType.datetime,
              label: 'Task date',
              prefix: Icons.date_range_outlined,
              onTap: () async {
                FocusScope.of(context).unfocus();

                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030),
                );

                if (date != null) {
                  dateController.text =
                      DateFormat.yMMMd().format(date);
                }
              },
              validator: (value) =>
              value!.isEmpty ? 'date must not be empty' : null,
            ),
          ],
        ),
      ),
    );
  }
}