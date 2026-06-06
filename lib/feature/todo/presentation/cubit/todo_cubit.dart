import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled1/feature/todo/presentation/cubit/todo_states.dart';

import '../views/archived_tasks_screen.dart';
import '../views/done_tasks_screen.dart';
import '../views/new_tasks_screen.dart';


class AppCubit extends Cubit<AppStates> {

  AppCubit() : super(AppinitState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<String> Title = ['New tasks', 'Done Tasks', 'Archived Tasks'];

  List<Widget> Screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];

  void ChangeIndex(int index) {
    currentIndex = index;
    emit(Appchangebottomsheet());
  }

  Database? database;

  List<Map> NewTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];

  void CreateDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('Create database');
        database
            .execute(
          'CREATE TABLE Tasks (id INTEGER PRIMARY KEY , title TEXT , date TEXT, time TEXT, status TEXT)',
        )
            .then((value) {
          print('table create');
        })
            .catchError((error) {
          print('Error is $error');
        });
      },
      onOpen: (database) {
        Getdatafromdatabase(database);
        print('Open database');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabase());
    });
  }

  InsertDatabase({
    required String title,
    required String date,
    required String time,
  }) async {
    await database!.transaction(
          (txn) => txn
          .rawInsert(
        'INSERT INTO Tasks(title,date,time,status)VALUES("$title","$date","$time","New")',
      )
          .then((value) {
        print('$value InsertSuccess');
        emit(AppInsertDatabase());
        Getdatafromdatabase(database);
      })
          .catchError((error) {
        print('$error is error');
      }),
    );
  }

  void Getdatafromdatabase(database)  {

    emit(AppGetdatabaseLoading());

    NewTasks.clear();
    archiveTasks.clear();
    doneTasks.clear();
    database.rawQuery('SELECT * FROM Tasks').then((value)
    {

      value.forEach((task){
        if (task['status']=='New')
        {
          NewTasks.add(task);
        }
        else if (task['status']=='archive')
        {
          archiveTasks.add(task);

        }
        else
        {
          doneTasks.add(task);

        }
      });
      emit(AppGetdatabase());
    });
  }

  void Updatadatabase({
    required String status,
    required int id,
  })
  {
    database!.rawUpdate(
      'UPDATE Tasks SET status = ? WHERE id = ?',
      [status, id],).then((value)
    {
      Getdatafromdatabase(database);
      emit(AppUpdataformdatabase());
    });
  }

  void Deletedatabase({
    required int id,
  })
  {
    database!.rawDelete('DELETE FROM Tasks WHERE id = ?', [id]).then((value)
    {
      Getdatafromdatabase(database);
      emit(AppDeleteformdatabase());
    });
  }

  bool isBottomSheet = false;
  IconData fibers = Icons.edit_note_outlined;

  void ChangeNavSheets({required bool isShow, required IconData icon}) {
    isBottomSheet = isShow;
    fibers = icon;
    emit(AppChangeNavsheets());
  }



}
