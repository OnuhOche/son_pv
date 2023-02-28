import 'package:son_pv/data/model/pv_data_lists.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:son_pv/data/model/pv_data_search.dart';
import 'package:son_pv/data/model/pv_detail_lists.dart';

class ApiService {
  static const String _showList = 'list';
  static const String _baseUrl = 'https://pv-api.dicoding.dev/';
  static const String _showDetail = 'detail/';
  static const String _showSearch = 'search?q=';

  Future<PvApi> fetchAllPvList() async {
    final response = await http.get(Uri.parse(_baseUrl + _showList));

    if (response.statusCode == 200) {
      return PvApi.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Cannot Load Data');
    }
  }

  Future<PvDetailApi> fetchAllPvDetail(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + _showDetail + id));
    if (response.statusCode == 200) {
      return PvDetailApi.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Cannot Load Data');
    }
  }

  Future<SearchData> fetchSearchData(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + _showSearch + query));
    if (response.statusCode == 200) {
      return SearchData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Cannot Load Data');
    }
  }
}
