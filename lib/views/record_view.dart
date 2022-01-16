import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils.dart';
import 'daily_record_view.dart';

class RecordView extends StatefulWidget {
  const RecordView({Key? key}) : super(key: key);

  @override
  _RecordViewState createState() => _RecordViewState();
}

class _RecordViewState extends State<RecordView> {
  @override
  Widget build(BuildContext context) {
    String userName = FirebaseAuth.instance.currentUser!.displayName as String;
    CollectionReference recordDB =
        FirebaseFirestore.instance.collection('user/$userName/record');

    List<Object?> record = [];

    Future<void> getData() async {
      // Get docs from collection reference
      QuerySnapshot querySnapshot = await recordDB.get();

      // Get data from docs and convert map to List
      record = querySnapshot.docs.map((doc) => doc.data()).toList();

      print(record);
    }

    return Container(
      child: Text('지금 만드는중 '),
    );

    // return FutureBuilder<DocumentSnapshot>(
    //   future: getData(),
    //   builder: (BuildContext context, AsyncSnapshot<Future<void>> snapshot) {
    //     if (snapshot.hasError) {
    //       return Text("Something went wrong");
    //     }

    //     if (snapshot.hasData && !snapshot.data!.exists) {
    //       print(userName);
    //       getData();
    //       return Text("Document does not exist");
    //     }

    //     if (snapshot.connectionState == ConnectionState.done) {
    //       Map<String, dynamic> data =
    //           snapshot.data!.data() as Map<String, dynamic>;
    //       return Text("Full Name: ${data['full_name']} ${data['last_name']}");
    //     }

    //     return Text("loading");
    //   },
    // );
  }
}

  //   return Container(
  //     child: TextButton(
  //       child: Text('하하'),
  //       onPressed: getRecord,
  //     ),
  //   );
  //   // return FutureBuilder(
  //   //   future: userDB.doc(userName).get(),
  //   //   builder:
  //   //       (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
  //   //     if (snapshot.hasError) {
  //   //       return Text("데이터를 불러올때 문제가 발생했습니다");
  //   //     }

  //   //     if (snapshot.hasData && !snapshot.data!.exists) {
  //   //       getRecord();
  //   //       return Center(
  //   //         child: Column(
  //   //           mainAxisAlignment: MainAxisAlignment.center,
  //   //           children: [
  //   //             Text('입력된 기록이 없습니다. 기록을 입력해주세요'),
  //   //             ElevatedButton(
  //   //                 onPressed: () => Get.to(() => DailyRecordView()),
  //   //                 child: Text('기록 입력하러 이동하기')),
  //   //           ],
  //   //         ),
  //   //       );
  //   //     }

  //   //     if (snapshot.connectionState == ConnectionState.done) {
  //   //       Map<String, dynamic> data =
  //   //           snapshot.data!.data() as Map<String, dynamic>;
  //   //       return Text("Full Name: ${data['full_name']} ${data['last_name']}");
  //   //     }

  //   //     // print('이거 잘 보시게');
  //   //     // print(data);
  //   //     // return Text('wait a moemtn');
  //   //     // return Scaffold(
  //   //     //   resizeToAvoidBottomInset: false,
  //   //     //   body: SingleChildScrollView(
  //   //     //     child: Column(
  //   //     //       crossAxisAlignment: CrossAxisAlignment.center,
  //   //     //       children: [
  //   //     //         for (int i = record.time.length - 1; i >= 0; i--)
  //   //     //           ListView.separated(
  //   //     //             physics: const NeverScrollableScrollPhysics(),
  //   //     //             scrollDirection: Axis.vertical,
  //   //     //             shrinkWrap: true,
  //   //     //             itemCount: record.exercise[i].length + 1,
  //   //     //             itemBuilder: (context, index) {
  //   //     //               if (index == 0) {
  //   //     //                 return ListTile(
  //   //     //                   title: Text(record.time[i] + "의 운동"),
  //   //     //                 );
  //   //     //               }
  //   //     //               return ExerciseTile(
  //   //     //                   name: record.exercise[i][index - 1][0],
  //   //     //                   weight: record.exercise[i][index - 1][1],
  //   //     //                   rep: record.exercise[i][index - 1][2]);
  //   //     //             },
  //   //     //             separatorBuilder: (context, index) {
  //   //     //               // if (index == 0) return SizedBox.shrink();
  //   //     //               return Divider();
  //   //     //             },
  //   //     //           ),
  //   //     //       ],
  //   //     //     ),
  //   //     //   ),
  //   //     // );

  //   //     return CircularProgressIndicator();
  //   //   },
  //   // );
  // }
// }
