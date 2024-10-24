import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List news = [];

  Future<void> fetchNews() async {
    final response = await http.get(Uri.parse('https://www.starwars.com/news/wp-json/wp/v2/posts'));
    if (response.statusCode == 200) {
      setState(() {
        news = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load news');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noticias de Star Wars'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset('assets/images/starwars_logo.png', height: 100),  // Logo de Star Wars
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: news.length > 3 ? 3 : news.length,  // Mostrar solo las últimas 3 noticias
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(news[index]['title']['rendered']),
                    subtitle: Text(news[index]['excerpt']['rendered']),
                    trailing: IconButton(
                      icon: Icon(Icons.open_in_new),
                      onPressed: () {
                        // Abrir la noticia en el navegador
                        launch(news[index]['link']);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
