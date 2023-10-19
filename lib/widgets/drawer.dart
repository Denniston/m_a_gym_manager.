import 'package:flutter/material.dart';
import 'package:m_a_gym_manager/controller/gym_provider.dart';
import 'package:m_a_gym_manager/widgets/drawer_list_tile.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gymProvider = Provider.of<GymProvider>(context);

    return Drawer(
      backgroundColor: Colors.grey[900],
      child: Column(
        children: [
          const DrawerHeader(
            child: Column(
              children: [
                Icon(
                  Icons.sports_mma_outlined,
                  color: Colors.white,
                  size: 64,
                ),
                Text(
                  'Gyms',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          // Display Gym List in the Drawer
          for (final gym in gymProvider.gyms) DrawerListTile(gym: gym),
        ],
      ),
    );
  }
}
