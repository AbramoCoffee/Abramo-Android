import 'package:abramo_coffee/resources/color.dart';
import 'package:abramo_coffee/resources/font.dart';
import 'package:abramo_coffee/utils/dotted_line.dart';
import 'package:abramo_coffee/utils/rupiah_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget invoiceCard() => Container(
      padding: const EdgeInsets.all(10),
      color: cWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Text("Abramo Coffee",
                style: bold.copyWith(fontSize: 20, color: cBlack)),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text("Jl. Pulasaren No 102, Cirebon",
                style: regular.copyWith(fontSize: 15, color: cBlack)),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(DateFormat('dd-MM-yyyy').format(DateTime.now()),
                style: regular.copyWith(fontSize: 15, color: cBlack)),
          ),
          const SizedBox(height: 30),
          Center(
            child: Text("Pesanan",
                style: regular.copyWith(fontSize: 15, color: cBlack)),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Column(
                children: [
                  Text("Bakmi Ayam",
                      style: regular.copyWith(fontSize: 15, color: cBlack)),
                  const SizedBox(height: 3),
                  Text("2 x ${RupiahUtils.beRupiah(25000)}",
                      style: regular.copyWith(fontSize: 15, color: cBlack)),
                ],
              ),
              const Spacer(),
              Text(RupiahUtils.beRupiah(50000),
                  style: regular.copyWith(fontSize: 15, color: cBlack)),
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  Text("Bakmi Ayam",
                      style: regular.copyWith(fontSize: 15, color: cBlack)),
                  const SizedBox(height: 3),
                  Text("2 x ${RupiahUtils.beRupiah(25000)}",
                      style: regular.copyWith(fontSize: 15, color: cBlack)),
                ],
              ),
              const Spacer(),
              Text(RupiahUtils.beRupiah(50000),
                  style: regular.copyWith(fontSize: 15, color: cBlack)),
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  Text("Bakmi Ayam",
                      style: regular.copyWith(fontSize: 15, color: cBlack)),
                  const SizedBox(height: 3),
                  Text("2 x ${RupiahUtils.beRupiah(25000)}",
                      style: regular.copyWith(fontSize: 15, color: cBlack)),
                ],
              ),
              const Spacer(),
              Text(RupiahUtils.beRupiah(50000),
                  style: regular.copyWith(fontSize: 15, color: cBlack)),
            ],
          ),
          const SizedBox(height: 15),
          Center(
            child: CustomPaint(painter: DrawDottedhorizontalline()),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Text("Total",
                  style: regular.copyWith(fontSize: 15, color: cBlack)),
              const Spacer(),
              Text(RupiahUtils.beRupiah(50000),
                  style: regular.copyWith(fontSize: 15, color: cBlack)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text("Bayar",
                  style: regular.copyWith(fontSize: 15, color: cBlack)),
              const Spacer(),
              Text(RupiahUtils.beRupiah(60000),
                  style: regular.copyWith(fontSize: 15, color: cBlack)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text("Kembalian",
                  style: regular.copyWith(fontSize: 15, color: cBlack)),
              const Spacer(),
              Text(RupiahUtils.beRupiah(10000),
                  style: regular.copyWith(fontSize: 15, color: cBlack)),
            ],
          ),
          const SizedBox(height: 30),
          Center(
            child: Text("Terima Kasih",
                style: regular.copyWith(fontSize: 15, color: cBlack)),
          ),
        ],
      ),
    );
