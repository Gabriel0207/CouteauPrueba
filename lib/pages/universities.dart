import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UniversitiesPage extends StatefulWidget {
  @override
  _UniversitiesPageState createState() => _UniversitiesPageState();
}

class _UniversitiesPageState extends State<UniversitiesPage> {
  String country = "";
  List universities = [];

  Future<void> fetchUniversities(String country) async {
    final response = await http.get(Uri.parse('http://universities.hipolabs.com/search?country=$country'));
    if (response.statusCode == 200) {
      setState(() {
        universities = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load universities');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Universidades por País'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Introduce un país (en inglés)'),
              onChanged: (value) {
                country = value;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                fetchUniversities(country);
              },
              child: Text('Buscar Universidades'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: universities.isNotEmpty
                  ? ListView.builder(
                itemCount: universities.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(universities[index]['name']),
                    subtitle: Text(universities[index]['domain']),
                    trailing: IconButton(
                      icon: Icon(Icons.open_in_new),
                      onPressed: () {
                        // Open the university website
                        launch(universities[index]['web_pages'][0]);
                      },
                    ),
                  );
                },
              )
                  : Text('Introduce un país para ver sus universidades'),
            ),
          ],
        ),
      ),
    );
  }
}
