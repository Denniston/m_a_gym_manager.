import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/coach_provider.dart';
import '../model/coach.dart';

class AddCoachScreen extends StatefulWidget {
  const AddCoachScreen({super.key});

  @override
  State<AddCoachScreen> createState() => _AddCoachScreenState();
}

class _AddCoachScreenState extends State<AddCoachScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _firstName;
  String? _lastName;
  String? _specialization;
  String? _email;
  String? _phone;
  String? _address;

  @override
  Widget build(BuildContext context) {
    final coachesProvider = Provider.of<CoachProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Coach'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  _firstName = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Specialization'),
                onChanged: (value) {
                  _specialization = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                onChanged: (value) {
                  _email = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone'),
                onChanged: (value) {
                  _phone = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Address'),
                onChanged: (value) {
                  _address = value;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final coach = Coach(
                      firstName: _firstName!,
                      lastName: _lastName!,
                      specialization: _specialization!,
                      email: _email!,
                      phone: _phone!,
                      address: _address!,
                    );
                    coachesProvider.addCoach(coach);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add Coach'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
