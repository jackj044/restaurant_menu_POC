// To parse this JSON data, do
//
//     final productParams = productParamsFromJson(jsonString);

import 'dart:convert';

//token=bc41a5099f2789747b2482c7dbd07957e1ed729c267247f2986cc373fc490d98&clientId=158650&aggId=112&udf1=WEB&lang=en&clienttype=GRAHAK&clientpan=BWPOX8310H&clientmobile=9988998898

InitGrahakSessionQueryParams initGrahakSessionQueryParamsFromJson(String str) => InitGrahakSessionQueryParams.fromJson(json.decode(str));

String initGrahakSessionQueryParamsToJson(InitGrahakSessionQueryParams data) => json.encode(data.toJson());

class InitGrahakSessionQueryParams {
  InitGrahakSessionQueryParams({
    this.clientId='',
    this.token='',
    this.aggId='',
    this.udf1='',
    this.lang='en',
    this.clienttype='',
    this.clientpan='',
    this.clientmobile='',
  });

  String clientId;
  String token;
  String aggId;
  String udf1;
  String lang;
  String clienttype;
  String clientpan;
  String clientmobile;

  factory InitGrahakSessionQueryParams.fromJson(Map<String, dynamic> json) => InitGrahakSessionQueryParams(
    clientId: json['clientId'] ?? '',
    token: json['token'] ?? '',
    aggId: json['aggId'] ?? '',
    udf1: json['udf1'] ?? '',
    lang: json['lang'] ?? '',
    clienttype: json['clienttype'] ?? '',
    clientpan: json['clientpan'] ?? '',
    clientmobile: json['clientmobile'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'clientId': clientId,
    'token': token,
    'aggId': aggId,
    'udf1': udf1,
    'lang': lang,
    'clienttype': clienttype,
    'clientpan': clientpan,
    'clientmobile': clientmobile,
  };
}
