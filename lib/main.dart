import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_test_app/features/matrix/ui/blocs/matrix/matrix_bloc.dart';
import 'package:technical_test_app/features/matrix/screens/matrix_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MatrixBloc()),
      ],
      child: const MaterialApp(
        title: 'Technical Test App',
        home: HomeScreen(),
      ),
    );
  }
}
