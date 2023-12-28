import 'dart:ui';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app/additional_info_card.dart';
import 'package:weather_app/forecast_card.dart';
import 'package:weather_app/helpers.dart';
import 'package:weather_app/secrets.dart';
import 'package:weather_app/subheading.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  bool isLoading = false;
  // Do not use late keyword (late variables must be initialized before the build function is executed)
  double temp = 0;

  @override
  void initState() {
    getWeatherData();
    super.initState();
  }

  Future getWeatherData() async {
    try {
      const cityName = "delhi";
      var url = Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPI");
      // print(url);
      var response = await http.get(url);
      if (response.statusCode != 200) {
        throw "An Unexpected Error Occured";
      }
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } catch (err) {
      throw err.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather App",
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              // getWeatherData();
              var res = await getWeatherData();
              // res = res["list"][0]["main"]["temp"].toStringAsFixed(2);
              setState(() {
                isLoading = true;
                var t = res["list"][0]["main"]["temp"].toString();
                temp = double.parse(t) - 273.15;
                temp = roundDouble(temp, 2);
              });
            },
            icon: const Icon(
              Icons.refresh,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Center(
              child: Text(
                "Get the weather of Delhi NCR",
                style: TextStyle(
                  fontSize: 18,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            // Weather Display Card
            SizedBox(
              width: double.infinity,
              child: Card(
                  elevation: 15,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: Colors.blueGrey[800],
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      16,
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaY: 12,
                        sigmaX: 12,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "$temp° C",
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            const Icon(
                              Icons.cloud,
                              size: 50,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Rain",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),

            // Weather Forecast
            const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Subheading
                Subheading(title: "Weather Forecast"),
                SizedBox(
                  height: 10,
                ),
                // Scrollable Row containing Cards showing the weather forecast
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Small cards showing Forecast
                      ForecastCard(
                        time: "22:00",
                        temperature: "13° C",
                        icon: Icons.cloud,
                      ),
                      ForecastCard(
                        time: "22:00",
                        temperature: "13° C",
                        icon: Icons.cloud,
                      ),
                      ForecastCard(
                        time: "22:00",
                        temperature: "13° C",
                        icon: Icons.cloud,
                      ),
                      ForecastCard(
                        time: "22:00",
                        temperature: "13° C",
                        icon: Icons.cloud,
                      ),
                      ForecastCard(
                        time: "22:00",
                        temperature: "13° C",
                        icon: Icons.cloud,
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),

            // Additional Information
            const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Subheading
                Subheading(title: "Additional Information"),
                SizedBox(
                  height: 10,
                ),
                // Row containing Cards showing the Additional Info
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Small cards showing addtional information
                    AdditionalInfoCard(
                      infoValue: "94",
                      title: "Humidity",
                      icon: Icons.water_drop_rounded,
                    ),
                    AdditionalInfoCard(
                      infoValue: "7.67",
                      title: "Wind Speed",
                      icon: Icons.air,
                    ),
                    AdditionalInfoCard(
                      infoValue: "1006",
                      title: "Pressure",
                      icon: Icons.beach_access,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
