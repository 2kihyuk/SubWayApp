import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:privateapp/RiverPod/Model/all_subway_station.dart';
import 'package:privateapp/Screen/Default_layout/default_layout.dart';
import 'package:privateapp/Screen/SubWay/Model/subway_model.dart';

import '../../data/data.dart';

class SubwayMain extends ConsumerStatefulWidget {
  const SubwayMain({super.key});

  @override
  ConsumerState<SubwayMain> createState() => _SubwayMainState();
}

class _SubwayMainState extends ConsumerState<SubwayMain> {
  List<RealTimeArrival> arrivalInformation = [];
  bool isListOpen = true;

  String selectedStation = "";
  TextEditingController textFormController = TextEditingController();

  String searchQuery = '';
  List<Map<String, String>> filteredStations = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final subway = ref.watch(subwayStationsProvider);
    String station = '화곡';

    return DefaultLayout(
        title: '지하철 정보 받기',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: textFormController,
              decoration: InputDecoration(border: OutlineInputBorder()),
              keyboardType: TextInputType.text,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                  if (subway.hasValue) {
                    filteredStations = _filter(searchQuery, subway.value ?? []);
                  }
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: subway.when(
                data: (stations) {
                  filteredStations = _filter(searchQuery, stations);
                  return ListView.builder(
                    itemCount: filteredStations.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedStation =
                            filteredStations[index]['STATION_NM']!;
                          });
                          print('${selectedStation}');
                        },
                        child: ListTile(
                          title: Text(filteredStations[index]['STATION_NM']!),
                          subtitle: Text(filteredStations[index]['LINE_NUM']!),
                        ),
                      );
                    },
                  );
                },
                error: (error, stackTrace) =>
                    Center(child: Text("Error: $error")),
                loading: () => Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            Divider(),
            Center(child: Text('${selectedStation}역을 선택하셨습니다.')),
            OutlinedButton(
              onPressed: () {
                setState(() {
                  arrivalInformation = [];
                });

                getArrivalData(station);
              },
              child: Text('지하철 정보 받기'),
            ),
            Divider(),
              Expanded(
                flex: 2,
                child: ListView.builder(
                  itemCount: arrivalInformation.isEmpty ? 1 : arrivalInformation.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (arrivalInformation.isEmpty) {
                      return Center(
                        child: Text('운행 가능한 열차가 없습니다.'),
                      );
                    }
                    var minute =
                        (int.tryParse(arrivalInformation[index].barvlDt)! / 60)
                            .toInt();
                    var line = '5호선';
                    switch (arrivalInformation[index].subwayId) {
                      case '1005':
                        line = '5호선';
                        break;
                      case '1001':
                        line = '1호선';
                        break;
                      case '1002':
                        line = '2호선';
                        break;
                      case '1003':
                        line = '3호선';
                        break;
                      case '1004':
                        line = '4호선';
                        break;
                      case '1006':
                        line = '6호선';
                        break;
                      case '1007':
                        line = '7호선';
                        break;
                      case '1008':
                        line = '8호선';
                        break;
                      case '1009':
                        line = '9호선';
                        break;
                      case '1032':
                        line = 'GTX-A';
                        break;
                      case '1063':
                        line = '경의중앙선';
                        break;
                      case '1066':
                        line = '공항철도';
                        break;
                      case '1067':
                        line = '경춘선';
                        break;
                      case '1075':
                        line = '수인분당선';
                        break;
                      case '1077':
                        line = '신분당선';
                        break;
                      case '1081':
                        line = '경강선';
                        break;
                      case '1092':
                        line = '우이신설선';
                        break;
                      case '1093':
                        line = '서해선';
                        break;
                      case '1094':
                        line = '신림선';
                        break;
                    }
                    return GestureDetector(
                      onTap: () {
                        print(
                            '${arrivalInformation[index].arvlMsg2} - ${arrivalInformation[index].arvlMsg3}');
                      },
                      child: ListTile(
                        title: Text(
                            '${line} - ${arrivalInformation[index].btrainNo} - ${arrivalInformation[index].updnLine}'),
                        subtitle: Text(
                            '${arrivalInformation[index].trainLineNm} - ${arrivalInformation[index].bstatnNm}'),
                        trailing: Text('도착 예정 시간: ${minute}분'),
                      ),
                    );
                  },
                ),
              )
          ],
        ));
  }

  List<Map<String, String>> _filter(
      String query, List<Map<String, String>> stations) {
    if (query.isEmpty) {
      return stations;
    }
    return stations.where((station) {
      return station['STATION_NM']!.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  Future<void> getArrivalData(String station) async {
    final dio = Dio();
    try {
      final resp = await dio.get(
          "http://swopenAPI.seoul.go.kr/api/subway/${APIKEY}/json/realtimeStationArrival/0/4/${selectedStation}");
      if (resp.statusCode == 200) {
        print('Resp.data : ${resp.data}');
        setState(() {
          ApiResponse apiResponse = ApiResponse.fromJson(resp.data);
          arrivalInformation = apiResponse.realTimeArrival;
        });

      }
      else {
        print("Error - SubWay-Main - getArrivalData - ${resp.statusCode}");
      }
    } catch (e) {
      print("Catch-Error - SubWay-Main - getArrivalData - ${e}");
    }
  }
}


