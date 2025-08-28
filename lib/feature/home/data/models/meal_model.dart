class MealModel {
  final int? id;
  final String title;
  final String image;
  final double calories;
  final double rate;
  final String time;
  final String description;

  MealModel({
     this.id,
    required this.title,
    required this.image,
    required this.calories,
    required this.rate,
    required this.time,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'title': title,
      'imageUrl': image,
      'calories': calories,
      'rate': rate,
      'time': time,
      'description': description,
    };
  }

  factory MealModel.fromMap(Map<String, dynamic> map) {
    return MealModel(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      image: map['imageUrl'] ?? '',
      calories: map['calories'] ?? 0.0,
      rate: map['rate'] ?? 0.0,
      time: map['time'] ?? '',
      description: map['description'] ?? '',
    );
  }
}
