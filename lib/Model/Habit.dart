import 'package:json_annotation/json_annotation.dart';

part 'Habit.g.dart';

@JsonSerializable(anyMap: true)
class Habit {
  const Habit();

  /// weekdays in english, list seperated by comma if more than one.
  final String days;
}
