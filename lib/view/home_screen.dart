// import 'package:flutter/material.dart';
// import 'package:m_a_gym_manager/widgets/task_item.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             expandedHeight: 200.0,
//             pinned: true,
//             floating: true,
//             flexibleSpace: Container(
//               decoration: const BoxDecoration(
//                   //color: Color(0xFFD4E7FE),
//                   gradient: LinearGradient(
//                       colors: [
//                         Colors.tealAccent,
//                         Colors.tealAccent,
//                       ],
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       stops: [0.6, 0.3])),
//               padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Container(
//                       alignment: Alignment.centerRight,
//                       child: RichText(
//                         text: const TextSpan(
//                           text: "Wed",
//                           style: TextStyle(
//                               color: Color(0XFF263064),
//                               fontSize: 12,
//                               fontWeight: FontWeight.w900),
//                           children: [
//                             TextSpan(
//                               text: " 10 Oct",
//                               style: TextStyle(
//                                   color: Color(0XFF263064),
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.normal),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           width: 40,
//                           height: 40,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             border: Border.all(width: 1, color: Colors.white),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.blueGrey.withOpacity(0.2),
//                                 blurRadius: 12,
//                                 spreadRadius: 8,
//                               )
//                             ],
//                             image: const DecorationImage(
//                               fit: BoxFit.cover,
//                               image: NetworkImage(
//                                   "https://images.unsplash.com/photo-1541647376583-8934aaf3448a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1234&q=80"),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 20,
//                         ),
//                         const Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Hey Rudebwoy",
//                               style: TextStyle(
//                                 fontSize: 25,
//                                 fontWeight: FontWeight.w900,
//                                 color: Color(0XFF343E87),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Text(
//                               "Here is a list of schedule",
//                               style: TextStyle(
//                                 fontSize: 13,
//                                 color: Colors.blueGrey,
//                               ),
//                             ),
//                             SizedBox(
//                               height: 8,
//                             ),
//                             Text(
//                               "You need to check...",
//                               style: TextStyle(
//                                 fontSize: 13,
//                                 color: Colors.blueGrey,
//                               ),
//                             ),
//                           ],
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           SliverList(
//             delegate: SliverChildBuilderDelegate(
//               (BuildContext context, int index) {
//                 return TaskItemWidget(
//                     numDays: 10,
//                     courseTitle: "courseTitle",
//                     color: Colors.teal,
//                     onTap: () {});
//                 // return ListTile(
//                 //   title: Text('Item ${1 + index}'),
//                 // );
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:m_a_gym_manager/widgets/drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            actions: [
              // Add Gym button or dialog
              // Add Coach button
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Gym profile image
                  // Gym name
                  // Gym email
                ],
              ),
            ),
          ),
          SliverPersistentHeader(
            delegate: MyCoachesHeaderDelegate(),
            floating: false,
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                // List of classes
              },
              childCount: 10, // Replace with your data
            ),
          ),
        ],
      ),
      drawer: GymDrawer(),
    );
  }
}

class MyCoachesHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 50.0;
  @override
  double get maxExtent => 80.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // List of coaches
    return Text("List of Coaches");
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class GymDrawer extends StatelessWidget {
  const GymDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const MyDrawer(),
          //DrawerHeader(
          // Gym profile image, name, and email
          //),
          ListTile(
            title: const Text('Gym 1'),
            onTap: () {
              // Switch to Gym 1
            },
          ),
          // Add Gym button
        ],
      ),
    );
  }
}
