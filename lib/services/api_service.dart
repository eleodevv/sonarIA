import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://unifier-verse-wince.ngrok-free.dev';

  /// Endpoint principal: envía audio + acorde esperado al servidor.
  /// El backend usa SVM + Chroma para verificar.
  /// Retorna: {correcto, confianza, mensaje, acorde_detectado}
  Future<Map<String, dynamic>> verificarAcorde(
      String audioPath, String acordeEsperado) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/predecir'));
    request.files.add(await http.MultipartFile.fromPath('audio', audioPath));
    request.fields['acorde'] = acordeEsperado;
    var streamed = await request.send().timeout(const Duration(seconds: 30));
    var response = await http.Response.fromStream(streamed)
        .timeout(const Duration(seconds: 30));
    if (response.statusCode == 200) return json.decode(response.body);
    throw Exception('Error ${response.statusCode}');
  }

  /// Alias para compatibilidad con la pantalla de práctica libre.
  /// Envía audio sin acorde esperado — usa SVM para clasificar.
  Future<Map<String, dynamic>> clasificarAcorde(String audioPath) async {
    // Envía con acorde vacío, el servidor retornará el detectado
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/predecir'));
    request.files.add(await http.MultipartFile.fromPath('audio', audioPath));
    request.fields['acorde'] = '';
    var streamed = await request.send().timeout(const Duration(seconds: 30));
    var response = await http.Response.fromStream(streamed)
        .timeout(const Duration(seconds: 30));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // Adaptar respuesta al formato que espera la pantalla de práctica
      return {
        'acorde_predicho': data['acorde_detectado'] ?? '',
        'confianza': (data['confianza'] ?? 0) / 100.0,
        'es_correcto': data['correcto'] ?? false,
      };
    }
    throw Exception('Error ${response.statusCode}');
  }

  Future<bool> checkHealth() async {
    try {
      final r = await http.get(Uri.parse('$baseUrl/health'))
          .timeout(const Duration(seconds: 5));
      return r.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  Future<Map<String, dynamic>> getStats() async {
    try {
      final r = await http.get(Uri.parse('$baseUrl/health'))
          .timeout(const Duration(seconds: 5));
      if (r.statusCode == 200) return json.decode(r.body);
    } catch (_) {}
    return {};
  }
}
