import 'package:flutter/widgets.dart';

class AvatarColorFactory {
  const AvatarColorFactory();

  static const _availableColors = <Color>[
    Color.fromARGB(255, 230, 214, 117),
    Color.fromARGB(255, 251, 139, 64),
    Color.fromARGB(255, 88, 29, 163),
    Color.fromARGB(255, 25, 180, 169),
    Color.fromARGB(255, 143, 126, 243),
    Color.fromARGB(255, 228, 25, 84),
    Color.fromARGB(255, 44, 52, 148),
    Color.fromARGB(255, 4, 148, 68),
    Color.fromARGB(255, 4, 84, 172),
    Color.fromARGB(255, 225, 137, 172),
  ];

  static Color fromString(String value) {
    final hashCode = value.hashCode;
    return _availableColors[hashCode % 10];
  }
}
