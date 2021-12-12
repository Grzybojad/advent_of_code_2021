import 'input_reader.dart';
import 'graph.dart';

int part1() {
  var inputLines = readLines('input/day12_input.txt');
  var graph = Graph.linesToGraph(inputLines);

  List<List<String>> paths = [];
  pathsFind(graph, paths, ["start"]);

  return paths.length;
}

List<List<String>> pathsFind(
    Graph graph, List<List<String>> paths, List<String> path) {
  var currentNodeConnections = graph.nodes[path.last]!;
  for (var connection in currentNodeConnections) {
    if (connection == connection.toLowerCase() && path.contains(connection)) {
      continue;
    }

    var newPath = [...path];
    newPath.add(connection);
    if (newPath.last == "end") {
      paths.add(newPath);
      continue;
    }

    pathsFind(graph, paths, newPath);
  }

  return paths;
}
