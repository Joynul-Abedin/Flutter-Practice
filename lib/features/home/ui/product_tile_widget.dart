import 'package:flutter/material.dart';
import 'package:flutter_bloc_tutorial/features/home/bloc/home_bloc.dart';
import 'package:flutter_bloc_tutorial/features/home/models/home_product_data_model.dart';
import 'dart:math';

class ProductTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;


  const ProductTileWidget(
      {super.key, required this.productDataModel, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [Center(
        child: Container(
          width: screenSize.width,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeInImage(
                placeholder: NetworkImage('https://media2.giphy.com/media/xTk9ZvMnbIiIew7IpW/giphy.gif?cid=ecf05e47bifdfc6snk3kuuhg29r2gaz6699zq0bbcnes3oqg&ep=v1_gifs_search&rid=giphy.gif&ct=g'),
                image: NetworkImage(productDataModel.url),
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              Text(productDataModel.id.toString(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(productDataModel.title),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("\$" + ((productDataModel.id / (Random().nextInt(10) + 1))).toStringAsFixed(2),
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            homeBloc.add(HomeProductWishlistButtonClickedEvent(
                                clickedProduct: productDataModel));
                          },
                          icon: Icon(Icons.favorite_border)),
                      IconButton(
                          onPressed: () {
                            homeBloc.add(HomeProductCartButtonClickedEvent(
                                clickedProduct: productDataModel));
                          },
                          icon: Icon(Icons.shopping_bag_outlined)),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
