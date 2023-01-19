import 'package:coin_cap/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget{

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  double? _deviceWidth, _deviceHeight;
  HTTService? _httService;
  @override
  void initState() {
    super.initState();
    _httService = GetIt.instance.get<HTTService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold();
  }
}