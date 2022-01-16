import 'package:flutter/material.dart';
import 'package:path/path.dart';

class itemView extends StatefulWidget {
  const itemView({Key? key}) : super(key: key);

  @override
  _itemViewState createState() => _itemViewState();
}

class _itemViewState extends State<itemView> {
  Padding item(String name, String url, String ability) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 25, 20, 10),
      child: Column(
        children: [
          Text(name),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(url), fit: BoxFit.fill)),
            width: 80,
            height: 80,
            alignment: Alignment.bottomCenter,
            child: Text(
              ability,
              style:
                  TextStyle(backgroundColor: Colors.white, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.fromLTRB(30, 40, 0, 30),
            child: Text(
              '나의 캐릭터',
              style: TextStyle(fontSize: 30),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
                'https://i.pinimg.com/564x/b3/4a/24/b34a2477d34e74de15e3a5d6242b4b78.jpg'),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 30),
            child: Text(
              '캐릭터 스토리 보기',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 0, 15),
            child: Text(
              '나의 득근 리스트',
              style: TextStyle(color: Colors.black45),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black54.withOpacity(.30),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text('1단계(1 ~ 100kg)'),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            item(
                '플랑크톤',
                'https://i.pinimg.com/564x/2d/f8/2d/2df82d49f4bdc46baba3034c462852a7.jpg',
                '3대 50'),
            item(
                '멸치',
                'https://i.pinimg.com/564x/76/87/43/768743d399a97bd30b613286ae042bf5.jpg',
                '3대 100'),
            item(
                '고등어',
                'https://i.pinimg.com/564x/fe/e6/bd/fee6bd8f32f605c23b778f15b4099104.jpg',
                '3대 200'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            item(
                '알통몬',
                'https://static.wikia.nocookie.net/pokemon/images/3/3a/%EC%95%8C%ED%86%B5%EB%AA%AC_%EA%B3%B5%EC%8B%9D_%EC%9D%BC%EB%9F%AC%EC%8A%A4%ED%8A%B8.png/revision/latest?cb=20170405013322&path-prefix=ko',
                '3대 300'),
            item(
                '근육몬',
                'https://static.wikia.nocookie.net/pokemon/images/2/2f/%EA%B7%BC%EC%9C%A1%EB%AA%AC_%EA%B3%B5%EC%8B%9D_%EC%9D%BC%EB%9F%AC%EC%8A%A4%ED%8A%B8.png/revision/latest?cb=20170405013408&path-prefix=ko',
                '3대 400'),
            item(
                '괴력몬',
                'https://static.wikia.nocookie.net/pokemon/images/4/44/%EA%B4%B4%EB%A0%A5%EB%AA%AC_%EA%B3%B5%EC%8B%9D_%EC%9D%BC%EB%9F%AC%EC%8A%A4%ED%8A%B8.png/revision/latest?cb=20170405013449&path-prefix=ko',
                '3대 500'),
          ],
        ),
      ],
    ));
  }
}
