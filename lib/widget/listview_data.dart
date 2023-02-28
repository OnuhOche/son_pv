import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ListViewCustom extends StatelessWidget {
  final int listLength;
  final dynamic listData;
  final dynamic provider;
  const ListViewCustom({super.key, required this.listLength, required this.listData, required this.provider});

  @override
  Widget build(BuildContext context) {
    Widget buildPvItem(BuildContext context, dynamic pvData) {
      return TweenAnimationBuilder(
        tween: Tween<double>(
          begin: 100,
          end: 5
        ),
        duration: const Duration(seconds: 1),
        builder: (context, double value, child) => 
        Card(
          margin: EdgeInsets.only(top: value, left: 10, right: 10),
          elevation: 0.5,
          child: ListTile(
            onTap: (){
              provider.fetchAllDetailDataPv(pvData.id);
              Navigator.pushNamed(context, '/pvDetail');
            },

            isThreeLine: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            leading: Hero(
              tag: 'https://restaurant-api.dicoding.dev/images/medium/${pvData.pictureId}',
              child: Image.network(
                'https://restaurant-api.dicoding.dev/images/medium/${pvData.pictureId}',
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              pvData.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.pin_drop_rounded, size: 16,color: Colors.red.withOpacity(0.8),),
                    const SizedBox(width: 5,),
                    Text(pvData.city)
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.star, size: 16,color: Colors.orange.withOpacity(0.9),),
                    const SizedBox(width: 5,),
                    Text(pvData.rating.toString()),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
    return ListView.builder(
      itemCount: listLength,
      itemBuilder:(context, index) {
        return buildPvItem(context, listData[index]);
      },
    );
  }
}