import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:travel/widgets/Travel.dart';
import 'package:travel/widgets/cJourney.dart';

class journeyStorage {
  bool isError = false;
  String errorMsg = '';
  String apiURL = "https://travelappease.000webhostapp.com/travel.php";
  String auth_string = "Shazib";

  void reset() {
    errorMsg = '';
    isError = false;
  }

  Future<bool> saveData(Journey bd) async {
    try {
      Map<String, dynamic> prams = bd.toJson();
      prams.addAll({"auth_string": auth_string});
      var response = await http.post(Uri.parse(apiURL), body: prams);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data["type"] == "success") {
        } else {
          isError = true;
          errorMsg = "API Error : " + data["data"];
          print(errorMsg);
        }
      } else {
        isError = true;
        errorMsg = "Server Error : " + response.reasonPhrase!;
        print(errorMsg);
      }
    } catch (error) {
      isError = true;
      errorMsg = error.toString();
    }
    return !isError;
  }

  Future<List<Journey>> readData() async {
    List<Journey> flist = [];

    try {
      print("REST: connecting to server");
      var response =
          await http.get(Uri.parse(apiURL + "?auth_string=" + auth_string));
      print("REST: got the server");
      if (response.statusCode == 200) {
        print("REST: response is 200");
        var data = jsonDecode(response.body);
        if (data["type"] == "success") {
          print("REST: Execuation Success");
          for (int i = 0; i < data["data"].length; i++) {
            flist.add(Journey.fromJson(data["data"][i]));
            print("REST: ${jsonEncode(data["data"][i])}");
          }
        } else {
          print("REST: API execuation error" + data["data"]);
          isError = true;
          errorMsg = data["data"];
        }
      } else {
        print("REST:internal server error" + response.reasonPhrase!);
        isError = true;
        errorMsg = "Server error " + response.reasonPhrase!;
      }
    } catch (error) {
      print("Fetch error " + error.toString());
    }
    return flist;
  }
}
