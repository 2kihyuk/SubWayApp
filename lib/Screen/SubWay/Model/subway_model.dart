class ApiResponse {
  final ErrorMessage errorMessage;
  final List<RealTimeArrival> realTimeArrival;

  ApiResponse({
    required this.errorMessage,
    required this.realTimeArrival,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    var list = json['realtimeArrivalList'] as List;
    List<RealTimeArrival> arrivalList =
        list.map((i) => RealTimeArrival.fromJson(i)).toList();

    return ApiResponse(
      errorMessage: ErrorMessage.fromJson(json['errorMessage']),
      realTimeArrival: arrivalList,
    );
  }
}

class ErrorMessage {
  final int status;
  final String code;
  final String message;
  final String link;
  final String developerMessage;
  final int total;

  ErrorMessage({
    required this.status,
    required this.code,
    required this.message,
    required this.link,
    required this.developerMessage,
    required this.total,
  });

  factory ErrorMessage.fromJson(Map<String, dynamic> json) {
    return ErrorMessage(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      link: json['link'] ?? '',
      developerMessage: json['developerMessage']?? '',
      total: json['total'],
    );
  }
}

class RealTimeArrival {
  final String subwayId; // - String 지하철호선ID
  final String updnLine; //- String (상행,하행) 상하행선구분
  final String trainLineNm; //- String(목적지역 - 다음역)(방화행 - 우장산방면)
  final String statnFid; // - String  이전지하철역ID
  final String statnTid; //- String 다음지하철역 ID
  final String statnId; //- String 지하철역 ID
  final String statnNm; //- String 지하철역이름
  final String ordkey; //- String 01000방화0 도착예정열차순번 (상하행코드(1자리),순번(첫번째,두번째열차,1자리), 첫번째 도착예정 정류장 - 현재정류장(3자리),목자리 정류장,급행여부(1자리)))
  final String barvlDt; //- String 열차도착예정시간(단위:초)
  final String btrainNo; //- String열차번호 (현재 운행하고있는 호선별 열차번호)
  final String bstatnId; //- String 종착지하철역ID
  final String bstatnNm; //- String 종학지하철역명
  final String arvlMsg2; //- String 첫번째도착메시지(도착,출발,진입등) - 화곡 전역출발
  final String arvlMsg3; //- String 두번째 도착메시지(화곡)
  final String arvlCd; //- String 도착코드 (0:진입 , 1:도착 , 2:출발 , 3:전역출발 , 4:전역진입, 5: 전역도착, 99:운행중)
  final String lstcarAt; //- String 막차여부 (1:막차, 0:아님)

  RealTimeArrival({
      required this.subwayId,
      required this.updnLine,
      required this.trainLineNm,
      required this.statnFid,
      required this.statnTid,
      required this.statnId,
      required this.statnNm,
      required this.ordkey,
      required this.barvlDt,
      required this.btrainNo,
      required this.bstatnId,
      required this.bstatnNm,
      required this.arvlMsg2,
      required this.arvlMsg3,
      required this.arvlCd,
      required this.lstcarAt
  });

  factory RealTimeArrival.fromJson(Map<String, dynamic> json) {
    return RealTimeArrival(
      subwayId: json['subwayId'],
      updnLine: json['updnLine'],
      trainLineNm: json['trainLineNm'],
      statnFid: json['statnFid'],
      statnTid: json['statnTid'],
      statnId: json['statnId'],
      statnNm: json['statnNm'],
      ordkey: json['ordkey'],
      barvlDt: json['barvlDt'],
      btrainNo: json['btrainNo'],
      bstatnId: json['bstatnId'],
      bstatnNm: json['bstatnNm'],
      arvlMsg2: json['arvlMsg2'],
      arvlMsg3: json['arvlMsg3'],
      arvlCd: json['arvlCd'],
      lstcarAt: json['lstcarAt'],
    );
  }
}
