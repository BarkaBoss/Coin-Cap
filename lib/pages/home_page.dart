import 'dart:convert';

import 'package:coin_cap/services/http_service.dart';
import 'package:coin_cap/widgets/custom_dropdown.dart';
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
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _selectedCoin(
                ["Bitcoin", "Ethereum"], _deviceWidth!),
              _dataWidget(),
            ],
          ),
        ),
      ),
    );
  }
  Widget _selectedCoin(List<String> coins, double deviceWidth){
    return CustomDropDown(coins: coins, width: deviceWidth);
  }

  Widget _dataWidget(){
    return FutureBuilder(
      future: _httService!.get("/coins/bitcoin"),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.hasData){
          Map data = jsonDecode(snapshot.data.toString());
          num ngnPrice = data["market_data"]["current_price"]["ngn"];
          num change24h = data["market_data"]["price_change_percentage_24h"];
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _coinImage(data["image"]["large"]),
              _currentPrice(ngnPrice),
              _percentageChangeWidget(change24h),

            ],
          );
        }else{
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }

      },
    );
  }

  Widget _currentPrice(num rate){
    return Text("${rate.toStringAsFixed(2)} Naira",
      style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w400),
    );
  }

  Widget _percentageChangeWidget(num change){
    return Text("Change ${change.toString()}% in 24h",
      style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w300),
    );
  }

  Widget _coinImage(String url){
    return Container(
      padding: EdgeInsets.symmetric(vertical: _deviceHeight! * 0.02),
      height: _deviceHeight! * 0.15,
      width: _deviceWidth! * 0.15,
      decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(url)))
    );
  }
}