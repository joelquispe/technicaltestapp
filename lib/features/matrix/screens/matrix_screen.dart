import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:technical_test_app/features/matrix/ui/blocs/matrix/matrix_bloc.dart';
import 'package:technical_test_app/ui/layouts/main_layout.dart';
import 'package:technical_test_app/ui/widgets/custom_text_field_widget.dart';

class MatrixScreen extends StatefulWidget {
  const MatrixScreen({super.key});

  @override
  State<MatrixScreen> createState() => MatrixScreenState();
}

class MatrixScreenState extends State<MatrixScreen> {
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
              _buildMatrixInputRow(context),
              const SizedBox(height: 20),
              _buildMatrixView(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMatrixInputRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: CustomTextFieldWidget(
            label: 'Matriz',
            hintText: '[[1, 2], [3, 4]]',
            keyboardType: TextInputType.text,
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
    );
  }

  Widget _buildMatrixView(BuildContext context) {
    return BlocBuilder<MatrixBloc, MatrixState>(
      builder: (context, state) {
        if (state is MatrixInitial || state is MatrixUpdated) {
          final matrix = state is MatrixInitial
              ? (state).matrix
              : (state as MatrixUpdated).matrix;
          return buildMatrixViewDisplay(matrix);
        } else if (state is MatrixError) {
          return Text(state.message, style: const TextStyle(color: Colors.red));
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Widget buildMatrixViewDisplay(List<List<int>> matrix) {
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
