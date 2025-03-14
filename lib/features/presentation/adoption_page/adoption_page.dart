import 'package:flutter/material.dart';

class AdoptionPage extends StatefulWidget {
  final Function callback;
  const AdoptionPage(
    this.callback, {
    super.key,
  });

  @override
  State<AdoptionPage> createState() => _AdoptionPageState();

  static const String AdoptionPageRoute = "/adoption-page";
}

class _AdoptionPageState extends State<AdoptionPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
