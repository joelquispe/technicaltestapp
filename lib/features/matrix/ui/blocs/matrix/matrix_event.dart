part of 'matrix_bloc.dart';

@immutable
sealed class MatrixEvent {}

final class UpdateMatrix extends MatrixEvent {
  final String input;
  UpdateMatrix(this.input);
}

final class RotateMatrix extends MatrixEvent {}
