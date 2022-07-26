//import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:pp6_layout/services/mdns.dart';

//import 'package:user_repository/src/mdns.dart';
//import 'package:user_repository/src/models/remembered_hosts.dart';

class Host extends Equatable {
  final String name;
  final String ip_address;
  final String port;
  final bool known;
  final String password;
  final bool favourite;

  const Host(this.name, this.ip_address, this.port, this.known, this.password,
      this.favourite);

  factory Host.fromJson(Map<String, dynamic> json) {
    return Host(json['name'], json['ipAddress'], json['port'], json['known'],
        json['password'], json['favourite']);
  }

  Map<String, dynamic> toJson() => {
        'name': this.name,
        'ipAddress': this.ip_address,
        'port': this.port,
        'known': this.known,
        'password': this.password,
        'favourite': this.favourite,
      };

  static Future<List<Host>> find_available_hosts(List<Host> lrh) async {
    List<Host> hosts = await getMDNS(lrh);

    return hosts;
  }
  //

  @override
  List<Object> get props =>
      [name, ip_address, this.port, this.known, this.password];

  static const empty = Host('', '', '', false, '', false);
  static const sampler = Host(
      'DESKTOP-0LJ2HL8', '192.168.1.10', '49442', false, 'sunshine', false);

  Host copyWith({
    String? name,
    String? ip_address,
    String? port,
    bool? known,
    String? password,
    bool? favourite,
  }) {
    return Host(
      name ?? this.name,
      ip_address ?? this.ip_address,
      port ?? this.port,
      known ?? this.known,
      password ?? this.password,
      favourite ?? this.favourite,
    );
  }
}
