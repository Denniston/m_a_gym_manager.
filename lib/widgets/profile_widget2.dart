import 'package:flutter/material.dart';

class ProfileWidget2 extends StatelessWidget {
  const ProfileWidget2({
    Key? key,
    this.profileImage,
    required this.firstName,
    this.lastName,
    required this.specialization,
    required this.phone,
    required this.email,
    this.grade,
  }) : super(key: key);
  final AssetImage? profileImage;
  final String firstName;
  final String? lastName;
  final String specialization;
  final String phone;
  final String email;
  final String? grade;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          radius: 60,
          backgroundColor: Colors.teal,
          backgroundImage: AssetImage(profileImage as String),
        ),
        Text(
          firstName,
          style: const TextStyle(
              color: Colors.white, fontSize: 30, fontFamily: 'Pacifico'),
        ),
        Text(
          specialization,
          overflow: TextOverflow.fade,
          maxLines: 1,
          style: const TextStyle(
              letterSpacing: 5,
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: 'SourceSansPro'),
        ),
        const SizedBox(
          width: 150,
          height: 20,
          child: Divider(
            color: Colors.white30,
          ),
        ),
        Card(
          margin: const EdgeInsets.only(left: 40, right: 40, bottom: 20),
          child: ListTile(
            leading: const Icon(
              Icons.call,
            ),
            title: Text(phone),
          ),
        ),
        Card(
          margin: const EdgeInsets.only(left: 40, right: 40),
          child: ListTile(
            leading: const Icon(
              Icons.mail,
            ),
            title: Text(email),
          ),
        ),
      ],
    );
  }
}
