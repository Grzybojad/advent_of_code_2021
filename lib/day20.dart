import 'package:aoc2021/day05.dart';

import 'input_reader.dart';
import 'grid.dart';

int part1() {
  var input = readAsString('input/day20_input.txt');

  var splitInput = input.split("\r\n\r\n");
  var enhancementAlgorithm = splitInput[0];
  var image = splitInput[1];
  var imageGrid = Grid.hashToGrid(image.split("\r\n"));

  int steps = 2;
  int outsideValue = 0;
  for (int i = 0; i < steps; ++i) {
    imageGrid = enhanceImage(imageGrid, enhancementAlgorithm, outsideValue);
    if (outsideValue == 0 && enhancementAlgorithm[0] == "#") {
      outsideValue = 1;
    } else if (outsideValue == 1 && enhancementAlgorithm[511] == ".") {
      outsideValue = 0;
    }
  }

  return countLightPixels(imageGrid);
}

int countLightPixels(Grid imageGrid) {
  return imageGrid.count((p) => p == 1);
}

Grid enhanceImage(
    Grid imageGrid, String enhancementAlgorithm, int outsideValue) {
  int extraSpace = 4;
  Grid newImage = Grid.filledGrid(imageGrid.width() + extraSpace * 2,
      imageGrid.height() + extraSpace * 2, 0);

  for (int y = 0; y < newImage.height(); ++y) {
    for (int x = 0; x < newImage.width(); ++x) {
      var pixelVal = getWindowValue(
          imageGrid, Point(x - extraSpace, y - extraSpace), outsideValue);

      bool light = shouldPixelBeLight(enhancementAlgorithm, pixelVal);
      newImage.setValueAt(x, y, light ? 1 : 0);
    }
  }

  return newImage;
}

int getWindowValue(Grid image, Point pixelPos, int outsideValue) {
  var valueString = "";

  for (int y = pixelPos.y - 1; y <= pixelPos.y + 1; ++y) {
    for (int x = pixelPos.x - 1; x <= pixelPos.x + 1; ++x) {
      var val = image.isOutsideGrid(x, y)
          ? outsideValue.toString()
          : image.getValueAt(x, y).toString();
      valueString += val;
    }
  }

  return int.parse(valueString, radix: 2);
}

bool shouldPixelBeLight(String enhancementAlgorithm, int pixelValue) {
  return enhancementAlgorithm[pixelValue] == "#";
}

void printStats(Grid imageGrid) {
  print(
      "${imageGrid.width()}x${imageGrid.height()}: ${countLightPixels(imageGrid)}");
}
