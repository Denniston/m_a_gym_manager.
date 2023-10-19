import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../database/gym_app_db.dart';
import '../model/coach.dart';

class CoachProvider extends ChangeNotifier {
  late final GymAppDB gymAppDb;

  Future fetchCoaches() async {
    final coaches = await gymAppDb.fetchCoaches();
    // Assign coaches to the private _coaches variable
    _coaches = coaches;
    notifyListeners();
  }

  List<Coach> _coaches = [];
  List<Coach> get coaches => _coaches;

  // Add a new coach to the database
  Future<void> addCoach(Coach coach) async {
    // Call the createCoach method from GymAppDB
    await gymAppDb.createCoach(
      profileImage: coach.profileImage,
      coverImage: coach.coverImage,
      firstName: coach.firstName,
      lastName: coach.lastName,
      address: coach.address,
      email: coach.email,
      phone: coach.phone,
      dob: coach.dob,
      age: coach.age,
      specialization: coach.specialization,
    );
    // Refresh the list of coaches
    await fetchCoaches();
    notifyListeners();
  }

  // Update a coach in the database
  Future<void> updateCoach(Coach coach) async {
    // Call the updateGym method from GymAppDB
    await gymAppDb.updateCoach(
      id: coach.id,
      firstName: coach.firstName,
      lastName: coach.lastName,
      email: coach.email,
      phone: coach.phone,
      dob: coach.dob,
      age: coach.age,
      address: coach.address,
      profileImage: coach.profileImage,
      coverImage: coach.coverImage,
      specialization: coach.specialization,
    );
    // Refresh the list of coaches
    await fetchCoaches();
    notifyListeners();
  }

  // Delete a coach from the database
  Future<void> deleteCoach(int id) async {
    // Call the deleteCoach method from GymAppDB
    await gymAppDb.deleteCoach(id);

    // Refresh the list of gyms
    await fetchCoaches();
    notifyListeners();
  }
}
