import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final Function callback;
  const ProfilePage(
    this.callback, {
    super.key,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();

  static const String ProfilePageRoute = "/profile-page";
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
