import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:privateapp/Screen/Default_layout/default_layout.dart';
import 'package:privateapp/Screen/SubWay/Model/subway_model.dart';

import '../../data/data.dart';

class SubwayMain extends StatefulWidget {
  const SubwayMain({super.key});

  @override
  State<SubwayMain> createState() => _SubwayMainState();
}

class _SubwayMainState extends State<SubwayMain> {
  List<RealTimeArrival> arrivalInformation = [];

  String selectedsubWay = '1';
  bool isListOpen = false;
  String selectedStation = '';
  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String station = "화곡";

    return DefaultLayout(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // DropdownButton(
        //   value: selectedsubWay,
        //   items: subWay
        //       .map((items) => DropdownMenuItem<String>(
        //             child: Text(items),
        //             value: items,
        //           ))
        //       .toList(),
        //   onChanged: (dynamic value) {
        //     setState(() {
        //       selectedsubWay = value;
        //       isListOpen = true;
        //     });
        //   },
        // ),
        // if (isListOpen)
        //   DropdownButton(
        //     value: selectedStation,
        //     items: items,
        //     onChanged: (dynamic value){
        //       selectedStation = value;
        //     },
        //   ),
        TextFormField(
          controller: editingController,
          decoration: InputDecoration(border: OutlineInputBorder()),

        ),
        OutlinedButton(
          onPressed: () {
            getArrivalData(station);
          },
          child: Text('지하철 정보 받기'),
        ),
        Divider(),
        Expanded(
          flex: 2,
          child: ListView.builder(
            itemCount: arrivalInformation.length,
            itemBuilder: (BuildContext context, int index) {
              var minute =
                  (int.tryParse(arrivalInformation[index].barvlDt)! / 60)
                      .toInt();

              return ListTile(
                title: Text(
                    '${arrivalInformation[index].subwayId == '1005' ? '5호선' : arrivalInformation[index].subwayId} - ${arrivalInformation[index].btrainNo}'),
                subtitle: Text(
                    '${arrivalInformation[index].trainLineNm} - ${arrivalInformation[index].bstatnNm}'),
                trailing: Text('도착 예정 시간: ${minute}분'),
              );
            },
          ),
        )
      ],
    ));
  }

  Future<void> getArrivalData(String station) async {
    final dio = Dio();


    print('${editingController.text}');
    try {
      final resp = await dio.get(
          "http://swopenAPI.seoul.go.kr/api/subway/${APIKEY}/json/realtimeStationArrival/0/4/${station}");
      if (resp.statusCode == 200) {
        print('Resp.data : ${resp.data}');

        ApiResponse apiResponse = ApiResponse.fromJson(resp.data);

        setState(() {
          arrivalInformation = apiResponse.realTimeArrival;
        });

        print('ArrivalInformation : ${arrivalInformation}');
      } else {
        print("Error - SubWay-Main - getArrivalData - ${resp.statusCode}");
      }
    } catch (e) {
      print("Catch-Error - SubWay-Main - getArrivalData - ${e}");
    }
  }
}
