import 'package:flutter/material.dart';
import 'package:m_a_gym_manager/database/gym_app_db.dart';
import 'package:provider/provider.dart';
import '../controller/gym_provider.dart';
import '../model/gym.dart';

class GymHomeScreen extends StatelessWidget {
  const GymHomeScreen({super.key, required this.gym});
  final Gym gym; // Receive the selected gym data

  @override
  Widget build(BuildContext context) {
    final gymProvider = Provider.of<GymProvider>(context);

    // Fetch gyms from provider before using them
    gymProvider.fetchGyms();

    // Access gyms
    final gyms = gymProvider.gyms;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Gym Profile - ${gym.name}'), // Display gym's name in the app bar
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   height: 200,
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //       image: gym.profileImage != null && gym.profileImage.isNotEmpty
            //           ? NetworkImage(gym.profileImage)
            //           : AssetImage('assets/images/gym_image.png'),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),

            Container(
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/gym_image.png'), // Replace with the actual image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Manager: ${gym.manager}', // Display the selected gym's data
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    //gymProvider.address,
                    'Address: ${gym.address}',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  Divider(),
                  const Text(
                    'About Us',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Welcome to our gym! We offer a variety of fitness classes and training programs to help you achieve your health and fitness goals.',
                    style: TextStyle(fontSize: 16),
                  ),
                  const Divider(),
                  const Text(
                    'Contact Information',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Email: contact@gym.com\nPhone: +1 123-456-7890\nWebsite: www.gym.com',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
