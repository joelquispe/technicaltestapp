import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:technical_test_app/features/matrix/ui/blocs/matrix/matrix_bloc.dart';
import 'package:technical_test_app/ui/layouts/main_layout.dart';
import 'package:technical_test_app/ui/widgets/custom_text_field_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _matrixInputController = TextEditingController(
    text: "[[1, 2], [3, 4]]",
  );

  @override
  void dispose() {
    _matrixInputController.dispose(); // Libera el controlador
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      titleAppBar: 'Rotar Matriz en sentido horario',
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomTextFieldWidget(
                      label: 'Matriz',
                      hintText: '[[1, 2], [3, 4]]',
                      keyboardType: TextInputType.number,
                      controller: _matrixInputController,
                      onSubmitted: (value) {
                        context.read<MatrixBloc>().add(UpdateMatrix(value));
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      context.read<MatrixBloc>().add(RotateMatrix());
                    },
                    child: const Text("Rotar"),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              BlocBuilder<MatrixBloc, MatrixState>(
                builder: (context, state) {
                  if (state is MatrixInitial || state is MatrixUpdated) {
                    final matrix = state is MatrixInitial
                        ? (state).matrix
                        : (state as MatrixUpdated).matrix;
                    return buildMatrixView(matrix);
                  } else if (state is MatrixError) {
                    return Text(state.message,
                        style: const TextStyle(color: Colors.red));
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMatrixView(List<List<int>> matrix) {
    int size = matrix.length;
    return Column(
        children: List.generate(size, (i) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(size, (j) {
          return Container(
            width: 50,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: Text(
              matrix[i][j].toString(),
              style: const TextStyle(fontSize: 18),
            ),
          );
        }),
      );
    }));
  }
}

