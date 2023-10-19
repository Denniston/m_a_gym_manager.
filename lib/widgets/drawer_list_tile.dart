import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/gym.dart';
import '../view/gym_home_screen.dart';

class DrawerListTile extends StatelessWidget {
  final Gym gym;

  const DrawerListTile({required this.gym, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(gym.profileImage ?? ''),
      ),
      title: Text(
        gym.name,
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            gym.address,
            style: const TextStyle(color: Colors.white),
          ),
          Text(
            'Manager: ${gym.manager}',
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
      trailing: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
      onTap: () {
        final gymHome = Provider.of<GymHomeScreen>(context, listen: false);
        //TODO: Populate GymHomeScreen not Navigate to

        Navigator.pop(context);

        // Navigate to GymHomeScreen and pass the selected gym's data
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => GymHomeScreen(
        //       gym: gym,
        //     ),
        //   ),
        // );
      },
    );
  }
}
