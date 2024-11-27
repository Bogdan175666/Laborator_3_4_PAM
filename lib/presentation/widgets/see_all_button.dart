import 'package:flutter/material.dart';

class SeeAllButton extends StatelessWidget {
  const SeeAllButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF2E2769), width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'See All',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E2769),
            ),
          ),
          SizedBox(width: 8),
          Icon(
            Icons.open_in_new,
            color: Color(0xFF2E2769),
            size: 18,
          ),
        ],
      ),
    );
  }
}
