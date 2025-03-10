import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:privateapp/data/data.dart';

final subwayStationsProvider = FutureProvider<List<Map<String, String>>>((ref) async {
  final dio = Dio();
  final response = await dio.get("http://openapi.seoul.go.kr:8088/$APIKEY2/json/SearchSTNBySubwayLineInfo/1/800");

  if (response.statusCode == 200) {
    List<Map<String, String>> stations = [];
    final subwayApiResponse = SubwayApiResponse.fromJson(response.data);

    for (var row in subwayApiResponse.searchSTNBySubwayLineInfo.listrow) {
      stations.add({
        'LINE_NUM': row.LINE_NUM,
        'STATION_NM': row.STATION_NM,
      });
    }

    return stations;
  } else {
    throw Exception("Failed to load subway stations");
  }
});


class SubwayApiResponse {
  SearchSTNBySubwayLineInfo searchSTNBySubwayLineInfo;

  SubwayApiResponse({
    required this.searchSTNBySubwayLineInfo
  });

  factory SubwayApiResponse.fromJson(Map<String, dynamic> json){
    return SubwayApiResponse(
        searchSTNBySubwayLineInfo: SearchSTNBySubwayLineInfo.fromJson(
            json['SearchSTNBySubwayLineInfo']));
  }


}


class SearchSTNBySubwayLineInfo {

  final int list_total_count;
  final RESULT result;
  final List<Row> listrow;

  SearchSTNBySubwayLineInfo({
    required this.list_total_count,
    required this.result,
    required this.listrow,
  });

  factory SearchSTNBySubwayLineInfo.fromJson(Map<String, dynamic> json) {
    return SearchSTNBySubwayLineInfo(
      list_total_count: json['list_total_count'],
      result: RESULT.fromJson(json['RESULT']),
      listrow: (json['row'] as List)
          .map((rowJson) => Row.fromJson(rowJson))
          .toList(),
    );
  }

}

class RESULT {
  final String CODE;
  final String MESSAGE;

  RESULT({
    required this.CODE,
    required this.MESSAGE,
  });

  factory RESULT.fromJson(Map<String, dynamic> json){
    return RESULT(
        CODE: json['CODE'],
        MESSAGE: json['MESSAGE']
    );
  }
}

class Row {
  final String STATION_NM;
  final String LINE_NUM;

  Row({
    required this.STATION_NM,
    required this.LINE_NUM,
  });

  factory Row.fromJson(Map<String, dynamic> json){
    return Row(STATION_NM: json['STATION_NM'], LINE_NUM: json['LINE_NUM']);
  }
}

// List<String> Line1 = [];
// List<String> Line2 = [];
// List<String> Line3 = [];
// List<String> Line4 = [];
// List<String> Line5 = [];
// List<String> Line6 = [];
// List<String> Line7 = [];
// List<String> Line8 = [];
// List<String> Line9 = [];
// List<String> LineGTX = [];
// List<String> LineGyeongUeCenter = [];
// List<String> LineAirport = [];
// List<String> LineGyeongChoon = [];
// List<String> LineSuInBundang = [];
// List<String> LineSinBundang = [];
// List<String> LineGyeongGang = [];
// List<String> LineUEoSinSeol = [];
// List<String> LineSeoHae = [];
// List<String> LineSinLim = [];
// List<String> LineInCheon = [];
// List<String> LineInChon2 = [];
// List<String> LineEujeongBuGyeong = [];
// List<String> LineYongInGyeong = [];


//
// class AllSubWayStation {
//
//   final subwayStationProvider = FutureProvider<List<Map<String,dynamic>>>((ref)async{
//     final allSubwayStation = AllSubWayStation();
//     await allSubwayStation.getStationData();
//     return allSubwayStation.stationList;
//   });
//
//
//   List<Map<String,dynamic>> stationList = [];
//
//   Future<void> getStationData() async {
//     final dio = Dio();
//
//     try {
//       final resp = await dio.get("http://openapi.seoul.go.kr:8088/$APIKEY2/json/SearchSTNBySubwayLineInfo/1/800");
//
//       if(resp.statusCode==200){
//         print('all_subway_station - AllSubWayStation - getStationData() - Success');
//         final subwayApiResponse = SubwayApiResponse.fromJson(resp.data);
//         for(var row in subwayApiResponse.searchSTNBySubwayLineInfo.listrow){
//           stationList.add({
//             'LINE_NUM': row.LINE_NUM,
//             'STATION_NM': row.STATION_NM,
//           });
//           ///전체 지하철정보를 담을 배열인 stationList에 MAP형태로 호선-역이름 저장.
//         }
//         print('${stationList}');
//       }else{
//         print('all_subway_station - AllSubWayStation - getStationData() - catch-Error - ${resp.statusCode} / ${resp.statusMessage}');
//       }
//     } catch (e) {
//       print('all_subway_station - AllSubWayStation - getStationData() -${e}');
//     }
//
//   }
//
// }