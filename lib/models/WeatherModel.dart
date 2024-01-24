class WeatherData {
  final String lat;
  final String lon;
  final int elevation;
  final String timezone;
  final String units;
  final CurrentWeather current;

  WeatherData({
    required this.lat,
    required this.lon,
    required this.elevation,
    required this.timezone,
    required this.units,
    required this.current,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      lat: json['lat'],
      lon: json['lon'],
      elevation: json['elevation'],
      timezone: json['timezone'],
      units: json['units'],
      current: CurrentWeather.fromJson(json['current']),
    );
  }
}

class CurrentWeather {
  final String icon;
  final int iconNum;
  final String summary;
  final double temperature;
  final Wind wind;
  final Precipitation precipitation;
  final cloudCover;

  CurrentWeather({
    required this.icon,
    required this.iconNum,
    required this.summary,
    required this.temperature,
    required this.wind,
    required this.precipitation,
    required this.cloudCover,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      icon: json['icon'],
      iconNum: json['icon_num'],
      summary: json['summary'],
      temperature: json['temperature'].toDouble(),
      wind: Wind.fromJson(json['wind']),
      precipitation: Precipitation.fromJson(json['precipitation']),
      cloudCover: json['cloud_cover'],
    );
  }
}

class Wind {
  final double speed;
  final int angle;
  final String dir;

  Wind({
    required this.speed,
    required this.angle,
    required this.dir,
  });

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json['speed'].toDouble(),
      angle: json['angle'],
      dir: json['dir'],
    );
  }
}

class Precipitation {
  final double total;
  final String type;

  Precipitation({
    required this.total,
    required this.type,
  });

  factory Precipitation.fromJson(Map<String, dynamic> json) {
    return Precipitation(
      total: json['total'].toDouble(),
      type: json['type'],
    );
  }
}