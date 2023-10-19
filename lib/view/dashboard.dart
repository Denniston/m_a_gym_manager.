import 'package:flutter/material.dart';
import 'package:m_a_gym_manager/view/gym_list_screen.dart';
import 'package:m_a_gym_manager/view/add_edit_gym_screen.dart';
import 'package:m_a_gym_manager/widgets/drawer.dart';
import 'package:provider/provider.dart';
import '../controller/gym_provider.dart';
import '../model/gym.dart';
import '../widgets/create_gym_widget.dart';
import 'student_list_screen.dart';
import 'class_list_screen.dart';
import 'coaches_list_screen.dart';
import 'gym_home_screen.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({
    Key? key,
  }) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

//TODO: Fix GymHome screen.

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;
  late final Gym? gym;

  @override
  void initState() {
    super.initState();
    gym = Gym(name: '', email: '', phone: 0, address: '', manager: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text('Martial Arts Gym'),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          GymsListScreen(),
          CoachesListScreen(),
          ClassListScreen(),
          StudentListScreen(),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomAppBar(),
    );
  }

  Widget? _buildFloatingActionButton() {
    switch (_currentIndex) {
      case 0:
        return FloatingActionButton(
          onPressed: () => _showCreateGymWidget(context),
          child: const Icon(Icons.add),
        );
      case 1:
        return FloatingActionButton(
          onPressed: () => _showCreateCoachWidget(context),
          child: const Icon(Icons.add),
        );
      case 2:
        return FloatingActionButton(
          onPressed: () => _showCreateClassWidget(context),
          child: const Icon(Icons.add),
        );
      case 3:
        return FloatingActionButton(
          onPressed: () => _showCreateStudentWidget(context),
          child: const Icon(Icons.add),
        );
      default:
        return null;
    }
  }

  void _showCreateGymWidget(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          //title: Text('Create Gym'),
          content: CreateGymWidget(), // Use the CreateGymWidget here
        );
      },
    );
  }

  void _showCreateCoachWidget(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Use CreateCoachWidget here
        return const AlertDialog(
          title: Text('Create Coach'),
          //content: CreateCoachWidget(), // Use the CreateCoachWidget here
        );
      },
    );
  }

  void _showCreateClassWidget(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Use CreateClassWidget here
        return const AlertDialog(
          title: Text('Create Class'),
          //content: CreateClassWidget(), // Use the CreateClassWidget here
        );
      },
    );
  }

  void _showCreateStudentWidget(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Use CreateStudentWidget here
        return const AlertDialog(
          title: Text('Create Student'),
          //content: CreateStudentWidget(), // Use the CreateStudentWidget here
        );
      },
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _buildBottomAppBar() {
    return BottomAppBar(
      color: Colors.teal,
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.home),
            color: Colors.white,
            focusColor: Colors.cyan,
            onPressed: () => _onTabTapped(0),
          ),
          IconButton(
            icon: const Icon(Icons.person),
            color: Colors.white,
            focusColor: Colors.cyan,
            onPressed: () => _onTabTapped(1),
          ),
          const SizedBox(width: 48), // Spacer for the FAB
          IconButton(
            icon: const Icon(Icons.school),
            color: Colors.white,
            focusColor: Colors.cyan,
            onPressed: () => _onTabTapped(2),
          ),
          IconButton(
            icon: const Icon(Icons.people),
            onPressed: () => _onTabTapped(3),
            color: Colors.white,
            focusColor: Colors.cyan,
          ),
        ],
      ),
    );
  }
}
