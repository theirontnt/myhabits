// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Habit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Habit _$HabitFromJson(Map json) {
  return Habit(
    days: HabitDays.fromJson(json['days'] as Map),
    title: json['title'] as String?,
    createdAt: DateTime.parse(json['createdAt'] as String),
  );
}

Map<String, dynamic> _$HabitToJson(Habit instance) => <String, dynamic>{
      'days': Habit.habitDaysToJson(instance.days),
      'title': instance.title,
      'createdAt': instance.createdAt.toIso8601String(),
    };
