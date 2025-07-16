enum Operations { add, subtract, multiply, divide, isEven, max }

extension OperationsExtension on Operations {
  String get name {
    switch (this) {
      case Operations.add:
        return 'add';
      case Operations.subtract:
        return 'subtract';
      case Operations.multiply:
        return 'multiply';
      case Operations.divide:
        return 'divide';
      case Operations.isEven:
        return 'isEven';
      case Operations.max:
        return 'max';
    }
  }
}
