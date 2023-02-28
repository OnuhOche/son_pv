import 'package:flutter/material.dart';
import 'package:son_pv/data/api/api_service.dart';
import 'package:son_pv/data/model/pv_detail_lists.dart';

enum DetailResultState { loading, noData, hasData, error }

class PvDetailProvider extends ChangeNotifier {
  final ApiService apiService;

  PvDetailProvider({required this.apiService});

  PvDetailApi? _pvDetailApi;
  late DetailResultState _state;
  String _message = '';

  PvDetailApi? get pvDetailApi => _pvDetailApi;
  DetailResultState get state => _state;
  String get message => _message;


  Future<dynamic> fetchAllDetailDataPv(String id) async {
    try {
      _state = DetailResultState.loading;
      notifyListeners();
      final pvDetail = await apiService.fetchAllPvDetail(id);
      if (pvDetail.restaurant == {}) {
        _state = DetailResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = DetailResultState.hasData;
        notifyListeners();
        return _pvDetailApi = pvDetail;
      }
    } catch (e) {
      _state = DetailResultState.error;
      notifyListeners();
      return _message = 'connection lost';
    }
  }
}
