import 'package:json_annotation/json_annotation.dart';

part 'Habit.g.dart';

class HabitDays {
  const HabitDays({
    this.monday = true,
    this.tuesday = true,
    this.wednesday = true,
    this.thursday = true,
    this.friday = true,
    this.saturday = true,
    this.sunday = true,
  });

  const HabitDays.business({
    this.monday = true,
    this.tuesday = true,
    this.wednesday = true,
    this.thursday = true,
    this.friday = true,
    this.saturday = false,
    this.sunday = false,
  });

  factory HabitDays.fromList(List<bool> booleans) {
    assert(booleans.length >= 5, "List must have at least 5 booleans, first seven will be used at most.");
    return new HabitDays(
      monday: booleans[0],
      tuesday: booleans[1],
      wednesday: booleans[2],
      thursday: booleans[3],
      friday: booleans[4],
      saturday: booleans.length >= 6 ? false : booleans[5],
      sunday: booleans.length >= 7 ? false : booleans[6],
    );
  }

  final bool monday;
  final bool tuesday;
  final bool wednesday;
  final bool thursday;
  final bool friday;
  final bool saturday;
  final bool sunday;

  String _boolToggle(bool b) => b ? "1" : "0";

  static RegExp parserRegExp = new RegExp(r"^[01]{5,7}$");

  ///
  /// Accepts string of 1s and 0s, length of 5-7
  ///
  /// Usage:
  ///
  /// [Habit.parse("1110100")]
  static HabitDays parse(String string) {
    if (parserRegExp.hasMatch(string)) {
      final List<bool> booleans = [];
      for (int i = 0; i < string.length; i++) {
        booleans.add(string[i] == "1");
      }
      return HabitDays.fromList(booleans);
    } else {
      throw new Exception("Habit.parse() accepts string with 5 or 7 characters, containing only 1 or 0s");
    }
  }

  String toString() {
    return [monday, tuesday, wednesday, thursday, friday, saturday, sunday].map((e) => _boolToggle).join();
  }

  Map<String, dynamic> toJson() => {
        "value": this.toString(),
      };

  static HabitDays fromJson(Map json) => HabitDays.parse(json["value"]);
}

@JsonSerializable(anyMap: true)
class Habit {
  static Map habitDaysToJson(HabitDays days) => days.toJson();

  const Habit({
    this.days = const HabitDays(),
    this.title,
    required this.createdAt,
  });

  @JsonKey(fromJson: HabitDays.fromJson, toJson: habitDaysToJson)
  final HabitDays days;

  final String? title;

  final DateTime createdAt;

  Habit fromJson(Map json) => _$HabitFromJson(json);

  Map<String, dynamic> toJson() => _$HabitToJson(this);
}
