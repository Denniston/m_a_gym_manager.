import 'package:flutter/material.dart';

class TaskItemWidget extends StatelessWidget {
  final int numDays;
  final String courseTitle;
  final Color color;
  final VoidCallback onTap;

  TaskItemWidget({
    required this.numDays,
    required this.courseTitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
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
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
