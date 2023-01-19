import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  List<String> coins;
  double width;

  CustomDropDown({required this.coins, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      width: width,
      decoration: BoxDecoration(
          color: Colors.indigo, borderRadius: BorderRadius.circular(5)),
      child: DropdownButton(
        value: coins.first,
        underline: Container(),
        elevation: 5,
        items: coins.map((e) {
          return DropdownMenuItem(
            value: e,
            child: Text(e),
          );
        }).toList(),
        onChanged: (_) {},
      ),
    );
  }
}
