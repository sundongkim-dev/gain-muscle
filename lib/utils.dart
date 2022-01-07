// ListTile 편하게 쓰려고 만든 클래스
import 'package:flutter/material.dart';

class ExerciseTile extends StatelessWidget {
  const ExerciseTile(
      {Key? key, required this.name, required this.weight, required this.rep})
      : super(key: key);

  final String name;
  final String weight;
  final String rep;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.favorite,
        color: Colors.red[300],
      ),
      title: Text(name + " " + weight + "kg " + rep + "회"),
      // title: Text(routine),
      subtitle: Text("운동볼륨 ${int.parse(weight) * int.parse(rep)}kg"),
    );
  }
}

class Record {
  String uid;
  List<dynamic> exercise;
  // List<String> time;
  List<dynamic> time;

  Record({
    required this.uid,
    required this.exercise,
    required this.time,
  });

  Record.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        exercise = json['exercise'],
        time = json['time'];

  Map<String, dynamic> toJson() =>
      {'uid': uid, 'exercise': exercise, 'time': time};
}
