import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:lab2mobile/domain/barbershop.dart';
import 'package:lab2mobile/presentation/widgets/barbershop_card.dart';

class BarbershopRecommendation extends StatefulWidget {
  @override
  _BarbershopRecommendationState createState() =>
      _BarbershopRecommendationState();
}

class _BarbershopRecommendationState extends State<BarbershopRecommendation> {
  int _currentIndex = 0;
  List<Barbershop> listBarbershops = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadListData();
  }

  Future<void> loadListData() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/v2.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      print('Loaded JSON data: ${jsonData['list']}');

      setState(() {
        listBarbershops = (jsonData['list'] as List)
            .map((item) => Barbershop.fromJson(item))
            .toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error loading JSON data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (listBarbershops.isEmpty) {
      return Center(child: Text('No data available'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                listBarbershops[_currentIndex].imageUrl,
                width: double.infinity,
                height: 230,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    width: double.infinity,
                    height: 230,
                    color: Colors.grey[200],
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 230,
                    color: Colors.grey[200],
                    child: Icon(Icons.error),
                  );
                },
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Color(0xFF363062),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      'Booking',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12),
              Text(
                listBarbershops[_currentIndex].name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111827),
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: Color(0xFF6B7280)),
                  SizedBox(width: 5),
                  Text(
                    '${listBarbershops[_currentIndex].location} (${listBarbershops[_currentIndex].distance})',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.star, size: 16, color: Colors.orange),
                  SizedBox(width: 5),
                  Text(
                    listBarbershops[_currentIndex].rating.toString(),
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: listBarbershops.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = entry.key;
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                width: _currentIndex == entry.key ? 35 : 10,
                height: 10,
                decoration: BoxDecoration(
                  color: _currentIndex == entry.key
                      ? Color(0xFF363062)
                      : Color(0xFFC4C4C4),
                  borderRadius: _currentIndex == entry.key
                      ? BorderRadius.circular(5)
                      : BorderRadius.circular(50),
                ),
              ),
            );
          }).toList(),
        ),
        Column(
          children: listBarbershops.map((barbershop) {
            return BarbershopCard(barbershop: barbershop);
          }).toList(),
        ),
      ],
    );
  }
}
