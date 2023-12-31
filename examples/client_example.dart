//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// XYZ Informations
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:xyz_informations/xyz_informations.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

void main() async {
  final url = Uri(
    scheme: "http",
    host: "localhost",
    port: 8080,
    path: "/count_to_10",
  );
  final client = http.Client();
  try {
    final request = http.Request("GET", url);
    final response = await client.send(request);
    final stream = response.stream.transform(const Utf8Decoder()).transform(const LineSplitter());
    stream.listen(
      (data) {
        final count = sseMessagesToData(data).firstOrNull;
        stdout.write(count);
      },
      onDone: () {
        client.close();
      },
      onError: (e) {
        stdout.writeln(e);
        client.close();
      },
    );
  } catch (e) {
    stderr.writeln(e);
    client.close();
  }
}
