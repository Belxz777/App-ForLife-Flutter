import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:whatdo/models/WeatherModel.dart';

class WeatherWidget extends StatefulWidget {
  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
   WeatherData? weatherData;
   String? town = 'Izhevsk';
   List<String> cities = [
    "Izhevsk",
  "Dubai",
  "Saint-Petersburg",
  "London",
  "Washington",
  // Другие города...
];

  @override
  void initState() {
    super.initState();
 fetchData();
  }

  void onTownChanged(String? newTown) {
  setState(() {
    town = newTown; // Обновляем значение переменной town
    fetchData(); // Вызываем функцию fetchData при изменении значения town
  });
}
Future<void> fetchData() async {
  final response = await http.get(Uri.parse(
      'https://www.meteosource.com/api/v1/free/point?place_id=${town}&sections=current&timezone=UTC&language=en&units=metric&key=pzhut1ja7i8yb3j6917sl4mo039z34fgppunanb9'));
  if (response.statusCode == 200) {
    if (mounted) {
      setState(() {
        weatherData =
            WeatherData.fromJson(json.decode(response.body) as Map<String, dynamic>);
      });
    }
  } else {
    throw Exception('Failed to load data');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Погода на сегодня'),
      ),
      body: Center(
        child: weatherData != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  DropdownButton<String>(
  value: town,
  items: cities.map((String city) {
    return DropdownMenuItem<String>(
      value: city,
      child: Text(city),
    );
  }).toList(),
  onChanged: onTownChanged,
),
                  weatherData!.current.cloudCover > 50
              ? Image.network(
                  "https://masyamba.ru/%D0%BE%D0%B1%D0%BB%D0%B0%D0%BA%D0%B0-%D0%BA%D0%B0%D1%80%D1%82%D0%B8%D0%BD%D0%BA%D0%B8/95-%D1%81%D0%BA%D0%B0%D1%87%D0%B0%D1%82%D1%8C-%D0%BA%D0%B0%D1%80%D1%82%D0%B8%D0%BD%D0%BA%D0%B8-%D0%BE%D0%B1%D0%BB%D0%B0%D0%BA%D0%B0.jpg",
                  height: 100, // Укажите нужные размеры
                  width: 100,
                )
              : Image.network(
                  "https://gas-kvas.com/grafic/uploads/posts/2023-09/1695825570_gas-kvas-com-p-kartinki-solntse-18.jpg",
                  height: 100, // Укажите нужные размеры
                  width: 100,
                ),
                  Text('Широта: ${weatherData?.lat}'),
                  Text('Долгота: ${weatherData?.lon}'),
                  Text('Elevation: ${weatherData?.elevation}'),
                  Text('Временная зона ${weatherData?.timezone}'),
                  Text('Температура: ${weatherData?.current.temperature}°C'),            
                  Text('Скорость ветра: ${weatherData?.current.wind.speed} m/s'),
                  Text('Облачность: ${weatherData?.current.cloudCover}%'),
                  Text('Твой город ${town}')
                ],
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}