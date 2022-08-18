import 'package:flight_info/flights.dart';
import 'package:flight_info/list_of_airports.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChooseLocations extends StatefulWidget {
  const ChooseLocations({Key? key}) : super(key: key);

  @override
  State<ChooseLocations> createState() => _ChooseLocationsState();
}

class _ChooseLocationsState extends State<ChooseLocations> {
  var location;
  var destination;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text('Choose Departure and Arrival'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 16, 40, 16),
              child: Container(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                decoration: BoxDecoration(
                  color: Colors.blue[800],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    menuMaxHeight: 240,
                    itemHeight: 48,
                    value: location,
                    isExpanded: true,
                    dropdownColor: Colors.blue[800],
                    hint: const Text(
                      'Choose your location',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    items: airportsList.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        location = value;
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 16, 40, 16),
              child: Container(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                decoration: BoxDecoration(
                  color: Colors.blue[800],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    menuMaxHeight: 240,
                    itemHeight: 48,
                    value: destination,
                    isExpanded: true,
                    dropdownColor: Colors.blue[800],
                    hint: const Text(
                      'Choose your destination',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    items: airportsList.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        destination = value;
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text(
                      'Location',
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      location == null ? '' : '$location',
                      style: const TextStyle(
                          fontSize: 25, color: Colors.lightBlue),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      'Destination',
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      destination == null ? '' : '$destination',
                      style: const TextStyle(
                          fontSize: 25, color: Colors.lightBlue),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {
                if (location == null || destination == null) {
                  setState(() {
                    Fluttertoast.showToast(
                        msg: "Choose a location and destination",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  });
                } else if (location == destination) {
                  setState(() {
                    Fluttertoast.showToast(
                        msg:
                            "The destination must be different from the location",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  });
                } else {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return Flights(
                        loc: airportsMap[location],
                        des: airportsMap[destination]);
                  }));
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue[800]),
              ),
              child: const Text(
                'Show Flights',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
