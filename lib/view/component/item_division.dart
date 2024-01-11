import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview_task/model/home_model.dart';
import 'package:interview_task/utiles/extension.dart';

import '../image_viewer.dart';

class ItemDivision extends StatelessWidget {
  const ItemDivision({super.key, required this.data});
  final List<SubDatum> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2.hp),
      child: data.isEmpty
          ? const Center(child: Text("Data Not Fount"))
          : GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 1.1,
              mainAxisSpacing: 1.5.wp,
              crossAxisSpacing: 1.5.wp,
              children: data.map((value) {
                return GestureDetector(
                  onTap: () {
                    Get.to(ImageViewer(
                      imgUrl: value.imageUrl,
                      name: value.collectionName,
                    ));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(1.wp),
                    child: CachedNetworkImage(
                      imageUrl: value.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
            ),
    );
  }
}
