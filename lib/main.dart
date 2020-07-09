import 'package:automation/bloc/app_bloc.dart';
import 'package:automation/screens/home/home_screen.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: MaterialApp(
          title: 'Automation',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: HomeScreen()),
      blocs: [
        Bloc((i) => AppBloc()),
      ],
    );
  }
}
