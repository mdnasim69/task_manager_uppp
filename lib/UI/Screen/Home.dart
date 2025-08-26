import 'package:flutter/material.dart';
import 'package:task_manager/UI/Screen/AddNewTask_scree.dart';
import 'package:task_manager/UI/Screen/cancelledtask_screen.dart';
import 'package:task_manager/UI/Screen/completedtask_screen.dart';
import 'package:task_manager/UI/Screen/newtask_screen.dart';
import 'package:task_manager/UI/Screen/progresstask_screen.dart';
import 'package:task_manager/UI/widget/TaskAppBar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String name = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  List<Widget> screens = [
    const NewTask(),
    const Progresstask(),
    const Completed(),
    const Cancelled(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TaskAppBar(UpdateProfileScreen: true,),
      body: screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        elevation: 100,
        shadowColor: Colors.black,
        indicatorColor: Colors.greenAccent,
        backgroundColor: Colors.white,
        selectedIndex: _currentIndex,
        onDestinationSelected: (int index) {
          _currentIndex = index;
          setState(() {});
        },
        destinations: const [
          NavigationDestination(
              icon: Icon(
                Icons.fiber_new_rounded,
                color: Colors.black,
              ),
              label: 'New'),
          NavigationDestination(
              icon: Icon(
                Icons.refresh_sharp,
                color: Colors.black,
              ),
              label: 'Progress'),
          NavigationDestination(
              icon: Icon(
                Icons.done_outline_rounded,
                color: Colors.black,
              ),
              label: 'Completed'),
          NavigationDestination(
              icon: Icon(
                Icons.cancel_presentation,
                color: Colors.black,
              ),
              label: 'Cancelled'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor:Colors.yellowAccent,
        onPressed: () {
          Navigator.pushNamed(context, AddnewtaskScree.name);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
