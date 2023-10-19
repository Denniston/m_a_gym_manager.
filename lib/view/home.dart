import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            pinned: true,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                  //color: Color(0xFFD4E7FE),
                  gradient: LinearGradient(
                      colors: [
                        Colors.tealAccent,
                        Colors.tealAccent,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.6, 0.3])),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    child: RichText(
                      text: const TextSpan(
                        text: "Wed",
                        style: TextStyle(
                            color: Color(0XFF263064),
                            fontSize: 12,
                            fontWeight: FontWeight.w900),
                        children: [
                          TextSpan(
                            text: " 10 Oct",
                            style: TextStyle(
                                color: Color(0XFF263064),
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(width: 1, color: Colors.white),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueGrey.withOpacity(0.2),
                              blurRadius: 12,
                              spreadRadius: 8,
                            )
                          ],
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://images.unsplash.com/photo-1541647376583-8934aaf3448a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1234&q=80"),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hey Rudebwoy",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                              color: Color(0XFF343E87),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Here is a list of schedule",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.blueGrey,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "You need to check...",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Positioned(
              top: 185,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: MediaQuery.of(context).size.height - 245,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      buildTitleRow("COACHES", 3),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            //ListView.builder(itemBuilder: itemBuilder),
                            buildTaskItem(
                                3, "The Basic of Typography II", Colors.red),
                            buildTaskItem(
                                3,
                                "Design Psychology: Principle of...",
                                Colors.green),
                            buildTaskItem(
                                3,
                                "Design Psychology: Principle of...",
                                Colors.green),
                            buildTaskItem(
                                3,
                                "Design Psychology: Principle of...",
                                Colors.green),
                            buildTaskItem(
                                3,
                                "Design Psychology: Principle of...",
                                Colors.green),
                            buildCoachProfileItem(
                                'Denniston Sutherland', '', '07472418957')
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //TODO: Start Here
                      buildTitleRow("TODAY CLASSES", 3),
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            buildTitleRow("TODAY CLASSES", 3),
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector buildCoachProfileItem(
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
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                phone,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey), // Adjust the style as needed
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector buildTaskItem(int numDays, String courseTitle, Color color) {
    return GestureDetector(
      onTap: () {
        print('buildTaskItem pressed');
      },
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        padding: const EdgeInsets.all(12),
        height: 140,
        width: 140,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Deadline",
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Container(
                    height: 6,
                    width: 6,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "$numDays days left",
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 100,
                child: Text(
                  courseTitle,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row buildTitleRow(String title, int number) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
              text: title,
              style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: "($number)",
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal),
                ),
              ]),
        ),
        const Text(
          "See all",
          style: TextStyle(
              fontSize: 12,
              color: Color(0XFF3E3993),
              fontWeight: FontWeight.bold),
        )
      ],
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
                Container(
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
                    Container(
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
