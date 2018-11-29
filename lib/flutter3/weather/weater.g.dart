// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weater.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) {
  return BaseResponse(
      message: json['message'] as String,
      count: json['count'] as int,
      cod: json['cod'] as String,
      cities: (json['list'] as List)
          ?.map((e) =>
              e == null ? null : City.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'count': instance.count,
      'cod': instance.cod,
      'list': instance.cities
    };

City _$CityFromJson(Map<String, dynamic> json) {
  return City(
      name: json['name'] as String,
      id: json['id'] as int,
      coord: json['coord'] == null
          ? null
          : Coord.fromJson(json['coord'] as Map<String, dynamic>),
      main: json['main'] == null
          ? null
          : Main.fromJson(json['main'] as Map<String, dynamic>),
      dt: json['dt'] as int,
      wind: json['wind'] == null
          ? null
          : Wind.fromJson(json['wind'] as Map<String, dynamic>),
      sys: json['sys'] == null
          ? null
          : Sys.fromJson(json['sys'] as Map<String, dynamic>),
      rain: json['rain'] == null
          ? null
          : Rain.fromJson(json['rain'] as Map<String, dynamic>),
      snow: json['snow'] == null
          ? null
          : Snow.fromJson(json['snow'] as Map<String, dynamic>),
      clouds: json['clouds'] == null
          ? null
          : Clouds.fromJson(json['clouds'] as Map<String, dynamic>),
      weather: (json['weather'] as List)
          ?.map((e) =>
              e == null ? null : Weather.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'coord': instance.coord,
      'main': instance.main,
      'dt': instance.dt,
      'wind': instance.wind,
      'sys': instance.sys,
      'rain': instance.rain,
      'snow': instance.snow,
      'clouds': instance.clouds,
      'weather': instance.weather
    };

Snow _$SnowFromJson(Map<String, dynamic> json) {
  return Snow();
}

Map<String, dynamic> _$SnowToJson(Snow instance) => <String, dynamic>{};

Rain _$RainFromJson(Map<String, dynamic> json) {
  return Rain();
}

Map<String, dynamic> _$RainToJson(Rain instance) => <String, dynamic>{};

Coord _$CoordFromJson(Map<String, dynamic> json) {
  return Coord(
      lat: (json['lat'] as num)?.toDouble(),
      lon: (json['lon'] as num)?.toDouble());
}

Map<String, dynamic> _$CoordToJson(Coord instance) =>
    <String, dynamic>{'lat': instance.lat, 'lon': instance.lon};

Clouds _$CloudsFromJson(Map<String, dynamic> json) {
  return Clouds(all: json['all'] as int);
}

Map<String, dynamic> _$CloudsToJson(Clouds instance) =>
    <String, dynamic>{'all': instance.all};

Main _$MainFromJson(Map<String, dynamic> json) {
  return Main(
      temp: (json['temp'] as num)?.toDouble(),
      pressure: (json['pressure'] as num)?.toDouble(),
      humidity: json['humidity'] as int,
      tempMin: (json['tempMin'] as num)?.toDouble(),
      tempMax: (json['tempMax'] as num)?.toDouble());
}

Map<String, dynamic> _$MainToJson(Main instance) => <String, dynamic>{
      'temp': instance.temp,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
      'tempMin': instance.tempMin,
      'tempMax': instance.tempMax
    };

Wind _$WindFromJson(Map<String, dynamic> json) {
  return Wind(
      speed: (json['speed'] as num)?.toDouble(),
      deg: (json['deg'] as num)?.toDouble(),
      gust: (json['gust'] as num)?.toDouble());
}

Map<String, dynamic> _$WindToJson(Wind instance) => <String, dynamic>{
      'speed': instance.speed,
      'deg': instance.deg,
      'gust': instance.gust
    };

Weather _$WeatherFromJson(Map<String, dynamic> json) {
  return Weather(
      id: json['id'] as int,
      main: json['main'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String);
}

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'id': instance.id,
      'main': instance.main,
      'description': instance.description,
      'icon': instance.icon
    };

Sys _$SysFromJson(Map<String, dynamic> json) {
  return Sys(country: json['country'] as String);
}

Map<String, dynamic> _$SysToJson(Sys instance) =>
    <String, dynamic>{'country': instance.country};
