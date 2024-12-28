// ignore_for_file: deprecated_member_use

import 'package:currency/model_api/ModelApi.dart';
import 'package:flutter/material.dart';

class HomeViewsList extends StatelessWidget {
  final ModelApi modelApi;
  const HomeViewsList({super.key, required this.modelApi});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Text(
            modelApi.code.toString(),
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const Spacer(),
          Text(
            modelApi.value!.toStringAsFixed(3).toString(),
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          )
        ],
      ),
    );
  }
}
