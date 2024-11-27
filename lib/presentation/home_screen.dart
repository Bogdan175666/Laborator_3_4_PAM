import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:lab2mobile/presentation/widgets/barbershop_card.dart';
import 'package:lab2mobile/presentation/widgets/barbershop_card_extend.dart';
import 'package:lab2mobile/presentation/widgets/see_all_button.dart';
import 'package:lab2mobile/presentation/widgets/user_profile.dart';
import 'package:lab2mobile/presentation/widgets/search_bar.dart' as custom;
import 'package:lab2mobile/presentation/widgets/booking_card.dart';
import 'package:lab2mobile/domain/barbershop.dart';
import 'package:lab2mobile/data/static_data.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Funcție pentru a încărca datele JSON din fișierul local
  Future<Map<String, dynamic>> loadJsonData() async {
    final String jsonString = await rootBundle.loadString('assets/v2.json');
    return json.decode(jsonString); // Parsează string-ul JSON într-un map
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Setează fundalul aplicației
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30), // Margine pentru conținut
        child: FutureBuilder<Map<String, dynamic>>(
          future: loadJsonData(), // Așteaptă datele JSON
          builder: (context, snapshot) {
            // Afișează un indicator de încărcare până când datele sunt disponibile
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            // Afișează eroarea în caz de eșec
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            // Afișează un mesaj dacă nu sunt date
            if (!snapshot.hasData) {
              return Center(child: Text('No data available'));
            }

            // Obține datele JSON
            final jsonData = snapshot.data!;
            // Conversie date din JSON în obiecte Barbershop
            final nearestBarbershops = (jsonData['nearest_barbershop'] as List)
                .map((item) => Barbershop.fromJson(item))
                .toList();
            final mostRecommended = (jsonData['most_recommended'] as List)
                .map((item) => Barbershop.fromJson(item))
                .toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Aliniere la stânga
              children: [
                const SizedBox(height: 70), // Spațiu liber sus
                // Afișează profilul utilizatorului curent
                UserProfile(user: currentUser), // currentUser definit în static_data
                SizedBox(height: 30),
                BookingCard(), // Card pentru rezervare
                SizedBox(height: 30),
                custom.SearchBar(controller: TextEditingController()), // Bara de căutare personalizată

                // Secțiunea "Nearest Barbershop"
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Nearest Barbershop',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF111827),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Plus Jakarta Sans',
                    ),
                  ),
                ),
                // Creează o listă de carduri Barbershop din datele nearestBarbershops
                ...nearestBarbershops
                    .map((barbershop) => BarbershopCard(barbershop: barbershop))
                    .toList(),

                // Buton "See All" pentru secțiunea "Nearest Barbershop"
                Center(child: SeeAllButton()),

                // Secțiunea "Most Recommended"
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Most Recommended',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF111827),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Plus Jakarta Sans',
                    ),
                  ),
                ),
                // Extensie pentru recomandările frizeriilor
                BarbershopRecommendation(),
              ],
            );
          },
        ),
      ),
    );
  }
}
