import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: 'Search Page'.text.size(24).bold.make(),
      ),
    );
  }
}
