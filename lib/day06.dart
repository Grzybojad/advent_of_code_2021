import 'input_reader.dart';

int part1() {
  var input = readAsString('input/day06_input.txt');
  var numbers = input.split(',');
  var states = numbers.map((s) => int.parse(s)).toList();

  simulateDays(states,80);

  return states.length;
}

void simulateDays(List<int> states, int days) {
  for(int i=0; i<days; ++i) {
    simulateDay(states);
  }
}

void simulateDay(List<int> states) {
  int statesAtStartOfDay = states.length;
  for(int i=0; i<statesAtStartOfDay; ++i) {
    if(states[i]==0) {
      states[i]=6;
      states.add(8);
    } else {
      states[i]--;
    }
  }
}
