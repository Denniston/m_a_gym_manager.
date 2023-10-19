import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:m_a_gym_manager/view/add_edit_gym_screen.dart';
import 'package:m_a_gym_manager/widgets/drawer.dart';
import 'package:provider/provider.dart';
import '../controller/gym_provider.dart';
import '../model/gym.dart';
import '../widgets/build_coach_profile.dart';
import '../widgets/build_gym_info.dart';
import '../widgets/build_title_row.dart';
import '../widgets/image_picker_button.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? _selectedImage; // Define _selectedImage here

  @override
  Widget build(BuildContext context) {
    final gymProvider = Provider.of<GymProvider>(context);

    // Fetch gyms from provider before using them
    gymProvider.fetchGyms();

    // Access gyms
    final gyms = gymProvider.gyms;

    // Receive the selected gym data
    final Gym gym;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.home,
          ),
          tooltip: 'Home',
          onPressed: () {},
        ),
        title: const Text('MMAX Gym'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Edit Gym',
            onPressed: () {
              // Navigate to addeditgymscreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const AddEditGymScreen(), // Pass gym data
                ),
              );
            },
          ),
        ],
      ),
      //drawer: const MyDrawer(),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: _selectedImage != null // Check if there's a selected image
                  ? DecorationImage(
                      image: FileImage(_selectedImage!), // Use selected image
                      fit: BoxFit.cover,
                    )
                  : const DecorationImage(
                      opacity: 0.5,
                      image: AssetImage("assets/images/gym_image.png"),
                    ),
              color: Colors.teal.shade100,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildGymInfoColumn('manager', 'email', 'phone', 'address'),
            ),
          ),

          // ...

          // ImagePickerButton(
          //   onImageSelected: (File? image) {
          //     if (image != null) {
          //       setState(() {
          //         _selectedImage = image; // Update the selected image
          //       });
          //     }
          //   },
          //   initialImage: 'path_to_initial_image.png', // Set the initial image
          // ),
          // Container(
          //   height: MediaQuery.of(context).size.height / 4,
          //   width: MediaQuery.of(context).size.width,
          //   decoration: BoxDecoration(
          //     image: const DecorationImage(
          //       opacity: 0.5,
          //       //colorFilter: ColorFilter.linearToSrgbGamma(),
          //       image: AssetImage("assets/images/gym_image.png"),
          //     ),
          //     color: Colors.teal.shade100,
          //     borderRadius: BorderRadius.circular(30),
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: buildGymInfoColumn('manager', 'email', 'phone', 'address'),
          //   ),
          //),
          const SizedBox(
            height: 20,
          ),
          buildTitleRow("Coaches", 6),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: MediaQuery.of(context).size.width / 3,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                buildCoachProfileItem(
                    'Denniston Sutherland', '', '07472418957'),
                buildCoachProfileItem(
                    'Denniston Sutherland', '', '07472418957'),
                buildCoachProfileItem(
                    'Denniston Sutherland', '', '07472418957'),
                buildCoachProfileItem(
                    'Denniston Sutherland', '', '07472418957'),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          buildTitleRow("TODAY CLASSES", 3),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                buildClassItem(),
                buildClassItem(),
                buildClassItem(),
                buildClassItem(),
                buildClassItem(),
                buildClassItem(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector buildClassItem() {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(10),
        height: 100,
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9FB),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "07:00",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "AM",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ],
            ),
            Container(
              height: 100,
              width: 1,
              color: Colors.grey.withOpacity(0.5),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 160,
                  child: const Text(
                    "The Basic of Typography II",
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.grey,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 160,
                      child: const Text(
                        "Room C1, Faculty of Art & Design Building",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    )
                  ],
                ),
                const Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=200&q=80"),
                      radius: 10,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Gabriel Sutton",
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
// Uint8List? imageBytes;
// if (gym.profileImage != null) {
// imageBytes = base64Decode(gym.profileImage!);
// }
