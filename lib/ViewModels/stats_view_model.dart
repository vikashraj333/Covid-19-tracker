import 'dart:convert';
import 'package:covid_19_tracker_app/ViewModels/Utilities/app_urls.dart';
import 'package:covid_19_tracker_app/Models/world_stats_model.dart';
import 'package:http/http.dart' as http;

class StatsServices {
  Future<WorldStatesModel> fetchWorldStatsRecords() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<dynamic>> fetchCountriesStatsRecords() async {
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
