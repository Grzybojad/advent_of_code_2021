import 'dart:io';
import 'dart:convert';
import 'dart:async';

Future<List<int>> readInts(String filename) async {
  final file = File(filename);
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.
  try {
    return lines.map((line) => int.parse(line)).toList();
  } catch (e) {
    print('Error: $e');
    rethrow;
  }
}
