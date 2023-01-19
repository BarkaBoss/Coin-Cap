import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  List<String> coins;
  double width;

  CustomDropDown({required this.coins, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      width: width*0.5,
      decoration: BoxDecoration(
          color: Colors.indigo, borderRadius: BorderRadius.circular(10)),
      child: DropdownButton(
        dropdownColor: Colors.indigo,
        value: coins.first,
        underline: Container(),
        icon: const Icon(Icons.arrow_drop_down_sharp),
        iconSize: 30,
        iconEnabledColor: Colors.white,
        elevation: 5,
        items: coins.map((e) {
          return DropdownMenuItem(
            value: e,
            child: Text(e, style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w800),),
          );
        }).toList(),
        onChanged: (_) {},
      ),
    );
  }
}
