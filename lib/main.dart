import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:myhabits/Logic/AuthService.dart';
import 'package:myhabits/Logic/HabitService.dart';
import 'package:myhabits/Logic/LanguageService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyHabits());
}

class MyHabits extends StatefulWidget {
  final AuthService authService = new AuthService();
  final HabitService habitService = new HabitService();

  MyHabits({Key? key}) : super(key: key);

  @override
  _MyHabitsState createState() => _MyHabitsState();

  static _MyHabitsState of(BuildContext context) => context.findAncestorStateOfType<_MyHabitsState>()!;
}

class _MyHabitsState extends State<MyHabits> {
  AuthService get authService => widget.authService;
  HabitService get habitService => widget.habitService;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        Language.delegate,
      ],
    );
  }
}
