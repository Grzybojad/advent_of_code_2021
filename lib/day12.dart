import 'input_reader.dart';
import 'graph.dart';

int part1() {
  var inputLines = readLines('input/day12_input.txt');
  var graph = Graph.linesToGraph(inputLines);

  List<List<String>> paths = [];
  pathsFind(graph, paths, ["start"]);

  return paths.length;
}

int part2() {
  var inputLines = readLines('input/day12_input.txt');
  var graph = Graph.linesToGraph(inputLines);

  List<List<String>> paths = [];
  pathsFind2(graph, paths, ["start"], false);

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

List<List<String>> pathsFind2(
    Graph graph, List<List<String>> paths, List<String> path, bool usedTwice) {
  var currentNodeConnections = graph.nodes[path.last]!;
  for (var connection in currentNodeConnections) {
    if (connection == "start") continue;

    var newPath = [...path];
    newPath.add(connection);

    if (newPath.last == "end") {
      paths.add(newPath);
      continue;
    }

    if (connection == connection.toLowerCase() && path.contains(connection)) {
      if (usedTwice) {
        continue;
      } else {
        pathsFind2(graph, paths, newPath, true);
      }
    } else {
      pathsFind2(graph, paths, newPath, usedTwice);
    }
  }

  return paths;
}
