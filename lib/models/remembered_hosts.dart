
import 'dart:convert';

import 'package:equatable/equatable.dart';
//import 'package:flutter/material.dart';

class Remembered_Hosts extends Equatable {
  final String name;
  final String ip_address;
  final String port;
  final String password;
const Remembered_Hosts(this.name, this.ip_address, this.port, this.password);


 static List<Remembered_Hosts> Remembered_HostsFromJson(String str) =>
      List<Remembered_Hosts>.from(
          json.decode(str).map((x) => Remembered_Hosts.fromJson(x)));


  // named constructor
  factory Remembered_Hosts.fromJson(Map<String, dynamic> json) =>
      Remembered_Hosts(
          json["name"], json['ip_addressage'], json['port'], json['password']);

  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "ip_address": this.ip_address,
      "port": this.port,
      "password": this.password,
    };
  }


  @override
  List<Object> get props => [this.name, this.ip_address, this.port, this.password];

  static const empty = Remembered_Hosts('', '', '', '');

}