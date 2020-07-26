import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'dart:async';
import 'package:flutterapp/pages/input_page_step2.dart';
import 'package:flutterapp/pages/daily_page.dart';

class InputPageStep1 extends StatefulWidget {
  InputPageStep1({Key key, this.handlerPageView}) : super(key: key);
  Function handlerPageView;
  @override
  _InputPageStep1State createState() => _InputPageStep1State();
}

class _InputPageStep1State extends State<InputPageStep1> {
  int hour, min, score;
  String mid, curDate;
  Timer _timer;
  @protected
  @mustCallSuper
  void initState() {
    super.initState();
    setState(() {
      var now = new DateTime.now();
      hour = now.hour > 12 ? now.hour - 12 : now.hour;
      min = now.minute;
      mid = now.hour >= 12 ? "오후" : "오전";
      curDate = "${mid} ${hour}시 ${min}분 ";
      score = 50;
    });
  }

  showTimePicker(BuildContext context) {
    print("showTimePicker");
    List<String> midArr = ["오전", "오후"];
    List<int> timeArr = [for (var i = 0; i <= 12; i += 1) i];
    List<int> minArr = [for (var i = 0; i < 60; i += 1) i];
    var timePicker = [midArr, timeArr, minArr];

    new Picker(
        adapter:
            PickerDataAdapter<String>(pickerdata: timePicker, isArray: true),
        changeToFirst: true,
        hideHeader: false,
        onConfirm: (Picker picker, List value) {
          setState(() {
            mid = value[0] == 0 ? "오전" : "오후";
            hour = value[1];
            min = value[2];
            curDate = "${mid} ${hour}시 ${min}분 ";
            score = null;
          });
        }).showModal(context);
  }

  renderTimeSelect() {
    String title = "당신의 기분을 알려주세요.";
    return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(curDate == null ? '' : curDate,
                  style: TextStyle(
                      fontSize: 21,
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal)),
              Container(
                padding: const EdgeInsets.all(0.0),
                height: 30,
                width: 30,
                child: IconButton(
                  icon: Image.asset(
                    'lib/src/image/daily/icon_arrow.png',
                    height: 60,
                    width: 60,
                  ),
                  tooltip: 'change date',
                  onPressed: () {
                    showTimePicker(context);
                  },
                ),
              ),
            ],
          ),
          Text(title,
              style: TextStyle(
                  fontSize: 21,
                  color: const Color(0xffffffff),
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal))
        ]));
  }

  renderScoreSelect() {
    List<int> scoreList = [for (var i = 0; i <= 100; i += 10) i];

    return Padding(
        padding: const EdgeInsets.only(top: 25),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('lib/src/image/daily/img_bubble.png'),
              fit: BoxFit.cover,
            )),
            child: Container(
              child: Center(
                child: Container(
                    height: 170,
                    child: new ListWheelScrollView.useDelegate(
                      itemExtent: 60,
                      diameterRatio: 1.5,
                      physics: FixedExtentScrollPhysics(),
                      onSelectedItemChanged: (i) {
                        print('${scoreList[i]}___changed value');
                        setState(() {
                          score = scoreList[i];
                        });
                      },
                      childDelegate: ListWheelChildLoopingListDelegate(
                        children: [
                          for (var i in scoreList)
                            Text(
                              i.toString(),
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: Color(0xffffffff),
                                fontSize: 28,
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.normal,
                                letterSpacing: 0.28,
                              ),
                            )
                        ],
                      ),
                    )),
              ),
            ),
          )
        ]));
  }

  renderNextStep() {
    return Expanded(
      child: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 70),
            height: 35,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/src/image/daily/img_shadow.png'),
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(bottom: 20),
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: IconButton(
                icon: Image.asset(
                  'lib/src/image/daily/noti_dive_deeper.png',
                ),
                tooltip: 'next step',
                onPressed: () {
                  widget.handlerPageView(1);
                },
              )),
        ],
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Container(
      decoration: new BoxDecoration(
        color: Color.fromRGBO(43, 99, 194, 1.0),
      ),
      child: Column(
        children: <Widget>[
          renderTimeSelect(),
          renderScoreSelect(),
          renderNextStep()
        ],
      ),
    ));
  }
}
