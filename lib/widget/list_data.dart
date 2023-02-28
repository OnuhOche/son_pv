import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:son_pv/provider/pvdetail_provider.dart';
import 'package:son_pv/provider/pvlist_provider.dart';
import 'package:son_pv/widget/listview_data.dart';

class ListDataWidget extends StatefulWidget {
  const ListDataWidget({super.key});

  @override
  State<ListDataWidget> createState() => _ListDataWidgetState();
}

class _ListDataWidgetState extends State<ListDataWidget> {
  
  @override
  Widget build(BuildContext context) {
    final restaurantLists = Provider.of<PvListProvider>(context);
    final pvDetail = Provider.of<PvDetailProvider>(context);
    
    return Expanded(
      child: Builder(
        builder: (context) {
          if (restaurantLists.state == ResultState.error){
            return Center(
              child: Material(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.wifi_off_rounded, size: 150,),
                    Text(restaurantLists.message,
                      style: const TextStyle(
                        fontSize: 25
                      ),
                    )
                  ],
                ),
              ),
            );
          } 
          else if (restaurantLists.state == ResultState.loading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (restaurantLists.state == ResultState.hasData){
            var pvDataLists = restaurantLists.pvApi.restaurants;
            return ListViewCustom(
              listLength: restaurantLists.pvApi.restaurants.length,
              listData: pvDataLists,
              provider: pvDetail,
            );
          } else if (restaurantLists.state == ResultState.noData){
            return Center(
              child: Material(
                child: Text(restaurantLists.message),
              ),
            );
          } else{
            return const Center(
              child: Material(
                child: Text(''),
              ),
            );
          }
        },
      ),
    );
  }
}

