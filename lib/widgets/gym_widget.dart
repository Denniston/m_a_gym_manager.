import 'package:flutter/material.dart';
import '../model/gym.dart';

class GymWidget extends StatelessWidget {
  final Gym gym;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  const GymWidget(
      {Key? key,
      required this.gym,
      required this.onTap,
      required this.onLongPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6),
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    gym.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                Text(gym.manager,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w400)),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                Text(gym.email,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w400)),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                Text(gym.phone.toString(),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w400)),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                Text(gym.address,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w400)),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  child: Divider(
                    thickness: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
