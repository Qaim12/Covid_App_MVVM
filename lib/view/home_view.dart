import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:simple_api_testing/view/country_list.dart';

import '../data/responce/status.dart';
import '../view_model/home_view_model.dart';
import '../view_model/user_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController controller =
  AnimationController(duration: const Duration(seconds: 3), vsync: this)
    ..repeat();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  HomeViewViewModel homeViewViewModel = HomeViewViewModel();

  @override
  void initState() {
    homeViewViewModel.fetchCoronaListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPreference = Provider.of<UserViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ChangeNotifierProvider<HomeViewViewModel>(
            create: (BuildContext context) => homeViewViewModel,
            child: Consumer<HomeViewViewModel>(
              builder: (context, value, _) {
                switch (value.coronaList.status!) {
                  case Status.LOADING:
                    return Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50.0,
                        ),
                      ),
                    );
                  case Status.ERROR:
                    return Center(
                      child: Text(
                        value.coronaList.message.toString(),
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  case Status.COMPLETED:
                    final data = value.coronaList.data!.first; // Assuming only one item in the data list

                    // Define the data for the pie chart
                    final Map<String, double> chartData = {
                      'Total': data.cases!.toDouble(),
                      'Recovered': data.recovered!.toDouble(),
                      'Death': data.deaths!.toDouble(),
                    };

                    return Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Add the PieChart widget here
                            PieChart(
                              dataMap: chartData,
                              chartRadius:
                              MediaQuery.of(context).size.width / 3.2,
                              chartType: ChartType.ring,
                              colorList: colorList,
                              legendOptions: LegendOptions(
                                showLegendsInRow: false,
                                legendPosition: LegendPosition.left,
                                showLegends: true,
                                legendTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              animationDuration:
                              Duration(milliseconds: 1200),
                              chartValuesOptions: ChartValuesOptions(
                                showChartValues: true,
                                showChartValuesInPercentage: true,
                                showChartValuesOutside: false,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: MediaQuery.of(context).size.height *
                                    0.06,
                              ),
                              child: Card(
                                child: Column(
                                  children: [
                                    Reusable(
                                      title: 'Total Cases',
                                      value: data.cases.toString(),
                                    ),
                                    Reusable(
                                      title: 'Deaths',
                                      value: data.deaths.toString(),
                                    ),
                                    Reusable(
                                      title: 'Recovered',
                                      value: data.recovered.toString(),
                                    ),
                                    Reusable(
                                      title: 'Active',
                                      value: data.active.toString(),
                                    ),
                                    Reusable(
                                      title: 'Critical',
                                      value: data.critical.toString(),
                                    ),
                                    Reusable(
                                      title: 'Today Death',
                                      value: data.todayDeaths.toString(),
                                    ),
                                    Reusable(
                                      title: 'Today Recovered',
                                      value: data.todayRecovered.toString(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                    const CountriesListScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Color(0xff1aa260),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text('Track Countries'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class Reusable extends StatelessWidget {
  final String title, value;

  const Reusable({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 10, right: 10, left: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(height: 5),
          Divider(),
        ],
      ),
    );
  }
}
