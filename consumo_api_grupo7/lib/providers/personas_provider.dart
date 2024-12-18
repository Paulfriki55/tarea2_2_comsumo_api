import 'package:flutter/foundation.dart';
import '../models/persona.dart';
import '../services/api_service.dart';

class PersonasProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Persona> _personas = [];

  List<Persona> get personas => _personas;

  Future<void> fetchPersonas() async {
    try {
      _personas = await _apiService.getPersonas();
      notifyListeners();
    } catch (e) {
      print('Error fetching personas: $e');
    }
  }

  Future<void> addPersona(Persona persona) async {
    try {
      final newPersona = await _apiService.createPersona(persona);
      _personas.add(newPersona);
      notifyListeners();
    } catch (e) {
      print('Error adding persona: $e');
    }
  }

  Future<void> updatePersona(String id, Persona persona) async {
    try {
      final updatedPersona = await _apiService.updatePersona(id, persona);
      final index = _personas.indexWhere((p) => p.id == id);
      if (index != -1) {
        _personas[index] = updatedPersona;
        notifyListeners();
      }
    } catch (e) {
      print('Error updating persona: $e');
    }
  }

  Future<void> deletePersona(String id) async {
    try {
      await _apiService.deletePersona(id);
      _personas.removeWhere((p) => p.id == id);
      notifyListeners();
    } catch (e) {
      print('Error deleting persona: $e');
    }
  }
}

