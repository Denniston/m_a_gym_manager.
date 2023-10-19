import 'package:flutter/material.dart';
import 'package:m_a_gym_manager/controller/class_provider.dart';
import 'package:m_a_gym_manager/controller/grade_provider.dart';
import 'package:m_a_gym_manager/database/database_service.dart';
import 'package:m_a_gym_manager/database/gym_app_db.dart';
import 'package:m_a_gym_manager/view/calendar_page.dart';
import 'package:m_a_gym_manager/view/home.dart';
import 'package:m_a_gym_manager/view/home_.dart';
import 'package:m_a_gym_manager/view/home_screen.dart';
import 'package:provider/provider.dart';

import 'controller/appstate.dart';
import 'controller/coach_provider.dart';
import 'controller/image_provider.dart';
import 'controller/student_provider.dart';
import 'controller/syllabus_provider.dart';
import 'database/database_helper.dart';
import 'controller/gym_provider.dart';
import 'model/gym.dart';
import 'view/dashboard.dart';

Future<void> main() async {
  // Ensure widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  //final Gym? gym;

  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedItemIndex = 0;
  final List pages = [
    HomePage(),
    null,
    null,
    const CalendarPage(),
    null,
  ];
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DatabaseService()),
        ChangeNotifierProvider(create: (context) => GymAppDB()),
        ChangeNotifierProvider(create: (context) => MAImageProvider()),
        ChangeNotifierProvider(create: (context) => GymProvider()),
        ChangeNotifierProvider(create: (context) => CoachProvider()),
        ChangeNotifierProvider(create: (context) => ClassProvider()),
        ChangeNotifierProvider(create: (context) => GradeProvider()),
        ChangeNotifierProvider(create: (context) => StudentProvider()),
        ChangeNotifierProvider(create: (context) => SyllabusProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GYM',
        theme: ThemeData(
          // primarySwatch: Colors.teal,
          primaryColor: Colors.teal,
          //colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal),
          useMaterial3: true,
        ),
        home: Home(),
        // home: Scaffold(
        //     // bottomNavigationBar: BottomNavigationBar(
        //     //   elevation: 0,
        //     //   backgroundColor: const Color(0xFFF0F0F0),
        //     //   unselectedItemColor: Colors.grey,
        //     //   selectedItemColor: Colors.black,
        //     //   selectedIconTheme: IconThemeData(color: Colors.blueGrey[600]),
        //     //   currentIndex: _selectedItemIndex,
        //     //   type: BottomNavigationBarType.fixed,
        //     //   onTap: (int index) {
        //     //     setState(() {
        //     //       _selectedItemIndex = index;
        //     //     });
        //     //   },
        //     //   items: const [
        //     //     BottomNavigationBarItem(
        //     //       label: '',
        //     //       icon: Icon(Icons.home),
        //     //     ),
        //     //     BottomNavigationBarItem(
        //     //       label: '',
        //     //       icon: Icon(Icons.insert_chart),
        //     //     ),
        //     //     BottomNavigationBarItem(
        //     //       label: '',
        //     //       icon: Icon(Icons.done),
        //     //     ),
        //     //     BottomNavigationBarItem(
        //     //       label: '',
        //     //       icon: Icon(Icons.calendar_today),
        //     //     ),
        //     //     BottomNavigationBarItem(
        //     //       label: '',
        //     //       icon: Icon(Icons.chat_bubble),
        //     //     ),
        //     //   ],
        //     // ),
        //     body: pages[_selectedItemIndex]),
      ),
    );
  }
}
