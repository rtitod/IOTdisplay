import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models.dart';

class MyViewModel extends ChangeNotifier {
  List<SensorRegister> _sensorRegisters = [];
  int _currentPage = 1;
  bool _isLoading = false;

  List<SensorRegister> get sensorRegisters => _sensorRegisters;
  bool get isLoading => _isLoading;

  Future<void> fetchData() async {
    if (_isLoading) return;

    _isLoading = true;

    try {
      final response = await http.get(
        Uri.parse(
            'https://qap9opok49.execute-api.us-west-2.amazonaws.com/prod/sensorapi?startregister=$_currentPage&maxregisters=10'),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<SensorRegister> newData = (jsonData['registers'] as List)
            .map((data) => SensorRegister.fromJson(data))
            .toList();

        _sensorRegisters.addAll(newData);
        _currentPage++;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}