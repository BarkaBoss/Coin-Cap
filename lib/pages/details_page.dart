import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget{
  final Map rates;
  const DetailsPage({Key? key, required this.rates}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List currencies = rates.keys.toList();
    List exchangeRates = rates.values.toList();
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: currencies.length,
            itemBuilder: (context, index){
              return ListTile(
                title: Text("${currencies[index].toString().toUpperCase()}:   "
                    "${exchangeRates[index]}", style: TextStyle(color: Colors.white),),
                //subtitle: ,
              );
        }),
      ),
    );
  }

}