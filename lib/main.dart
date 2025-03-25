import 'package:flutter/material.dart';
import 'package:weather_api/data_service.dart';
import 'package:weather_api/model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _cityTextContoller = TextEditingController();
  final _dataService = DataService();

  WeatherResponse? _response; // Make _response nullable

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_response != null) // Check if response is not null
                Column(
                  children: [
                    Image.network(_response!.iconUrl),
                    Text('${_response!.tempInfo.temperature}°'),
                    // Use null-aware operator
                    Text(
                      _response!.weatherInfo.description,
                      // Use null-aware operator
                      style: TextStyle(fontSize: 40),
                    ),
                  ],
                )
              else
                Text('No data available'),

              // Show a fallback message when no data is available
              Padding(
                padding: EdgeInsets.symmetric(vertical: 50),
                child: SizedBox(
                  width: 150,
                  child: TextField(
                    controller: _cityTextContoller,
                    decoration: InputDecoration(labelText: 'City'),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              ElevatedButton(onPressed: _search, child: Text('Search')),
            ],
          ),
        ),
      ),
    );
  }

  void _search() async {
    final response = await _dataService.getWeather(_cityTextContoller.text);
    setState(
      () => _response = response,
    ); // Update _response when search is triggered
  }
}
