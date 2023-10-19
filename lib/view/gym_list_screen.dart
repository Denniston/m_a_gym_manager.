import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:m_a_gym_manager/widgets/drawer.dart';
import 'package:m_a_gym_manager/widgets/gym_widget.dart';
import 'package:provider/provider.dart';

import '../controller/gym_provider.dart';
import '../widgets/drawer_list_tile.dart';
import 'gym_home_screen.dart';
import 'home_.dart'; // Import the custom DrawerListTile

class GymsListScreen extends StatelessWidget {
  const GymsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gymProvider = Provider.of<GymProvider>(context);
    //final _profileImage = gymProvider.fetchGyms();

    // Decode the image string to Uint8List

    // Fetch gyms from provider before using them
    gymProvider.fetchGyms();

    return Scaffold(
      appBar: AppBar(title: const Text('Gyms List')),
      body: ListView.builder(
        itemCount: gymProvider.gyms.length,
        itemBuilder: (context, index) {
          final gym = gymProvider.gyms[index];

          Uint8List? imageBytes;
          if (gym.profileImage != null) {
            imageBytes = base64Decode(gym.profileImage!);
          }

          return GymWidget(
            gym: gym,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Home(),
                ),
              );
            },
            onLongPress: () {},
          );
          // return ListTile(
          //   leading: CircleAvatar(
          //       radius: 30, // Adjust the size as needed
          //       backgroundImage:
          //           MemoryImage(imageBytes!) // Use MemoryImage for Uint8List
          //       ),
          //   title: Text(gym.name),
          //   subtitle: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(gym.address),
          //       Text('Manager: ${gym.manager}'),
          //     ],
          //   ),
          //   isThreeLine: true,
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const Home(),
          //       ),
          //     );
          //   },
          // );
        },
      ),
    );
  }
}
