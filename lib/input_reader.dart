import 'dart:io';
import 'dart:convert';
import 'dart:async';

List<int> readInts(String filename) {
  return File(filename)
      .readAsLinesSync()
      .map((line) => int.parse(line))
      .toList();
}

List<String> readLines(String filename) {
  return File(filename).readAsLinesSync().toList();
}
