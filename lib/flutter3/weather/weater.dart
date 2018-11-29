import 'package:json_annotation/json_annotation.dart';
part 'weater.g.dart';

///
/// 命令行下运行，当类修改后回自动生成json转换代码：
/// flutter packages pub run build_runner watch
/// 
@JsonSerializable()
class BaseResponse extends Object {
  final String message;
  final int count;
  final String cod;
  @JsonKey(name: 'list')
  final List<City> cities;

  BaseResponse({this.message, this.count, this.cod, this.cities});

  factory BaseResponse.fromJson(Map<String, dynamic> e) => _$BaseResponseFromJson(e);
  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}

@JsonSerializable()
class City extends Object {
  final String name;
  final int id;
  final Coord coord;
  final Main main;
  final int dt;
  final Wind wind;
  final Sys sys;
  final Rain rain;
  final Snow snow;
  final Clouds clouds;
  final List<Weather> weather;

  City(
      {this.name,
      this.id,
      this.coord,
      this.main,
      this.dt,
      this.wind,
      this.sys,
      this.rain,
      this.snow,
      this.clouds,
      this.weather});

  factory City.fromJson(Map<String, dynamic> e) => _$CityFromJson(e);
  Map<String, dynamic> toJson() => _$CityToJson(this);
}

@JsonSerializable()
class Snow extends Object {
  Snow();
  factory Snow.fromJson(Map<String, dynamic> e) => _$SnowFromJson(e);
  Map<String, dynamic> toJson() => _$SnowToJson(this);
}

@JsonSerializable()
class Rain extends Object {
  final double threeHour;

  Rain({this.threeHour});
  factory Rain.fromJson(Map<String, dynamic> e) => _$RainFromJson(e);
  Map<String, dynamic> toJson() => _$RainToJson(this);
}

@JsonSerializable()
class Coord extends Object {
  final double lat;
  final double lon;

  Coord({this.lat, this.lon});

  factory Coord.fromJson(Map<String, dynamic> e) => _$CoordFromJson(e);
  Map<String, dynamic> toJson() => _$CoordToJson(this);
}

@JsonSerializable()
class Clouds extends Object {
  final int all;

  Clouds({this.all});

  factory Clouds.fromJson(Map<String, dynamic> e) => _$CloudsFromJson(e);
  Map<String, dynamic> toJson() => _$CloudsToJson(this);
}

@JsonSerializable()
class Main extends Object {
  final double temp;
  final double pressure;
  final int humidity;
  final double tempMin;
  final double tempMax;

  Main({this.temp, this.pressure, this.humidity, this.tempMin, this.tempMax});

  factory Main.fromJson(Map<String, dynamic> e) => _$MainFromJson(e);
  Map<String, dynamic> toJson() => _$MainToJson(this);
}

@JsonSerializable()
class Wind extends Object {
  final double speed;
  final double deg;
  @JsonKey(nullable: true)
  final double gust;

  Wind({this.speed, this.deg, this.gust});

  factory Wind.fromJson(Map<String, dynamic> e) => _$WindFromJson(e);
  Map<String, dynamic> toJson() => _$WindToJson(this);
}

@JsonSerializable()
class Weather extends Object {
  final int id;
  final String main;
  final String description;
  final String icon;

  Weather({this.id, this.main, this.description, this.icon});

  factory Weather.fromJson(Map<String, dynamic> e) => _$WeatherFromJson(e);
  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}

@JsonSerializable()
class Sys extends Object {
  final String country;

  Sys({this.country});

  factory Sys.fromJson(Map<String, dynamic> e) => _$SysFromJson(e);
  Map<String, dynamic> toJson() => _$SysToJson(this);
}
