import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/core/widgets/custom_snackbar.dart';
import '../cubit/todo_cubit.dart';
import '../cubit/todo_states.dart';
import '../widgets/add_task_bottom.dart';

class HomeLayout extends StatelessWidget {

  var scaffoldKey = GlobalKey<ScaffoldState>();

  var titleController = TextEditingController();

  var timeController = TextEditingController();

  var dateController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..CreateDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppInsertDatabase) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).
            showSnackBar(
                customSnack(errorMsg: 'The task was added successfully.',color: Colors.green,icon: Icons.done_outline_rounded));
          }
        },
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          final primaryColor = Theme.of(context).primaryColor;

          return Scaffold(
            key: scaffoldKey,
            backgroundColor: const Color(0xFFF8F9FA),
            extendBody: true,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              centerTitle: false,
              title: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  cubit.Title[cubit.currentIndex],
                  style: const TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF212529), // لون داكن مريح للعين
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.blur_on_rounded, color: Color(0xFF212529), size: 28),
                  onPressed: () {},
                ),
              ],
            ),
            body: SafeArea(
              child: ConditionalBuilder(
                condition: state is! AppGetdatabaseLoading,
                builder: (context) => cubit.Screens[cubit.currentIndex],
                fallback: (context) => const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: FloatingActionButton(
                onPressed: () {
                  if (cubit.isBottomSheet) {
                    if (formKey.currentState!.validate()) {
                      cubit.InsertDatabase(
                        date: dateController.text,
                        time: timeController.text,
                        title: titleController.text,
                      );

                    }
                  } else {
                    scaffoldKey.currentState!
                        .showBottomSheet(
                          (context) => AddTaskBottomSheet(
                        formKey: formKey,
                        titleController: titleController,
                        timeController: timeController,
                        dateController: dateController,
                      ),
                      elevation: 30.0,
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30.0),
                        ),
                      ),
                    )
                        .closed
                        .then((value) {
                      cubit.ChangeNavSheets(
                        isShow: false,
                        icon: Icons.edit_note_outlined,
                      );
                    });
                    cubit.ChangeNavSheets(isShow: true, icon: Icons.add_outlined);

                  }

                },
                elevation: 6,
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Icon(cubit.fibers, size: 28),

              ),
            ),
            bottomNavigationBar: Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              height: 72,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: cubit.currentIndex,
                  backgroundColor: Colors.white,
                  selectedItemColor: primaryColor,
                  unselectedItemColor: const Color(0xFFAEAEC2),
                  selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                  unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 11),
                  elevation: 2,
                  showUnselectedLabels: true,
                  onTap: (index) {
                    cubit.ChangeIndex(index);
                  },
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.space_dashboard_outlined, size: 26),
                      activeIcon: Icon(Icons.space_dashboard_rounded, size: 24),
                      label: 'Tasks',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.check_circle_outline_rounded, size: 24),
                      activeIcon: Icon(Icons.check_circle_rounded, size: 26),
                      label: 'Done',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.archive_outlined, size: 24),
                      activeIcon: Icon(Icons.archive_rounded, size: 26),
                      label: 'Archive',
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}