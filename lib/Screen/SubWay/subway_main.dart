import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:privateapp/Screen/Default_layout/default_layout.dart';

import '../../data/data.dart';

class SubwayMain extends StatefulWidget {
  const SubwayMain({super.key});

  @override
  State<SubwayMain> createState() => _SubwayMainState();
}

class _SubwayMainState extends State<SubwayMain> {
  @override
  Widget build(BuildContext context) {
    final String station = "화곡";

    final List<String> arrivals = [
      "5168 - 방화행",
      "5646 - 목동행",
      "5167 - 우장산행",
      "5693 - 송정행",
    ];

    final List<Map<String,dynamic>> arrivalInformation = [];

    return DefaultLayout(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
                itemCount: arrivals.length,
                itemBuilder: (BuildContext context, int index) {
                  return Center(
                    child: Container(
                      child: Text(arrivals[index]),
                    ),
                  );
                },
              ),
            )
          ],
        )
    );
  }

  Future<void> getArrivalData(String station) async {
    final dio = Dio();

    try{
      final resp = await dio.get("http://swopenAPI.seoul.go.kr/api/subway/${APIKEY}/json/realtimeStationArrival/0/4/${station}");
      if(resp.statusCode == 200){
        print(resp.data);
      }else{
        print("Error - SubWay-Main - getArrivalData - ${resp.statusCode}");
      }
    }catch(e){
        print("Catch-Error - SubWay-Main - getArrivalData - ${e}");
    }
  }

}
