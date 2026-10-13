class Doctor {
  final String id;
  final String name;
  final String specialty;
  final String imageUrl;
  final String location;
  final String distance;
  final double rating;
  final bool isFavorite;

  const Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.imageUrl,
    this.location = '',
    this.distance = '',
    this.rating = 4.8,
    this.isFavorite = false,
  });
}
