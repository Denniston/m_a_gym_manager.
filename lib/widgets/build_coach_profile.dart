import 'package:flutter/material.dart';

Widget buildCoachProfileItem(
    String coachName, String profileImage, String phone) {
  return GestureDetector(
    onTap: () {
      // Handle the tap event, e.g., navigate to the coach's profile screen
      print('Coach profile item pressed');
    },
    child: Container(
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(12),
      height: 140,
      width: 140,
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1), // Adjust the color
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Text(
            //   "Coach Profile", // Change to a suitable label
            //   style: TextStyle(fontSize: 10, color: Colors.grey),
            // ),
            const SizedBox(
              height: 5,
            ),
            // You can display coach's profile image here
            Center(
              child: CircleAvatar(
                radius: 20, // Adjust the size as needed
                backgroundImage:
                    NetworkImage(profileImage), // Provide the image URL
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              coachName,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text(
              phone,
              style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey), // Adjust the style as needed
            ),
          ],
        ),
      ),
    ),
  );
}
