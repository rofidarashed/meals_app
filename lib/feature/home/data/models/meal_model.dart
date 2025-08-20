class MealModel {
  final String title;
  final String image;
  final String calories;
  final double rate;
  final String time;
  final String description;

  MealModel({
    required this.title,
    required this.image,
    required this.calories,
    required this.rate,
    required this.time,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
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
      title: map['title'],
      image: map['imageUrl'],
      calories: map['calories'],
      rate: map['rate'],
      time: map['time'],
      description: map['description'],
    );
  }
}
