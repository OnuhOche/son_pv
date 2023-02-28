import 'package:flutter/cupertino.dart';
import 'package:son_pv/data/api/api_service.dart';
import 'package:son_pv/data/model/pv_data_lists.dart';

enum ResultState { loading, noData, hasData, error }

class PvListProvider extends ChangeNotifier {
  final ApiService apiService;

  PvListProvider({required this.apiService}) {
    fetchAllDataPv();
  }

  late PvApi _pvApi;
  late ResultState _state;
  String _message = '';

  PvApi get pvApi => _pvApi;
  ResultState get state => _state;
  String get message => _message;

  Future<dynamic> fetchAllDataPv() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final pvData = await apiService.fetchAllPvList();
      if (pvData.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _pvApi = pvData;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'connection lost';
    } 
  }
}
