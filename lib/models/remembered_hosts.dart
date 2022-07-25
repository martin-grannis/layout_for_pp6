import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:pp6_layout/models/host.dart';
//import 'package:flutter/material.dart';

class Remembered_Hosts extends Equatable {
  final Host h;

  const Remembered_Hosts(this.h);

  static List<Host> Remembered_HostsFromJson(String str) => List<Host>.from(
      json.decode(str).map((x) => Remembered_Hosts.fromJson(x)));

  //named constructor
  factory Remembered_Hosts.fromJson(Map<String, dynamic> json) =>
      Remembered_Hosts(Host.fromJson(json));

  Map<String, dynamic> toJson() {
    return {
      "name": this.h.name,
      "ip_address": this.h.ip_address,
      "port": this.h.port,
      "password": this.h.password,
      "known": this.h.known,
      "favourite": this.h.favourite,
    };
  }

  @override
  List<Object> get props => [this.h];

  static const empty = Host.empty;
}
