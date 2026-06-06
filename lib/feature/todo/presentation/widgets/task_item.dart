import 'package:flutter/material.dart';
import '../cubit/todo_cubit.dart';

class TaskItem extends StatelessWidget {
  final Map model;

  const TaskItem({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Dismissible(
      key: Key(model['id'].toString()),
      background: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: const Icon(Icons.delete_outline_rounded, color: Colors.white, size: 28),
      ),
      secondaryBackground: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: Colors.red[400],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: const Icon(Icons.delete_outline_rounded, color: Colors.white, size: 28),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).Deletedatabase(
          id: model['id'],
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 13.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.09),
                borderRadius: BorderRadius.circular(19.0),
              ),
              child: Center(
                child: Text(
                  '${model['time']}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
             SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis, // حماية النص من تدمير الـ UI إذا كان طويلاً
                    style: const TextStyle(
                      color: Color(0xFF212529),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.calendar_today_rounded, size: 14, color: Colors.grey[400]),
                      const SizedBox(width: 6),
                      Text(
                        '${model['date']}',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 2),
            IconButton(
              onPressed: () {
                AppCubit.get(context).Updatadatabase(
                  status: 'done',
                  id: model['id'],
                );
              },
              icon: const Icon(
                Icons.check_circle_outline_rounded,
                color: Colors.green, // لون أخضر صريح وواضح للإنهاء
                size: 26,
              ),
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context).Updatadatabase(
                  status: 'archive',
                  id: model['id'],
                );
              },
              icon: Icon(
                Icons.archive_outlined,
                color: Colors.grey[400],
                size: 26,
              ),
            ),
          ],
        ),
      ),
    );
  }
}