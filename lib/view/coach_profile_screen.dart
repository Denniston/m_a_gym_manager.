import 'package:flutter/material.dart';
import 'package:m_a_gym_manager/widgets/profile_widget2.dart';

import '../model/coach.dart';

class CoachProfileScreen extends StatelessWidget {
  final Coach coach;

  final String specialization;
  final String firstName;
  final String lastName;
  final String email;
  final String? grade;
  final String phone;
  final String? address;
  final String? profileURL;
  final String? coverURL;
  CoachProfileScreen({
    required this.coach,
    required this.specialization,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.grade,
    required this.phone,
    this.address,
    this.profileURL,
    this.coverURL,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coach Profile'),
      ),
      body: ProfileWidget2(
        firstName: firstName,
        lastName: lastName,
        specialization: specialization,
        phone: phone,
        email: email,
        grade: grade,
      ),
      // body: Column(
      //   children: [
      //     Text('Coach Name: ${coach.name}'),
      //     Text('Specialization: ${coach.specialization}'),
      //     // Add more coach details here
      //   ],
      // ),
    );
  }
}
