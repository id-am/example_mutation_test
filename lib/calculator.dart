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
  ///
  /// ---
  /// MUTATION TESTING:
  /// Un mutante sobrevivió en la siguiente línea:
  /// if (a >= b) {  // El operador '>=' fue mutado a '>'
  /// y los tests no detectaron el cambio.
  /// ¿Por qué sobrevivió?
  ///   Porque los tests actuales consideran el caso donde ambos números son
  ///   iguales (a == b), pero el resultado esperado es válido para ambos
  ///   (puede retornar cualquiera de los dos).
  ///   Por eso, si la función retorna 'b' en vez de 'a' cuando a == b,
  ///   el test sigue pasando.
  ///
  /// ¿Cómo evitar que el mutante sobreviva?
  ///   Para "matar" este mutante, necesitaríamos distinguir entre el primer
  ///   y segundo argumento aunque tengan el mismo valor, lo cual no es posible
  ///   usando solo enteros. Si usáramos objetos o referencias,
  ///   podríamos escribir un test que verifique que se retorna exactamente
  ///   el primer argumento.
  ///   Es solo una propuesta de mejora, orientada a garantizar una función más
  ///   robusta y pruebas más completas.
  int max(int a, int b) {
    if (a >= b) {
      return a;
    } else {
      return b;
    }
  }
}
