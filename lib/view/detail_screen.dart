import 'package:flutter/material.dart';

import 'home_view.dart';
class DetailScreen extends StatefulWidget {
  String image;
  String name;
  int totalCases, totalDeaths, totalRecoved, active, critical, todayRecovered, test;


  DetailScreen({
    required this.image,
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecoved,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * .08,),
                      Reusable(title: 'Cases', value: widget.totalCases.toString()),
                      Reusable(title: 'Active', value: widget.active.toString()),
                      Reusable(title: 'Recovered', value: widget.totalRecoved.toString()),
                      Reusable(title: 'Death', value: widget.totalDeaths.toString()),
                      Reusable(title: 'Critical', value: widget.critical.toString()),
                      Reusable(title: 'Today Recovered', value: widget.todayRecovered.toString()),

                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}
