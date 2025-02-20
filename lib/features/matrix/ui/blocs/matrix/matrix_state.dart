part of 'matrix_bloc.dart';

@immutable
sealed class MatrixState {}

final class MatrixInitial extends MatrixState {
  final List<List<int>> matrix;
  MatrixInitial([this.matrix = const [[1, 2], [3, 4]]]);
}

final class MatrixUpdated extends MatrixState {
  final List<List<int>> matrix;
  MatrixUpdated(this.matrix);
}

final class MatrixError extends MatrixState {
  final String message;
  MatrixError(this.message);
}
