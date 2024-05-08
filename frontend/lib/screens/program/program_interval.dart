import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forsythia/models/programs/program_add.dart';
import 'package:forsythia/service/program_service.dart';
import 'package:forsythia/theme/color.dart';
import 'package:forsythia/theme/text.dart';
import 'package:forsythia/widgets/box_dacoration.dart';
import 'package:forsythia/widgets/small_app_bar.dart';

class AddIntervalProgramPage extends StatefulWidget {
  const AddIntervalProgramPage({super.key});

  @override
  State<AddIntervalProgramPage> createState() => _AddIntervalProgramPageState();
}

class _AddIntervalProgramPageState extends State<AddIntervalProgramPage> {
  final TextEditingController _programName = TextEditingController();
  String check = "";
  bool error = false;
  String _errorText = '';
  List<String> speedList = ["0"]; // 속도를 고르는 부분
  List<String> timeList = ["0"]; // 시간을 고르는 부분
  List<String> repeatList = ["1", "2", "3", "4", "5"]; // 반복횟수를 고르는 부분
  List<String> typeList = ["걷기", "달리기"]; // 반복횟수를 고르는 부분

  //루틴 추가할때마다 아래에 있는 5가지에 리스트 추가

  //각각의 속도 인덱스와 시간인덱스와 타입인덱스
  List<int> speedIndexList = [0];
  List<int> timeIndexList = [0];
  List<int> typeIndexList = [0];
  int repeatIndex = 0;

  // 각각의 속도값과 시간값 이부분을 리스트로 만들어야함.
  // List<TextEditingController> speedRoutinelist = [TextEditingController()];
  // List<TextEditingController> timeRoutinelist = [TextEditingController()];
  TextEditingController repeat = TextEditingController();

  @override
  void initState() {
    super.initState();
    initializeLists();
  }

