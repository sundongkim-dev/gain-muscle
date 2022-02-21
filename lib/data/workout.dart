class Workout {
  final String name;
  final String category;
  final String img;
  final bool mark;

  Workout.fromMap(Map<String, dynamic> map)
    : name = map['name'],
      category = map['category'],
      img = map['img'],
      mark = map['mark'];

  @override
  String toString() => "Workout<$name:category>";
}