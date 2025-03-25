import 'package:flutter/material.dart';

class ShelterPage extends StatefulWidget {
  final Function callback;
  const ShelterPage(
    this.callback, {
    super.key,
  });

  @override
  State<ShelterPage> createState() => _ShelterPageState();

  static const String ShelterPageRoute = "/shelter-page";
}

class _ShelterPageState extends State<ShelterPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
