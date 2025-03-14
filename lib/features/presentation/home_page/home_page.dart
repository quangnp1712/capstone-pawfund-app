// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final Function callback;
  const HomePage(
    this.callback, {
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();

  static const String HomePageRoute = "/home-page";
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
