import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/forecast_card.dart';
import 'package:weather_app/subheading.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({Key? key}) : super(key: key);

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
            onPressed: () {},
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
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "27° C",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Icon(
                              Icons.cloud,
                              size: 50,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Small cards showing Forecast
                      ForecastCard(),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Small cards showing addtional information
                    Placeholder(
                      fallbackHeight: 95,
                      fallbackWidth: 95,
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
