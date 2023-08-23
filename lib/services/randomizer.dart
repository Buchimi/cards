import 'dart:math';

class Randomizer<T> {
  randomizeList(List<T> list) {
    for (int i = 0; i < list.length; i++) {
      int index = Random().nextInt(list.length);
      T temp = list[index];
      list[index] = list[i];
      list[i] = temp;
    }
  }
}
