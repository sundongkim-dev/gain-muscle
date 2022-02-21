class Workout {
  final String category;
  final String name;

  const Workout(this.category, this.name);

  @override
  String toString() {
    return '$category: $name';
  }

  // workout_planner 뷰에서 운동 검색 기능에 활용
  bool contains(String pattern) {
    String tmp = category + ': ' + name;
    return tmp.contains(pattern);
  }
}

// 운동 예시
final List<Workout> workoutList = [
  Workout('Chest', 'BenchPress'),
  Workout('Chest', 'DumbbellPress'),
  Workout('Chest', 'DumbbellFly'),
  Workout('Shoulder', 'ShoulderPress'),
  Workout('Shoulder', 'ArnoldPress'),
  Workout('Shoulder', 'SideLateralRaise'),
  Workout('Back', 'DeadLift'),
  Workout('Back', 'BarbellRow'),
  Workout('Back', 'LatPullDown'),
  Workout('Arm', 'BarbellCurl'),
  Workout('Arm', 'HammerCurl'),
  Workout('Arm', 'TricepsPushDown'),
  Workout('Legs', 'Squat'),
  Workout('Legs', 'LegPress'),
  Workout('Legs', 'LegExtension'),
];