  void initializeLists() {
    speedList.addAll([for (int i = 1; i <= 30; i += 1) i.toString()]);
    timeList.addAll([for (int i = 1; i <= 30; i += 1) i.toString()]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SmallAppBar(
        title: "프로그램 추가",
        back: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40), // 검색창과 텍스트 사이의 간격
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text25(
                    text: "인터벌목표",
                    bold: true,
                  ),
                  SizedBox(height: 36),
                  Text16(
                    text: '프로그램명',
                    bold: true,
                    textColor: myMainGreen,
                  ),
                  Row(
                    children: [
                      Expanded(
                        // Expanded 위젯을 추가하여 Row의 너비를 확장합니다.
                        child: TextField(
                          controller: _programName,
                          onChanged: (value) {
                            if (value.length < 2 && value.length <= 8) {
                              setState(() {
                                _errorText = '2자 이상 8자 이하';
                              });
                            } else {
                              setState(() {
                                _errorText = '';
                              });
                            }
                            setState(() {
                              check = ""; // 값이 변경될 때마다 check 변수를 초기화해줘
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 5),
                            hintText: '운동프로그램의 이름을 정해주세요.',
                            hintStyle: TextStyle(color: Colors.grey),
                            // tap 시 borderline 색상 지정
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: myBlack)),
                            errorText:
                                _errorText.isNotEmpty ? _errorText : null,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(
                                r'[a-zA-Z0-9_ㄱ-힣]')), // 영어 대소문자, 숫자, 언더바, 한글 허용 // 최대 10자까지 입력 허용
                          ],
                          maxLength: 8,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text16(
                text: "루틴",
                bold: true,
                textColor: myMainGreen,
              ),
              SizedBox(height: 20),
              timeIndexList.isEmpty ? Text("dd") : _routineList(),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text16(
                    text: "루틴 반복",
                    bold: true,
                    textColor: myMainGreen,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 100, child: _repeatPicker()),
                      Text16(text: '회')
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () async {
          if (_programName.text != "") {
            ProgramAdd program = ProgramAdd(
              interval: null,
              programTitle: _programName.text,
              programType: "D",
            );
            await ProgramService.fetchProgramAdd(program);
            Navigator.pop(context, "update");
            Navigator.pop(context, "update");
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            decoration: _programName.text != "" && !error
                ? myActiveBoxDecoration
                : myNoneBoxDecoration,
            padding: EdgeInsets.all(16),
            height: 55,
            child: Center(
              child: Text16(
                text: "추가",
                bold: true,
                textColor: _programName.text != "" && !error ? myBlack : myGrey,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _repeatPicker() {
    return CupertinoPageScaffold(
      child: SizedBox(
        height: 80,
        child: CupertinoPicker(
          itemExtent: 50.0,
          onSelectedItemChanged: (int index) {
            setState(() {
              repeatIndex = index;
              repeat.text = repeatList[repeatIndex];
            });
          },
          children: List<Widget>.generate(repeatList.length, (int index) {
            return Center(
                child: Text36(
              text: repeatList[index],
              bold: true,
            ));
          }),
        ),
      ),
    );
  }

  Widget _timePicker(i) {
    return CupertinoPageScaffold(
      backgroundColor: typeIndexList[i] == 0 ? myLightYellow : myWhiteGreen,
      child: SizedBox(
        height: 80,
        child: CupertinoPicker(
          itemExtent: 40.0,
          onSelectedItemChanged: (int index) {
            setState(() {
              timeIndexList[i] = index;
            });
          },
          children: List<Widget>.generate(timeList.length, (int index) {
            return Center(
                child: Text25(
              text: timeList[index],
              bold: true,
            ));
          }),
        ),
      ),
    );
  }

  Widget _speedPicker(i) {
    return CupertinoPageScaffold(
      backgroundColor: typeIndexList[i] == 0 ? myLightYellow : myWhiteGreen,
      child: SizedBox(
        height: 80,
        child: CupertinoPicker(
          itemExtent: 40.0,
          onSelectedItemChanged: (int index) {
            setState(() {
              speedIndexList[i] = index;
            });
          },
          children: List<Widget>.generate(speedList.length, (int index) {
            return Center(
                child: Text25(
              text: speedList[index],
              bold: true,
            ));
          }),
        ),
      ),
    );
  }

  Widget _routineList() {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: timeIndexList.length + 1,
        itemBuilder: (BuildContext context, int index) {
          return index != speedIndexList.length
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      typeIndexList[index] = (typeIndexList[index] + 1) % 2;
                    });
                  },
                  child: Container(
                      decoration: typeIndexList[index] == 0
                          ? myWalkBoxDecoration
                          : myRunBoxDecoration,
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text12(
                                text: typeIndexList[index] == 0
                                    ? "걷기루틴"
                                    : "달리기루틴",
                                bold: true,
                                textColor: typeIndexList[index] == 0
                                    ? myYellow
                                    : myMainGreen,
                              ),
                              Row(
                                children: [
                                  Text12(
                                    text: "클릭하여 타입변경",
                                    textColor: myGrey,
                                  ),
                                  speedIndexList.length != 1
                                      ? GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              speedIndexList.removeAt(index);
                                              timeIndexList.removeAt(index);
                                              typeIndexList.removeAt(index);
                                            });
                                            for (int i = 0;
                                                i < typeIndexList.length;
                                                i++) {
                                              print(speedIndexList[i]);
                                            }
                                          },
                                          child: Row(
                                            children: [
                                              SizedBox(width: 10),
                                              Image.asset(
                                                "assets/icons/common_trash.png",
                                                color: myRed,
                                                width: 20,
                                                height: 20,
                                                fit: BoxFit.cover,
                                                filterQuality:
                                                    FilterQuality.none,
                                              ),
                                            ],
                                          ),
                                        )
                                      : SizedBox(width: 0)
                                ],
                              )
                            ],
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: 60, child: _speedPicker(index)),
                                Text12(text: "km/h의 속도로"),
                                SizedBox(width: 60, child: _timePicker(index)),
                                Text12(text: "분"),
                                SizedBox(width: 10),
                                SizedBox(
                                  width: 50,
                                  child: Text16(
                                    text: typeIndexList[index] == 0
                                        ? "걷기"
                                        : "달리기",
                                    bold: true,
                                    textColor: typeIndexList[index] == 0
                                        ? myYellow
                                        : myMainGreen,
                                  ),
                                ),
                              ]),
                        ],
                      )),
                )
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      speedIndexList.add(0);
                      timeIndexList.add(0);
                      typeIndexList.add(0);
                    });
                  },
                  child: Container(
                    decoration: myActiveBoxDecoration,
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 16),
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Text16(
                        text: "루틴추가",
                        bold: true,
                      ),
                    ),
                  ),
                );
        });
  }
}
