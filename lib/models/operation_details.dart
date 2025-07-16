import 'package:example_mutation_test/enums/operations.dart';

class OperationDetails {
  final Operations operation;
  final String description;
  final String function;

  OperationDetails({
    required this.operation,
    required this.description,
    required this.function,
  });
}
