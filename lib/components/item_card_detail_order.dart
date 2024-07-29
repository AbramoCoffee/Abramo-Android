import 'dart:developer';

import 'package:abramo_coffee/components/image_component.dart';
import 'package:abramo_coffee/models/order_item_model.dart';
import 'package:abramo_coffee/resources/color.dart';
import 'package:abramo_coffee/resources/constant.dart';
import 'package:abramo_coffee/resources/font.dart';
import 'package:abramo_coffee/utils/rupiah_utils.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ItemCardDetailOrder extends StatelessWidget {
  const ItemCardDetailOrder({super.key, required this.orderItemModel});

  final OrderItemModel orderItemModel;

  @override
  Widget build(BuildContext context) {
    final _box = GetStorage();

    String userRole = _box.read(uRole);
    log("image order item : ${orderItemModel.menu!.image}");
    return Card(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                    text: orderItemModel.menu!.name ?? "Error",
                    style: bold.copyWith(color: cYellowDark, fontSize: 17))),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ImageComponent(
                    source: "${baseUrl}${orderItemModel.menu!.image}"),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(orderItemModel.menu?.code ?? "Error",
                        style: bold.copyWith(color: cYellowDark, fontSize: 20)),
                    const SizedBox(height: 8),
                    Text(
                      "${orderItemModel.qty} pcs",
                      style: bold.copyWith(color: cYellowPrimary, fontSize: 16),
                    ),
                    // RichText(
                    //     maxLines: 3,
                    //     overflow: TextOverflow.ellipsis,
                    //     text: TextSpan(
                    //         text: orderItemModel.product!.name ?? "Error",
                    //         style: bold.copyWith(
                    //             color: cYellowDark, fontSize: 17))),
                    // Text(orderItemModel.product!.name ?? "Error",
                    //     // maxLines: 4,
                    //     overflow: TextOverflow.visible,
                    //     style: bold.copyWith(color: cYellowDark, fontSize: 17)),
                    const SizedBox(height: 8),
                    userRole == "kitchen"
                        ? SizedBox()
                        : Text(
                            RupiahUtils.beRupiah(
                                orderItemModel.menu?.price ?? 0),
                            style: bold.copyWith(
                                color: cYellowPrimary, fontSize: 16),
                          )
                  ],
                )
              ],
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}
