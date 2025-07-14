/// Clase Calculadora simple que contiene operaciones aritméticas básicas.
/// Esta clase se utilizará para demostrar los mutation tests.
class Calculator {
  /// Suma dos números y retorna el resultado.
  int add(int a, int b) {
    return a + b;
  }

  /// Resta dos números y retorna el resultado.
  int subtract(int a, int b) {
    return a - b;
  }

  /// Multiplica dos números y retorna el resultado.
  int multiply(int a, int b) {
    return a * b;
  }

  /// Divide dos números y retorna el resultado.
  /// Lanza una excepción si el divisor es cero.
  double divide(int a, int b) {
    if (b == 0) {
      throw ArgumentError('No se puede dividir por cero');
    }
    return a / b;
  }

  /// Verifica si un número es par.
  bool isEven(int number) {
    return number % 2 == 0;
  }

  /// Devuelve el mayor de dos números.
  int max(int a, int b) {
    if (a >= b) {
      return a;
    } else {
      return b;
    }
  }
}
