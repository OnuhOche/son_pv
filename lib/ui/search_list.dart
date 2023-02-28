import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:son_pv/provider/pvdetail_provider.dart';
import 'package:son_pv/provider/pvsearch_provider.dart';
import 'package:son_pv/widget/list_data.dart';
import 'package:son_pv/widget/listview_data.dart';

class SearchPv extends StatefulWidget {
  const SearchPv({super.key});
  
  @override
  State<SearchPv> createState() => _SearchPvState();
}

class _SearchPvState extends State<SearchPv> {
  final TextEditingController _searchFieldController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    final pvSearch = Provider.of<SearchProvider>(context);
    final pvDetail = Provider.of<PvDetailProvider>(context);
    final double flexWidth = MediaQuery.of(context).size.width;
    final double flexHeight = MediaQuery.of(context).size.height;
    String searchVal = '';

    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Search',
          style: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.black, fontSize: 28),
        ),
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, flexHeight * 0.1),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: TextField(
              controller: _searchFieldController,
              decoration: InputDecoration(
                hintText: 'Search name, registration number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onChanged: (value) {
                searchVal = value;
                pvSearch.fetchAllSearchDataPv(value);
              },
            ),
          ),
        ),
      ),
      body: Container(
        width: flexWidth,
        height: flexHeight,
        child: Builder(
          builder: (context) {
            if (pvSearch.state == SearchResultState.loading) {
              return SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_rounded,
                        size: 200,
                        color: Colors.black.withOpacity(0.5),
                      ),
                      SizedBox(
                        height: flexHeight * 0.01,
                      ),
                      Text(
                        'Finding Your Product, Please Wait!',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(fontSize: 24),
                      )
                    ]),
              );
            } else if (pvSearch.state == SearchResultState.hasData) {
              final pvDataSearch = pvSearch.pvDataSearch!.restaurants;
              return ListViewCustom(
                listLength: pvDataSearch.length,
                listData: pvDataSearch,
                provider: pvDetail,
              );
            } else if (pvSearch.state == SearchResultState.error) {
              if (searchVal == '') {
                return Column(
                  children: const [
                    ListDataWidget(),
                  ],
                );
              } else {
                return Text(pvSearch.message);
              }
            } else {
              if (pvSearch.state == SearchResultState.noData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search_off_rounded,
                      size: 200,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    Text(
                      'Not Found!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(fontSize: 24),
                    )
                  ],
                );
              } else {
                return Column(
                  children: const [
                    ListDataWidget(),
                  ],
                );
              }
            }
          },
        ),
      ),
    );
  }
}
