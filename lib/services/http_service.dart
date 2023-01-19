import 'package:coin_cap/models/app_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HTTService{
  final Dio dio = Dio();

  AppConfig? _appConfig;
  String? _baseUrl;

  HTTService(){
    _appConfig = GetIt.instance.get<AppConfig>();
    _baseUrl = _appConfig!.COIN_API_BASE_URL;

    debugPrint("base 😄 $_baseUrl");
  }

  Future<Response?> get(String path) async{
    try{
      String url = "$_baseUrl$path";
      Response response = await dio.get(url);
      return response;
    }catch(e){
      debugPrint("Dio HTTP>> $e.toString()");
    }
  }
}