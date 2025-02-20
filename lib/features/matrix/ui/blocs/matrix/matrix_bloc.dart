import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:meta/meta.dart';

import 'package:technical_test_app/features/utils/matrix_utils.dart';

part 'matrix_event.dart';
part 'matrix_state.dart';

class MatrixBloc extends Bloc<MatrixEvent, MatrixState> {
  MatrixBloc() : super(MatrixInitial()) {
    on<UpdateMatrix>(_onUpdateMatrix);
    on<RotateMatrix>(_onRotateMatrix);
  }

  void _onUpdateMatrix(UpdateMatrix event, Emitter<MatrixState> emit) {
    if (event.input.isEmpty) {
      emit(MatrixError("La entrada no puede estar vacía"));
      return;
    }

    try {
      final newMatrix = MatrixUtils.decodeMatrix(event.input);
      if (!MatrixUtils.isValidSquareMatrix(newMatrix)) {
        emit(MatrixError("La matriz debe ser cuadrada (NxN)"));
        return;
      }

      emit(MatrixUpdated(newMatrix));
    } on FormatException catch (e) {
      emit(MatrixError("Formato de matriz inválido: ${e.message}"));
    } catch (e) {
      emit(MatrixError("Error : $e"));
    }
  }

  void _onRotateMatrix(RotateMatrix event, Emitter<MatrixState> emit) {
    final currentMatrix = _getCurrentMatrix();
    if (currentMatrix == null) {
      emit(MatrixError("No hay una matriz válida para rotar"));
      return;
    }

    List<List<int>> rotatedMatrix = MatrixUtils.rotate(currentMatrix);
    emit(MatrixUpdated(rotatedMatrix));
  }

  List<List<int>>? _getCurrentMatrix() {
    switch (state) {
      case MatrixInitial(:final matrix):
        return matrix;
      case MatrixUpdated(:final matrix):
        return matrix;
      default:
        return null;
    }
  }
}
