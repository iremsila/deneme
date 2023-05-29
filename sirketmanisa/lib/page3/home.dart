import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/theme_proivder.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<themeProvider>(context);
    return MaterialApp(
      title: "NEWS",
      debugShowCheckedModeBanner: false,
      theme: theme.getTheme(),
      home: CategoryScreen(),
      routes: {
        '/category-books': (ctx) => CategoryBooksScreen(),
        '/article-details': (ctx) => ArticleDetailsScreen(),
      },
    );
  }
}

class CategoryScreen extends StatefulWidget {
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<themeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("NEWS"),
        leading: IconButton(
          icon: Icon(Icons.newspaper),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            onPressed: () => theme.setTheme(ThemeData.light()),
            icon: Icon(Icons.wb_sunny),
          ),
          IconButton(
            onPressed: () => theme.setTheme(ThemeData.dark()),
            icon: Icon(Icons.nights_stay),
          ),
        ],
      ),
      body: Container(
        color: theme.getTheme().scaffoldBackgroundColor, // Arka plan rengini tema ile senkronize etmek için
        padding: const EdgeInsets.all(5),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: categories
              .map(
                (catData) =>
                CategoryItem(
                  catData.id,
                  catData.title,
                  catData.color,
                  catData.endpoint,
                ),
          )
              .toList(),
        ),
      ),
    );
  }
}


  class CategoryItem extends StatefulWidget {
  final String id;
  final String title;
  final Color color;
  final String endpoint;

  CategoryItem(this.id, this.title, this.color, this.endpoint);

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      '/category-books',
      arguments: {
        "id": widget.id,
        "title": widget.title,
        "endpoint": widget.endpoint,
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [widget.color.withOpacity(0.6), widget.color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}

class CategoryBooksScreen extends StatefulWidget {
  @override
  _CategoryBooksScreenState createState() => _CategoryBooksScreenState();
}
class _CategoryBooksScreenState extends State<CategoryBooksScreen> {
  late List<Article> articles = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final routeArgs = ModalRoute
        .of(context)
        ?.settings
        .arguments as Map<String, dynamic>;
    final String? categoryTitle = routeArgs["title"];
    final String? categoryEndpoint = routeArgs['endpoint'];

    fetchArticles(categoryEndpoint!);
  }

  Future<void> fetchArticles(String category) async {
    final apiKey = 'be9a6e6af36546e394d62c9280af0250';
    final url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      setState(() {
        articles = (jsonData['articles'] as List)
            .map((article) => Article.fromJson(article))
            .toList();
      });
    } else {
      throw Exception('Failed to fetch articles');
    }
  }

  void selectArticle(Article article) {
    Navigator.of(context).pushNamed(
      '/article-details',
      arguments: article,
    );
  }
  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final String? categoryTitle = routeArgs["title"];
    final theme = Provider.of<themeProvider>(context);

    final TextStyle titleStyle = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: theme.getTheme().brightness == Brightness.light ? Colors.black : Colors.white,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle!),
      ),
      backgroundColor: theme.getTheme().scaffoldBackgroundColor,
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: articles.length,
        itemBuilder: (ctx, index) {
          final article = articles[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 7,
                    blurRadius: 8,
                    offset: Offset(0, 5),
                  ),
                ],
                color: theme.getTheme().brightness == Brightness.light ? Colors.white : Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              height: 75,
              child: ListTile(
                leading: Image.network(article.imageUrl),
                title: Text(
                  article.title,
                  style: titleStyle,
                ),
                onTap: () => selectArticle(article),
              ),
            ),
          );
        },
      ),
    );
  }

}

  class ArticleDetailsScreen extends StatefulWidget {
  @override
  State<ArticleDetailsScreen> createState() => _ArticleDetailsScreenState();
}

class _ArticleDetailsScreenState extends State<ArticleDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<themeProvider>(context);
    final article = ModalRoute.of(context)?.settings.arguments as Article;
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(article.imageUrl),
            SizedBox(height: 10),
            Text(
              article.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              article.description,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
      backgroundColor: theme.getTheme().scaffoldBackgroundColor,
    );
  }
}

class Category {
  final String id;
  final String title;
  final Color color;
  final String endpoint;

  const Category({
    required this.id,
    required this.title,
    this.color = Colors.orange,
    this.endpoint = '',
  });
}

List<Category> categories = [
  Category(
    id: 'c1',
    title: 'Business',
    color: Colors.purple,
    endpoint: 'business',
  ),
  Category(
    id: 'c2',
    title: 'Sport',
    color: Colors.red,
    endpoint: 'sports',
  ),
  Category(
    id: 'c3',
    title: 'Health',
    color: Colors.orange,
    endpoint: 'health',
  ),
  Category(
    id: 'c4',
    title: 'Entertainment',
    color: Colors.amber,
    endpoint: 'entertainment',
  ),
  Category(
    id: 'c5',
    title: 'General',
    color: Colors.blue,
    endpoint: 'general',
  ),
  Category(
    id: 'c6',
    title: 'Science',
    color: Colors.green,
    endpoint: 'science',
  ),
  Category(
    id: 'c7',
    title: 'Technology',
    color: Colors.lightBlue,
    endpoint: 'technology',
  ),
];

class Article {
  final String title;
  final String description;
  final String imageUrl;

  Article({
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['urlToImage'] ?? '',
    );
  }
}