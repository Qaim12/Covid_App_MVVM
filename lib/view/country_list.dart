import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../data/responce/status.dart';
import '../view_model/home_view_model.dart';
import 'detail_screen.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();
  HomeViewViewModel homeViewViewModel = HomeViewViewModel();

  @override
  void initState() {
    homeViewViewModel.fetchCountriesListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewViewModel>(
      create: (BuildContext context) => homeViewViewModel,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {});
                  },
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search with country name',
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Consumer<HomeViewViewModel>(
                  builder: (context, value, _) {
                    switch (value.coronaCountryList.status) {
                      case Status.LOADING:
                        return Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade700,
                              highlightColor: Colors.grey[100]!,
                              period: Duration(milliseconds: 800), // Set the duration of shimmer animation
                              direction: ShimmerDirection.ltr, // Set the direction of shimmer animation
                              child: ListView.builder(
                                itemCount: 10, // Adjust the item count as needed
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: CircleAvatar(),
                                    title: Container(
                                      width: double.infinity,
                                      height: 16,
                                      color: Colors.white,
                                    ),
                                    subtitle: Container(
                                      width: double.infinity,
                                      height: 12,
                                      color: Colors.white,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      case Status.ERROR:
                        return Center(
                          child: Text(
                            value.coronaCountryList.message.toString(),
                            style: TextStyle(color: Colors.red),
                          ),
                        );
                      case Status.COMPLETED:
                        return ListView.builder(
                          itemCount: value.coronaCountryList.data!.length,
                          itemBuilder: (context, index) {
                            final data = value.coronaCountryList.data![index];
                            String name = data.country.toString();
                            if (searchController.text.isEmpty ||
                                name.toLowerCase().contains(searchController.text.toLowerCase())) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => DetailScreen(
                                            image: data.countryInfo!.flag.toString(),
                                            name: data.country.toString(),
                                            totalCases: data.cases!.toInt(),
                                            todayRecovered: data.recovered!.toInt(),
                                            totalDeaths: data.deaths!.toInt(),
                                            active: data.active!.toInt(),
                                            test: data.tests!.toInt(),
                                            totalRecoved: data.todayRecovered!.toInt(),
                                            critical: data.critical!.toInt(),
                                          ),
                                        ),
                                      );
                                    },
                                    child: ListTile(
                                      title: Text(data.country.toString()),
                                      subtitle: Text(data.cases.toString()),
                                      leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(data.countryInfo!.flag.toString()),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Container();
                            }
                          },
                        );
                      default:
                        return SizedBox(); // Return an empty widget by default
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
