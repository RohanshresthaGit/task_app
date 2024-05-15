import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();
  String str = "";
  Map<String, dynamic>? value;
  @override
  void initState() {
    getWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Weather"),
          elevation: 6,
          centerTitle: true,
        ),
        body: (value != null)
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            str = value.toString();
                          });
                        },
                        controller: controller,
                        decoration: InputDecoration(
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  onPressed: () {
                                    setState(() {
                                      getWeatherWithCityName(str);
                                    });
                                  },
                                  child: Text(str.isEmpty ? "Save" : "Update")),
                            ),
                            hintText: "Search",
                            prefixIcon: const Icon(Icons.search),
                            hintStyle: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    SizedBox(
                        width: 150,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 40,
                                color: Colors.red,
                              ),
                              Text(
                                value!['location']['name'].toString(),
                                style: const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              Image.network(
                                value!['current']['condition']['icon'],
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                              ListTile(
                                leading: const Icon(Icons.thermostat),
                                title: Text("${value!['current']['temp_c']}°C"),
                              ),
                              ListTile(
                                  leading: const Icon(Icons.cloud),
                                  title: Text(
                                    value!['current']['condition']['text']
                                        .toString(),
                                  ))
                            ]))
                  ],
                ),
              )
            : const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text("Getting data Please Wait...")
                  ],
                ),
              ));
  }

  Future getWeather() async {
    final response = await http.get(Uri.parse(
        "http://api.weatherapi.com/v1/current.json?key=1bc0383d81444b58b1432929200711&q=48.8567,2.350"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      setState(() {
        value = data;
      });
    } else {
      print("Something Went Wrong");
    }
  }

  Future getWeatherWithCityName(String strin) async {
    final response = await http.get(Uri.parse(
        "http://api.weatherapi.com/v1/current.json?key=1bc0383d81444b58b1432929200711&q=$strin"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      setState(() {
        value = data;
      });
    } else {
      print("Something Went Wrong");
    }
  }
}
