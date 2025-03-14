import 'package:flutter/material.dart';

class FundingPage extends StatefulWidget {
  final Function callback;
  const FundingPage(
    this.callback, {
    super.key,
  });

  @override
  State<FundingPage> createState() => _FundingPageState();

  static const String FundingPageRoute = "/funding-page";
}

class _FundingPageState extends State<FundingPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
