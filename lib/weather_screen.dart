import 'dart:ui';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app/additional_info_card.dart';
import 'package:weather_app/forecast_card.dart';
import 'package:weather_app/helpers.dart';
import 'package:weather_app/secrets.dart';
import 'package:weather_app/subheading.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<Map<String, dynamic>> getWeatherData() async {
    try {
      const cityName = "delhi";
      var url = Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPI");
      // print(url);
      var response = await http.get(url);
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse["cod"] != "200") {
        throw "An Unexpected Error Occured";
      }
      return jsonResponse;
    } catch (e) {
      throw e.toString();
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
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(
              Icons.refresh,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
          future: getWeatherData(),
          builder: (context, snapshot) {
            // print(snapshot);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            }

            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }

            final data = snapshot
                .data!; // enforce that the data can never be null (since we have handled the errors above)
            final currWeatherData = data['list'][0];
            final currTemp = currWeatherData['main']['temp'];
            final currSky = currWeatherData['weather'][0]['main'];
            final pressure = currWeatherData['main']['pressure'];
            final humidity = currWeatherData['main']['humidity'];
            final windSpeed = currWeatherData['wind']['speed'];

            return Padding(
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
                        // color: Colors.blueGrey[800],
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "$currTemp K",
                                    style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Icon(
                                    (currSky == "Rain")
                                        ? Icons.cloudy_snowing
                                        : Icons.sunny,
                                    size: 50,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    currSky,
                                    style: const TextStyle(
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Subheading
                      const Subheading(title: "Hourly Weather Forecast"),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 130,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            final forecast = data['list'][index + 1];
                            final sky =
                                data['list'][index + 1]['weather'][0]['main'];

                            final hourlyTemp =
                                forecast['main']['temp'].toString();

                            final time =
                                DateTime.parse(forecast['dt_txt'].toString());
                            return ForecastCard(
                                time: DateFormat.j().format(time),
                                temperature: hourlyTemp,
                                icon: (sky == "Rain")
                                    ? Icons.cloudy_snowing
                                    : Icons.sunny);
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // Additional Information
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Subheading
                      const Subheading(title: "Additional Information"),
                      const SizedBox(
                        height: 10,
                      ),
                      // Row containing Cards showing the Additional Info
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Small cards showing addtional information
                          AdditionalInfoCard(
                            infoValue: humidity.toString(),
                            title: "Humidity",
                            icon: Icons.water_drop_rounded,
                          ),
                          AdditionalInfoCard(
                            infoValue: windSpeed.toString(),
                            title: "Wind Speed",
                            icon: Icons.air,
                          ),
                          AdditionalInfoCard(
                            infoValue: pressure.toString(),
                            title: "Pressure",
                            icon: Icons.beach_access,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
