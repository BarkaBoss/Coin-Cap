import 'dart:convert';

import 'package:coin_cap/pages/details_page.dart';
import 'package:coin_cap/services/http_service.dart';
import 'package:coin_cap/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? _deviceWidth, _deviceHeight;
  String _selected = "bitcoin";
  HTTService? _httService;

  @override
  void initState() {
    super.initState();
    _httService = GetIt.instance.get<HTTService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery
        .of(context)
        .size
        .height;
    _deviceWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              dropDown(
                  ["bitcoin", "ethereum", "tether", "ripple", "cardano"],
                  _deviceWidth!),
              _dataWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dataWidget() {
    return FutureBuilder(
      future: _httService!.get("/coins/$_selected"),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Map data = jsonDecode(snapshot.data.toString());
          num ngnPrice = data["market_data"]["current_price"]["ngn"];
          num change24h = data["market_data"]["price_change_percentage_24h"];
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                  onDoubleTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return DetailsPage();
                      }),
                    );
                  },
                  child: _coinImage(data["image"]["large"])),
              _currentPrice(ngnPrice),
              _percentageChangeWidget(change24h),
              _descriptionCard(data["description"]["en"])
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }
      },
    );
  }

  Widget _currentPrice(num rate) {
    return Text(
      "${rate.toStringAsFixed(2)} Naira",
      style: const TextStyle(
          color: Colors.white, fontSize: 30, fontWeight: FontWeight.w400),
    );
  }

  Widget _percentageChangeWidget(num change) {
    return Text(
      "Change ${change.toString()}% in 24h",
      style: const TextStyle(
          color: Colors.white, fontSize: 15, fontWeight: FontWeight.w300),
    );
  }

  Widget _coinImage(String url) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: _deviceHeight! * 0.02),
        height: _deviceHeight! * 0.15,
        width: _deviceWidth! * 0.15,
        decoration:
        BoxDecoration(image: DecorationImage(image: NetworkImage(url))));
  }

  Widget _descriptionCard(String description) {
    return Container(
      height: _deviceHeight! * 0.45,
      width: _deviceWidth! * 0.90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromRGBO(108, 80, 199, 1.0),
      ),
      margin: EdgeInsets.symmetric(
        vertical: _deviceHeight! * 0.05,
      ),
      padding: EdgeInsets.symmetric(
        vertical: _deviceHeight! * 0.01,
        horizontal: _deviceHeight! * 0.01,
      ),
      child: Text(
        description,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget dropDown(List<String> coins, double width) {
    {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        width: width * 0.5,
        decoration: BoxDecoration(
            color: Colors.indigo, borderRadius: BorderRadius.circular(10)),
        child: DropdownButton(
          dropdownColor: Colors.indigo,
          value: _selected,
          onChanged: (value) {
            setState(() {
              _selected = value.toString();
              debugPrint(_selected);
            });
          },
          underline: Container(),
          icon: const Icon(Icons.arrow_drop_down_sharp),
          iconSize: 30,
          iconEnabledColor: Colors.white,
          elevation: 5,
          items: coins.map((e) {
            return DropdownMenuItem(
              value: e,
              child: Text(e, style: const TextStyle(fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w800),),
            );
          }).toList(),
        ),
      );
    }
  }
}