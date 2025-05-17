import 'package:flutter/material.dart';
import 'package:todo_list_sqlite/modals/add_task_modal.dart';
import 'package:todo_list_sqlite/screens/calendar.dart';
import 'package:todo_list_sqlite/screens/todos.dart';
import 'package:todo_list_sqlite/widgets/todo_title.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _activePageIndex = 0;

  final List<Widget> _pages = [
    TodosScreen(title: const TodoTitle()),
    CalendarScreen(),
  ];

  void _selectPage(int index) {
    setState(() {
      _activePageIndex = index;
    });
  }

  void _openAddTaskModal() {
    showModalBottomSheet(
      isScrollControlled: false,
      scrollControlDisabledMaxHeightRatio: 1.0,
      context: context,
      builder: (ctx) => const AddTaskModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _activePageIndex, children: _pages),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddTaskModal,
        backgroundColor:
            Theme.of(
              context,
            ).colorScheme.copyWith(surface: Colors.indigo.shade600).surface,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        onTap: _selectPage,
        currentIndex: _activePageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Tasks'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
        ],
      ),
    );
  }
}
