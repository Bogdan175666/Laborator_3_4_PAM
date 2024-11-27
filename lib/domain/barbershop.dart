class Barbershop {
  // Proprietăți ale clasei Barbershop
  final String name; // Numele frizeriei
  final String location; // Locația frizeriei (extrase din "location_with_distance")
  final String imageUrl; // URL-ul imaginii asociate frizeriei
  final double rating; // Rating-ul frizeriei
  final String distance; // Distanța până la frizerie (extrase din "location_with_distance")

  // Constructor care initializează toate proprietățile clasei
  Barbershop({
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.rating,
    required this.distance,
  });

  // Factory constructor pentru a crea o instanță de Barbershop dintr-un obiect JSON
  factory Barbershop.fromJson(Map<String, dynamic> json) {
    // Preluăm câmpul "location_with_distance" care conține locația și distanța într-un singur string
    final locationWithDistance = json['location_with_distance'] as String;

    // Împărțim string-ul în două părți: locația și distanța
    final parts = locationWithDistance.split('('); // Ex: "City Center (5 km)"
    final location = parts[0].trim(); // Extrage locația, ex: "City Center"
    final distance = parts[1].replaceAll(')', '').trim(); // Extrage distanța, ex: "5 km"

    // Returnăm un obiect Barbershop cu datele extrase din JSON
    return Barbershop(
      name: json['name'], // Preluăm numele frizeriei
      location: location, // Setăm locația extrasă
      imageUrl: json['image'], // URL-ul imaginii din JSON
      rating: json['review_rate'].toDouble(), // Conversia rating-ului la double
      distance: distance, // Setăm distanța extrasă
    );
  }
}
