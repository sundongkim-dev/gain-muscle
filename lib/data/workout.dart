/*class Workout {
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
}*/

class Workout {
  final String category;
  final String name;

  const Workout(this.category, this.name);

  @override
  String toString() {
    //return '$category: $name';
    return '$name';
  }

  // workout_planner 뷰에서 운동 검색 기능에 활용
  bool contains(String pattern) {
    String tmp = category + ': ' + name;
    print(tmp);
    return tmp.contains(pattern);
  }
}

// 전체 탭 추가했기에 검색을 위해 전체를 카테고리에 붙여서 저장
final List<Workout> workoutList = [
  Workout('전체가슴', '벤치프레스'),
  Workout('전체가슴', '인클라인 벤치프레스'),
  Workout('전체가슴', '덤벨 벤치프레스'),
  Workout('전체어깨', '오버헤드 프레스'),
  Workout('전체어깨', '덤벨 숄더 프레스'),
  Workout('전체어깨', '덤벨 레터럴 레이즈'),
  Workout('전체등', '풀업'),
  Workout('전체등', '바벨 로우'),
  Workout('전체등', '렛풀다운'),
  Workout('전체등', '시티드 로우 머신'),
  Workout('전체팔', '바벨 컬'),
  Workout('전체팔', '덤벨 컬'),
  Workout('전체팔', '덤벨 삼두 익스텐션'),
  Workout('전체팔', '덤벨 킥백'),
  Workout('전체하체', '바벨 백스쿼트'),
  Workout('전체하체', '컨벤셔널 데드리프트'),
  Workout('전체하체', '레그 프레스'),
  Workout('전체유산소', '달리기'),
  Workout('전체유산소', '로잉머신'),
];