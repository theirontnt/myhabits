import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myhabits/Model/Habit.dart';
import 'package:myhabits/main.dart';

class HabitService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String?> create({HabitDays days = const HabitDays(), String? title}) async {
    if (auth.currentUser == null) return "";
    final CollectionReference ref = firestore.collection("users").doc(auth.currentUser!.uid).collection("habits");

    final Map<String, dynamic> json = new Habit(createdAt: new DateTime.now(), days: days, title: title).toJson();

    await ref.add({...json, "createdAt": FieldValue.serverTimestamp()});
  }

  static HabitService of(BuildContext context) => MyHabits.of(context).habitService;
}
