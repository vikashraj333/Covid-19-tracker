import 'package:covid_19_tracker_app/View/detail_screen.dart';
import 'package:covid_19_tracker_app/ViewModels/stats_view_model.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();
  StatsServices statsServices = StatsServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries List'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: 'Search with country name',
                suffixIcon: searchController.text.isEmpty
                    ? const Icon(Icons.search)
                    : GestureDetector(
                        onTap: () {
                          searchController.text = "";
                          setState(() {});
                        },
                        child: const Icon(Icons.clear)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: statsServices.fetchCountriesStatsRecords(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (!snapshot.hasData) {
                  return ListView.builder(
                      itemCount: 15,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                          child: Column(
                            children: [
                              ListTile(
                                title: Container(
                                  height: 10,
                                  width: 80,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  height: 10,
                                  width: 80,
                                  color: Colors.white,
                                ),
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name = snapshot.data![index]['country'];
                        Widget detail = DetailScreen(
                          image: snapshot.data![index]['countryInfo']['flag'],
                          name: snapshot.data![index]['country'],
                          totalCases: snapshot.data![index]['cases'],
                          totalRecovered: snapshot.data![index]['recovered'],
                          totalDeaths: snapshot.data![index]['deaths'],
                          active: snapshot.data![index]['active'],
                          test: snapshot.data![index]['tests'],
                          todayRecovered: snapshot.data![index]
                              ['todayRecovered'],
                          critical: snapshot.data![index]['critical'],
                        );
                        if (searchController.text.isEmpty) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => detail),
                                  );
                                },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(
                                      'Total Cases: ${snapshot.data![index]['cases']}'),
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(
                                      snapshot.data![index]['countryInfo']
                                          ['flag'],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else if (name
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase())) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => detail),
                                  );
                                },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(
                                      'Total Cases: ${snapshot.data![index]['cases']}'),
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(
                                      snapshot.data![index]['countryInfo']
                                          ['flag'],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      });
                }
              },
            ),
          ),
        ],
      )),
    );
  }
}
