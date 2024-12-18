import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/persona.dart';

class ApiService {
  final String baseUrl = 'http://10.0.2.2:5000/api'; // Usa tu IP local si es necesario

  Future<List<Persona>> getPersonas() async {
    final response = await http.get(Uri.parse('$baseUrl/personas'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Persona.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load personas');
    }
  }

  Future<Persona> createPersona(Persona persona) async {
    final response = await http.post(
      Uri.parse('$baseUrl/personas'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(persona.toJson()),
    );
    if (response.statusCode == 201) {
      return Persona.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create persona');
    }
  }

  Future<Persona> updatePersona(String id, Persona persona) async {
    final response = await http.put(
      Uri.parse('$baseUrl/personas/$id'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(persona.toJson()),
    );
    if (response.statusCode == 200) {
      return Persona.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update persona');
    }
  }

  Future<void> deletePersona(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/personas/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete persona');
    }
  }
}

