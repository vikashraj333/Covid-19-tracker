import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ReusableRow extends StatelessWidget {
  final String title, value;
  const ReusableRow({required this.title, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              title.text.make(),
              value.text.make(),
            ],
          ),
          5.heightBox,
          const Divider(),
        ],
      ),
    );
  }
}
