import 'dart:convert';

class MatrixUtils {
  static List<List<int>> decodeMatrix(String input) {
    final parsed = jsonDecode(input) as List;
    final newMatrix = parsed.map((row) {
      if (row is! List) {
        throw FormatException("Cada fila debe ser una lista");
      }
      return row.map((item) {
        if (item is! int) {
          throw FormatException("Los elementos de la matriz deben ser enteros");
        }
        return item;
      }).toList();
    }).toList();
    return newMatrix;
  }

  static bool isValidSquareMatrix(List<List<int>> matrix) {
    final n = matrix.length;
    for (final row in matrix) {
      if (row.length != n) {
        return false;
      }
    }
    return true;
  }

  static List<List<int>> rotate(List<List<int>> mat) {
    int n = mat.length;
    List<List<int>> rotated = List.generate(n, (_) => List.filled(n, 0));
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        rotated[j][n - 1 - i] = mat[i][j];
      }
    }
    return rotated;
  }

}