import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String weatherInfo = "Cargando...";

  Future<void> fetchWeather() async {
    final apiKey = 'TU_API_KEY_AQUI';  // Reemplaza con tu clave de API de clima
    final response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=Santo%20Domingo&appid=$apiKey&units=metric'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        weatherInfo = 'Clima: ${data['weather'][0]['description']}, Temperatura: ${data['main']['temp']}°C';
      });
    } else {
      setState(() {
        weatherInfo = 'Error al cargar el clima';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clima en República Dominicana'),
      ),
      body: Center(
        child: Text(
          weatherInfo,
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
