import 'package:automation/bloc/zones_bloc.dart';
import 'package:flutter/material.dart';
import 'package:automation/screens/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Automation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<ZonesBloc>(
            create: (context) => ZonesBloc(),
          ),
        ],
        child: BlocBuilder<ZonesBloc, ZonesState>(
          builder: (context, state) {
            if (state is StartGetKeypad)
              return Center(child: CircularProgressIndicator());

            if (state is ErrorGetKeypad)
              return HomeScreen(errorMessage: state.message);

            if (state is SuccessGetKeypad)
              return HomeScreen(keypad: state.keypad);

            return HomeScreen();
          },
        ),
      ),
    );
  }
}
