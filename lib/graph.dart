import 'dart:collection';

class Graph {
  Map<String, HashSet<String>> nodes = {};

  Graph.linesToGraph(List<String> lines) {
    nodes = {};

    for (var line in lines) {
      var splitLine = line.split('-');
      var leftNodeName = splitLine[0];
      var rightNodeName = splitLine[1];

      if (!nodes.containsKey(leftNodeName)) {
        nodes[leftNodeName] = HashSet<String>();
      }
      nodes[leftNodeName]!.add(rightNodeName);

      if (!nodes.containsKey(rightNodeName)) {
        nodes[rightNodeName] = HashSet<String>();
      }
      nodes[rightNodeName]!.add(leftNodeName);
    }
  }

  void printGraph() {
    for (var key in nodes.keys) {
      print("$key: ${nodes[key]!.join(", ")}");
    }
  }
}
