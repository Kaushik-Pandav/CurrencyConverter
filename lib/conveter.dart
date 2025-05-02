import 'dart:convert';

import 'package:currencyconveter/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'basedata.dart';

class Conveter extends StatefulWidget {
  const Conveter({super.key});

  @override
  State<Conveter> createState() => _ConveterState();
}

class _ConveterState extends State<Conveter> {
  Currency? basedata;
  TextEditingController c = TextEditingController();

  @override
  void initState() {
    super.initState();
    callapi();
  }

  String BaseCurrency = "AFN";
  String targetCurrency = "INR";
  String value = "0";

  List Type = model().map.keys.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "Assets/dynamic-data-visualization-3d.jpg",
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.6),
          ),
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Currency Converter",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 40),
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.green.shade900,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: DropdownButton<String>(
                                  value: BaseCurrency,
                                  dropdownColor: Colors.blue,
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                  isExpanded: true,
                                  items: Type.map((currency) {
                                    return DropdownMenuItem<String>(
                                      value: currency,
                                      child: Text(currency),
                                    );
                                  }).toList(),
                                  onChanged: (String? e) {
                                    setState(() {
                                      BaseCurrency = e!;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white,
                                  ),
                                  child: TextField(
                                    controller: c,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Enter Value",
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: DropdownButton<String>(
                                  value: targetCurrency,
                                  dropdownColor: Colors.blue,
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                  isExpanded: true,
                                  items: Type.map((currency) {
                                    return DropdownMenuItem<String>(
                                      value: currency,
                                      child: Text(currency),
                                    );
                                  }).toList(),
                                  onChanged: (String? e) {
                                    setState(() {
                                      targetCurrency = e!;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white,
                                  ),
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.yellow,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                double n = double.parse(c.text.trim());
                                setState(() {
                                  double urorate = n / basedata!.rates[BaseCurrency];
                                  value = (urorate * basedata!.rates[targetCurrency]).toStringAsFixed(2);
                                });
                              },
                              child: Text(
                                "Convert",
                                style: TextStyle(fontSize: 20, color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.yellow,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  value="0";
                                  c.text="";
                                });
                              },
                              child: Text(
                                "Refresh",
                                style: TextStyle(fontSize: 20, color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> callapi() async {
    var url = Uri.parse("https://currency-conversion-and-exchange-rates.p.rapidapi.com/latest");
    var response = await http.get(
      url,
      headers: {
        'x-rapidapi-key': 'f75504b718msh5dc4082d1687c9ep1101e2jsn593de1fb7956',
        'x-rapidapi-host': 'currency-conversion-and-exchange-rates.p.rapidapi.com',
      },
    );
    var map = jsonDecode(response.body);
    basedata = Currency.fromJson(map);
  }
}
