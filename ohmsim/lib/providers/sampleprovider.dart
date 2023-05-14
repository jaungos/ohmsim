// Define a provider class
import 'package:flutter/material.dart';
import 'package:ohmsim/models/samplemodel.dart';

class ServiceProvider with ChangeNotifier {
  late MyService _myService;

  ServiceProvider() {
    _myService = MyService();
  }

  MyService get myService => _myService;

  void updateService() {
    _myService = MyService(); // Update the service instance if needed
    notifyListeners();
  }
}
