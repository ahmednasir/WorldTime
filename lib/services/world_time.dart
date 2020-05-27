import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String location; //location name for UI
  String time; //time in that location
  String flag; //url to asset flag icon
  String url; //location url for api end points
  bool isDayTime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
//    make the request
    try {
      Response response =
          await get("http://worldtimeapi.org/api/timezone/$url");
      Map data = jsonDecode(response.body);
//  get properties from data
      String dateTime = data['datetime'];
      String offset = data['utc_offset'];
      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(
          hours: int.parse(offset.substring(1, 3)),
          minutes: int.parse(offset.substring(4, 6))));

      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {

      time = "Couldnot get time data";
    }
  }
}
