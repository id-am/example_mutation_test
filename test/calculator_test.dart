import 'package:flutter_test/flutter_test.dart';
import 'package:example_mutation_test/calculator.dart';

void main() {
  late Calculator calculator;

  setUp(() {
    calculator = Calculator();
  });

  group('Calculator', () {
    test('add debe sumar dos números correctamente', () {
      expect(calculator.add(2, 3), equals(5));
    });

    test('subtract debe restar dos números correctamente', () {
      expect(calculator.subtract(5, 3), equals(2));
    });

    test('multiply debe multiplicar dos números correctamente', () {
      expect(calculator.multiply(2, 3), equals(6));
    });

    group('divide', () {
      test('debe dividir dos números correctamente', () {
        expect(calculator.divide(6, 3), equals(2.0));
      });

      test('debe lanzar ArgumentError cuando se divide por cero', () {
        expect(() => calculator.divide(5, 0), throwsArgumentError);
      });
    });

    group('isEven', () {
      test('debe retornar true para números pares', () {
        expect(calculator.isEven(2), isTrue);
        expect(calculator.isEven(4), isTrue);
        expect(calculator.isEven(0), isTrue);
      });

      test('debe retornar false para números impares', () {
        expect(calculator.isEven(1), isFalse);
        expect(calculator.isEven(3), isFalse);
        expect(calculator.isEven(5), isFalse);
      });
    });

    group('max', () {
      test('debe retornar el primer número cuando es mayor', () {
        expect(calculator.max(5, 3), equals(5));
      });

      test('debe retornar el segundo número cuando es mayor', () {
        expect(calculator.max(3, 5), equals(5));
      });

      test('debe retornar cualquiera de los números cuando son iguales', () {
        expect(calculator.max(4, 4), equals(4));
      });
    });
  });
}
