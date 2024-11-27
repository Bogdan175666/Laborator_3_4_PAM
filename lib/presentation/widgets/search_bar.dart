import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;

  const SearchBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Color(0xFFEBF0F5),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 162, 165, 172),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: "Search barber's, haircut ser...",
                      hintStyle: TextStyle(
                        color: Color(0xFF6B7280),
                        fontFamily: 'Plus Jakarta Sans',
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 20),
        Container(
          padding: EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: Color(0xFF363062),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(Icons.tune, color: Color(0xFFFFFFFF)),
        ),
      ],
    );
  }
}
