import 'package:flutter/material.dart';
import 'package:son_pv/data/api/api_service.dart';
import 'package:son_pv/data/model/pv_data_search.dart';

enum SearchResultState { loading, noData, hasData, error }

class SearchProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchProvider({required this.apiService});

  SearchData? _pvDataSearch;
  SearchResultState? _state;
  String _message = '';

  SearchData? get pvDataSearch => _pvDataSearch;
  SearchResultState? get state => _state;
  String get message => _message;


  Future<dynamic> fetchAllSearchDataPv(String query) async {
    try {
      _state = SearchResultState.loading;
      notifyListeners();
      final pvSearch = await apiService.fetchSearchData(query);
      if (pvSearch.restaurants.isEmpty) {
        _state = SearchResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = SearchResultState.hasData;
        notifyListeners();
        return _pvDataSearch = pvSearch;
      }
    } catch (e) {
      _state = SearchResultState.error;
      notifyListeners();
      return _message = e.toString();
    }
  }
}