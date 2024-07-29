import 'package:abramo_coffee/components/button_component.dart';
import 'package:abramo_coffee/resources/color.dart';
import 'package:abramo_coffee/resources/font.dart';
import 'package:abramo_coffee/utils/rupiah_utils.dart';
import 'package:flutter/material.dart';

class ItemHistoryComponent extends StatelessWidget {
  const ItemHistoryComponent({
    super.key,
    required this.price,
    required this.invoiceName,
    required this.status,
    required this.onTap,
  });

  final int price;
  final String invoiceName;
  final String status;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(children: [
          Column(
            children: [
              const Icon(
                Icons.shopping_bag,
                color: cYellowDark,
                size: 80,
              ),
              Text(
                "Total Harga",
                style: bold.copyWith(color: cYellowDark, fontSize: 17),
              ),
              Text(
                RupiahUtils.beRupiah(price),
                style: regular.copyWith(color: cYellowDark, fontSize: 15),
              )
            ],
          ),
          const SizedBox(width: 20),
          SizedBox(
            width: 190,
            height: 100,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    invoiceName,
                    style: bold.copyWith(color: cYellowDark, fontSize: 15),
                  ),
                  Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: cYellowDark,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      padding: const EdgeInsets.fromLTRB(11, 3, 11, 3),
                      child: status == "proses"
                          ? Text(status,
                              style:
                                  regular.copyWith(fontSize: 15, color: cRed))
                          : Text(status,
                              style: regular.copyWith(
                                  fontSize: 15, color: cYellowDark)))
                ],
              ),
              // const SizedBox(height: 3),
              // Text(
              //   "$totalBarang barang",
              //   style: regular.copyWith(color: cYellowPrimary, fontSize: 15),
              // ),
              const SizedBox(height: 3),
              ButtonComponent("Detail", onPressed: onTap, color: cYellowDark)
            ]),
          )
        ]),
      ),
    );
  }
}
