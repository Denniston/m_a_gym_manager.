import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:m_a_gym_manager/database/gym_app_db.dart';
import 'package:m_a_gym_manager/main.dart';
import '../model/gym.dart';
import 'package:flutter/widgets.dart';

class GymProvider extends ChangeNotifier {
  // Initialize gyms from the database
  late final GymAppDB gymAppDb;
  GymProvider() {
    gymAppDb = GymAppDB();
  }

  //Read all gyms in database
  Future fetchGyms() async {
    final gyms = await gymAppDb.fetchGyms();
    // Assign gyms to the private _gyms variable
    _gyms = gyms;
    notifyListeners();
  }

  List<Gym> _gyms = [];
  List<Gym> get gyms => _gyms;

  // Add a new gym to the database
  Future<void> addGym(Gym gym) async {
    // Call the createGym method from GymAppDB
    await gymAppDb.createGym(
      //id: gym.id,
      name: gym.name,
      email: gym.email,
      phone: gym.phone,
      address: gym.address,
      manager: gym.manager,
      profileImage: gym.profileImage,
    );
    // Refresh the list of gyms
    await fetchGyms();
    notifyListeners();
  }

  // Update a gym in the database
  Future<void> updateGym(Gym gym) async {
    // Call the updateGym method from GymAppDB
    await gymAppDb.updateGym(
      id: gym.id,
      name: gym.name,
      email: gym.email,
      phone: gym.phone,
      address: gym.address,
      manager: gym.manager,
      profileImage: gym.profileImage,
    );

    // Refresh the list of gyms
    await fetchGyms();
    notifyListeners();
  }

  // Delete a gym from the database
  Future<void> deleteGym(int id) async {
    // Call the deleteGym method from GymAppDB
    await gymAppDb.deleteGym(id);
    // Refresh the list of gyms
    await fetchGyms();
    notifyListeners();
  }
}
