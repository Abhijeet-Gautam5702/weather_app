import 'dart:ui';

import 'package:flutter/material.dart';

class AdditionalInfoCard extends StatelessWidget {
  const AdditionalInfoCard(
      {Key? key,
      required this.infoValue,
      required this.title,
      required this.icon})
      : super(key: key);

  final String infoValue;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 35,
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            infoValue,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
