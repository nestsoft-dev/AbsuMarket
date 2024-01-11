import 'package:absumarket/constants/colors.dart';
import 'package:flutter/material.dart';

import '../functions/functions.dart';
import '../widgets/recent_card.dart';
import 'view_product.dart';

class ViewAllProduct extends StatelessWidget {
  final String categoryName;
  const ViewAllProduct({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder(
          future: getProductByCategories(categoryName),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!.length==0?const Center(child: Text('No Product Available'),): GridView.builder(
                  itemCount: snapshot.data!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 280,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemBuilder: (_, index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewProducts(
                                        product: snapshot.data![index],
                                      )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: RecentsCard(
                            model: snapshot.data![index],
                          ),
                        ),
                      ));
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Error: 404'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: deepBlue,
                ),
              );
            }
          }),
    );
  }
}
