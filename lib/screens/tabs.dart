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
  Widget _activePage = TodosScreen(title: const TodoTitle());
  var _selectedPageIndex = 0;

  void _setActivePage(Widget page) {
    setState(() {
      _activePage = page;
    });
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });

    if (index == 0) {
      _setActivePage(TodosScreen(title: const TodoTitle()));
    } else {
      _setActivePage(CalendarScreen());
    }
  }

  void _openAddTaskModal() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => const AddTaskModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _activePage,
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddTaskModal,
        backgroundColor:
            Theme.of(
              context,
            ).colorScheme.copyWith(surface: Colors.indigo.shade600).surface,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Todos'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
        ],
      ),
    );
  }
}
