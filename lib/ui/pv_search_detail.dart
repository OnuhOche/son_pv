import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:son_pv/provider/pvdetail_provider.dart';

class PvDetail extends StatefulWidget {
  const PvDetail({Key? key}) : super(key: key);

  @override
  State<PvDetail> createState() => _PvDetailState();
}

class _PvDetailState extends State<PvDetail> {
  @override
  Widget build(BuildContext context) {
    final double flexWidth = MediaQuery.of(context).size.width;
    final double flexHeight = MediaQuery.of(context).size.height;
    final pvDetail = Provider.of<PvDetailProvider>(context);
    final pvDetailData = pvDetail.pvDetailApi?.restaurant;

    Widget menus({
      required String categoryName,
      required String image,
      required String category,
    }) {
      return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              categoryName,
              style: GoogleFonts.poppins(
                  fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: pvDetailData?.menus.foods.length ?? 0,
                itemBuilder: (context, index) {
                  if (pvDetail.pvDetailApi != null) {
                    final food = pvDetailData!.menus.foods[index];
                    final drink = pvDetailData.menus.drinks[index];
                    return Container(
                      width: 200,
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.3),
                                BlendMode.darken),
                            fit: BoxFit.cover,
                            image: AssetImage(image)),
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            category == 'foods' ? food.name : drink.name,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            )
          ],
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        body: Builder(builder: (context) {
          if (pvDetail.state == DetailResultState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (pvDetail.state == DetailResultState.hasData) {
            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    automaticallyImplyLeading: false,
                    floating: true,
                    expandedHeight: flexHeight * 0.25,
                    stretch: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Hero(
                        tag: 'https://restaurant-api.dicoding.dev/images/medium/${pvDetail.pvDetailApi!.restaurant.pictureId}',
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30))),
                          child: Image.network(
                            'https://restaurant-api.dicoding.dev/images/medium/${pvDetail.pvDetailApi!.restaurant.pictureId}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  )
                ];
              },
              body: Container(
                width: flexWidth,
                height: flexHeight,
                child: ListView(
                  children: [
                    Container(
                      margin:
                          const EdgeInsets.only(top: 10, left: 15, right: 10),
                      width: flexWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pvDetailData?.name ?? "Loading...",
                            style: GoogleFonts.poppins(
                                fontSize: 32, fontWeight: FontWeight.w500),
                          ),
                          Column(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 8, bottom: 8),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.pin_drop_sharp,
                                      color: Colors.red.withOpacity(0.8),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${pvDetailData!.address}, ${pvDetailData.city}',
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Colors.black.withOpacity(0.5)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.orange.withOpacity(0.9),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      pvDetailData.rating.toString(),
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.5)),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: flexWidth,
                      margin:
                          const EdgeInsets.only(top: 20, left: 15, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description',
                            style: GoogleFonts.poppins(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            pvDetailData.description,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: flexWidth,
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      height: 450,
                      margin:
                          const EdgeInsets.only(top: 20, left: 15, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          menus(
                            category: 'foods',
                            categoryName: 'Foods',
                            image: 'assets/images/food.jpg',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          menus(
                            category: 'drinks',
                            categoryName: 'Drinks',
                            image: 'assets/images/drink.jpg',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 15, right: 10, bottom: 15),
                      child: Text('Reviews',
                        style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      width: flexWidth,
                      height: flexHeight*0.4,
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        itemCount: pvDetailData.customerReviews.length,
                        itemBuilder: (context, index) {
                          if (pvDetail.pvDetailApi != null) {
                            final cusReview = pvDetailData.customerReviews[index];
                            return ListTile(
                              leading: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                                child: const Icon(
                                  Icons.person_rounded, 
                                  color: Colors.white,
                                  size: 30,),),
                              isThreeLine: true,
                              title: Text(cusReview.name,
                                style: const TextStyle(
                                  fontSize: 20
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(cusReview.review,
                                    style: const TextStyle(
                                      fontSize: 16
                                    ),
                                  ),
                                  Text(cusReview.date)
                                ],
                              ),
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          } else if (pvDetail.state == DetailResultState.noData) {
            return Center(
              child: Material(
                child: Text(pvDetail.message),
              ),
            );
          } else if (pvDetail.state == DetailResultState.error) {
            return Center(
              child: Material(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.wifi_off_rounded, size: 150,),
                    Text(pvDetail.message,
                      style: const TextStyle(
                        fontSize: 25
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: Material(
                child: Text(''),
              ),
            );
          }
        }),
      ),
    );
  }
}