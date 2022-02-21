import 'package:flutter/material.dart';
import 'package:gain_muscle/tmp/controller.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'daily_input_view.dart';

class WorkoutPlanner extends StatefulWidget {
  const WorkoutPlanner({Key? key, required this.today}) : super(key: key);

  final DateTime today;

  @override
  _WorkoutPlannerState createState() => _WorkoutPlannerState();
}

class _WorkoutPlannerState extends State<WorkoutPlanner> {
  final controller = Get.put(Controller());
  final textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final GroupButtonController _groupButtonController = GroupButtonController();
  bool _isGroupButtonVisible = true;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChanged);
  }
  void _onFocusChanged() {
    setState(() {
      _focusNode.hasFocus
          ? _isGroupButtonVisible = false
          : _isGroupButtonVisible = true;

      if (_isGroupButtonVisible) {
        _groupButtonController.unselectAll();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Controller>(builder: (_) {
      return Scaffold(
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(Icons.arrow_back)),
                      Text(
                        widget.today.month.toString() +
                            "." +
                            widget.today.day.toString() +
                            '  운동계획',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ],
                  )),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                      labelText: '찾으시는 운동을 검색해보세요',
                    )),
              ),

              Container(
                // width: 800,
                height: 80,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    partStuff('하체', 0),
                    partStuff('가슴', 1),
                    partStuff('등', 2),
                    partStuff('어깨', 3),
                    partStuff('유산소', 4),
                    partStuff('팔', 5),
                  ],
                ),
              ),
              Expanded(
                child: _.exerciseList[_.index],
              ),
              Divider(
                thickness: 2,
              ),
              Container(
                // height: 70,
                child: Column(
                  children: [
                    Container(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          for (int i = 0; i < _.exerciseBasket.length; i++)
                            OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  print("!@3");
                                  _.exerciseBasket.remove(_.exerciseBasket[i]);
                                });
                              },
                              child: Row(
                                children: [
                                  Text(
                                    _.exerciseBasket[i],
                                    // style: TextStyle(color: Colors.black),
                                  ),
                                  Icon(Icons.close)
                                ],
                              ),
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.black),
                                side: MaterialStateProperty.all(
                                    BorderSide(color: Colors.white)),
                              ),
                            ),
                          // Text(_.exerciseBasket[i])
                        ],
                        scrollDirection: Axis.horizontal,
                      ),
                      height: 30,
                    ),
                    FloatingActionButton.extended(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      onPressed: () async {
                        Get.to(() => DailyInputView(today: widget.today));
                        setState(() {});
                      },
                      label: Text('운동 담기(${_.exerciseBasket.length})'),
                      icon: Icon(Icons.shopping_cart),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

Padding partStuff(String name, int idx) {
  bool tapped = false;
  return Padding(
    padding: EdgeInsets.fromLTRB(5, 20, 5, 20),
    child: OutlinedButton(
      onPressed: () {
        Get.find<Controller>().exerciseTapped(idx);
      },
      child: Text(
        name,
      ),
      style: ButtonStyle(
        foregroundColor: idx == Get.find<Controller>().index
            ? MaterialStateProperty.all(Colors.white)
            : MaterialStateProperty.all(Colors.black),
        backgroundColor: idx == Get.find<Controller>().index
            ? MaterialStateProperty.all(Colors.blue.shade300)
            : MaterialStateProperty.all(Colors.white),
        side: MaterialStateProperty.all(BorderSide(color: Colors.black)),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
          ),
        ),
      ),
    ),
  );
}

Padding exerciseStuff(String name) {
  return Padding(
    padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
    child: Row(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
          child: Image.asset(
            'assets/Img/userviewImg/strong.png',
            width: 40,
            height: 40,
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text(name),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
          child: Icon(Icons.favorite),
        ),
      ],
    ),
  );
}

