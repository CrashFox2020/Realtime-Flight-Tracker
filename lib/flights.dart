import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Flights extends StatefulWidget {
  final String loc;
  final String des;

  const Flights({Key? key, required this.loc, required this.des})
      : super(key: key);

  @override
  State<Flights> createState() => _FlightsState(this.loc, this.des);
}

class _FlightsState extends State<Flights> {
  String? loc;
  String? des;
  Map? data;
  _FlightsState(this.loc, this.des);

  Future<List<FlightInfo>> _getFlights() async {
    var url = Uri.parse(
        'http://api.aviationstack.com/v1/flights?access_key=f209a0d517a3f3105fc090679a948690&dep_iata=$loc&arr_iata=$des');
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    List<FlightInfo> flightsInfo = [];
    if (data["pagination"]["count"] == 0) {
      FlightInfo flightInfo = FlightInfo("", "", "");
      flightsInfo.add(flightInfo);
      return flightsInfo;
    } else {
      for (var u in data["data"]) {
        FlightInfo flightInfo = FlightInfo(u["departure"]["estimated"],
            u["arrival"]["estimated"], u["airline"]["name"]);
        flightsInfo.add(flightInfo);
      }
      return flightsInfo;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text('List of flights from $loc to $des'),
        centerTitle: true,
      ),
      body: Container(
        child: FutureBuilder(
            future: _getFlights(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/logo.png'),
                      radius: 120,
                    ),
                    Text(
                      "Loading...",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ));
              } else if (snapshot.data[0].airline == "") {
                return const Center(
                    child: Text(
                  "Error: No flights are available",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                  ),
                ));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, index) {
                    return ListTile(
                      leading: Text(
                        "${index + 1}",
                        style: const TextStyle(color: Colors.black),
                      ),
                      title: Text(
                        "Airline: ${snapshot.data[index].airline}\nDeparture: ${snapshot.data[index].departure}\nArrival: ${snapshot.data[index].arrival}",
                        style: const TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    );
                  },
                );
              }
            }),
      ),
    );
  }
}

class FlightInfo {
  String departure;
  String arrival;
  String airline;
  FlightInfo(this.departure, this.arrival, this.airline);
}
