import 'package:flutter/material.dart';
import 'package:forsythia/theme/color.dart';
import 'package:forsythia/theme/text.dart';
import 'package:forsythia/widgets/box_dacoration.dart';
import 'package:forsythia/widgets/large_app_bar.dart';

class ChallengePage extends StatefulWidget {
  const ChallengePage({super.key});

  @override
  State<ChallengePage> createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  int? CompleteRunIndex = null;
  int? CompleteTimeIndex = null;

  bool mission = false;

  List<String> run = [
    '4km',
    '16km',
    '64km',
    '256km',
    '1024km',
  ];

  List<String> time = [
    '1시간',
    '4시간',
    '16시간',
    '246시간',
    '1024시간',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LargeAppBar(
        title: "도전과제",
        sentence: "도전과제를 달성하고 \n많은 보상과 강아지를 레벨업",
      ),
      body: Column(
        children: [
          _togglebutton(),
          mission
              ? SingleChildScrollView()
              : SingleChildScrollView(
                  child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: Column(
                      children: [_complete(), _notcomplete()],
                    ),
                  ),
                )),
        ],
      ),
    );
  }

  Widget _togglebutton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                mission = false;
              });
            },
            child: Row(
              children: [
                Image(
                  image: AssetImage('assets/emoji/trophy.png'),
                  width: 25,
                  height: 25,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 10),
                Text20(
                  text: '업적',
                  bold: true,
                )
              ],
            ),
          ),
          Image(
            image: AssetImage('assets/emoji/bar.png'),
            width: 25,
            height: 25,
            fit: BoxFit.cover,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                mission = true;
              });
            },
            child: Row(
              children: [
                Image(
                  image: AssetImage('assets/emoji/v.png'),
                  width: 25,
                  height: 25,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 10),
                Text20(
                  text: '미션',
                  bold: true,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 달성한거
  Widget _complete() {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      decoration: myBorderBoxDecoration,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Flexible(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Image(
                        image: AssetImage('assets/emoji/running.png'),
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 10),
                      Text16(text: '4km 달리기', bold: true),
                    ],
                  ),
                  SizedBox(height: 10),
                  Stack(
                    children: [_bar(), _progressbar()],
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Flexible(flex: 4, child: _button()),
          ],
        ),
      ),
    );
  }

  // 달성 못한거
  Widget _notcomplete() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Container(
        width: MediaQuery.of(context).size.width - 60,
        decoration: myBorderBoxDecoration,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Flexible(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Image(
                          image: AssetImage('assets/emoji/running.png'),
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 10),
                        Text16(text: '4km 달리기', bold: true),
                      ],
                    ),
                    SizedBox(height: 10),
                    Stack(
                      children: [_bar(), _progressbar()],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Flexible(flex: 4, child: _button()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bar() {
    return Container(
      height: 6,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(3), color: myGrey),
    );
  }

  Widget _progressbar() {
    return Container(
      height: 6,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3), color: myLightGreen),
    );
  }

  Widget _button() {
    return ElevatedButton(
      onPressed: () {
        // 버튼을 클릭했을 때 실행되는 동작
      },
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: myMainGreen),
      child: Container(
        height: 60,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: const [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '400 ',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: myBlack),
                ),
                Image(
                  image: AssetImage('assets/emoji/money.png'),
                  width: 18,
                  height: 18,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 10),
                Text(
                  '4 ',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: myBlack),
                ),
                Image(
                  image: AssetImage('assets/emoji/heart.png'),
                  width: 18,
                  height: 18,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            SizedBox(height: 3),
            Text(
              '보상받기',
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold, color: myBlack),
            )
          ],
        ),
      ),
    );
  }
}
