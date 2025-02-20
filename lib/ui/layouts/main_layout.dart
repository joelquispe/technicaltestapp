import 'package:flutter/material.dart';
class MainLayout extends StatelessWidget {
  final Widget body;
  final String titleAppBar;
  const MainLayout({super.key, required this.body, required this.titleAppBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(titleAppBar),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: body,
      ),
    );
  }
}