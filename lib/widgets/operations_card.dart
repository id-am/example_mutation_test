import 'package:example_mutation_test/calculator.dart';
import 'package:example_mutation_test/models/operation_details.dart';
import 'package:example_mutation_test/enums/operations.dart';
import 'package:example_mutation_test/utils/enums.dart';
import 'package:flutter/material.dart';

class OperationsCard extends StatefulWidget {
  final ValueChanged<OperationDetails> onChangeOperation;
  const OperationsCard({super.key, required this.onChangeOperation});

  @override
  State<OperationsCard> createState() => _OperationsCardState();
}

class _OperationsCardState extends State<OperationsCard> {
  final Calculator calculator = Calculator();

  int num1 = 12;
  int num2 = 2;
  Operations selectedOperation = Operations.add;
  dynamic result;
  bool showMutationPanel = false;

  void _calculateResult() {
    setState(() {
      switch (selectedOperation) {
        case Operations.add:
          result = calculator.add(num1, num2);
          break;
        case Operations.subtract:
          result = calculator.subtract(num1, num2);
          break;
        case Operations.multiply:
          result = calculator.multiply(num1, num2);
          break;
        case Operations.divide:
          try {
            result = calculator.divide(num1, num2);
          } catch (e) {
            result = 'Error: $e';
          }
          break;
        case Operations.isEven:
          result = calculator.isEven(num1) ? 'Es par' : 'No es par';
          break;
        case Operations.max:
          result = calculator.max(num1, num2);
          break;
      }
    });
  }

  final List<OperationDetails> operationDescriptions = [
    OperationDetails(
      operation: Operations.add,
      description: 'Suma (a + b)',
      function: 'a + b',
    ),
    OperationDetails(
      operation: Operations.subtract,
      description: 'Resta (a - b)',
      function: 'a - b',
    ),
    OperationDetails(
      operation: Operations.multiply,
      description: 'Multiplicación (a * b)',
      function: 'a * b',
    ),
    OperationDetails(
      operation: Operations.divide,
      description: 'División (a / b)',
      function: 'a / b',
    ),
    OperationDetails(
      operation: Operations.isEven,
      description: 'Es Par (a % 2 == 0)',
      function: 'a % 2 == 0',
    ),
    OperationDetails(
      operation: Operations.max,
      description: 'Máximo (a ≥ b ? a : b)',
      function: 'a >= b ? a : b',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _calculateResult();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Demostración Interactiva',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(labelText: 'Valor A'),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              num1 = int.parse(value);
                              _calculateResult();
                            });
                          }
                        },
                        controller: TextEditingController(
                          text: num1.toString(),
                        ),
                      ),
                    ),
                    if (selectedOperation != Operations.isEven) ...[
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            labelText: 'Valor B',
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              setState(() {
                                num2 = int.parse(value);
                                _calculateResult();
                              });
                            }
                          },
                          controller: TextEditingController(
                            text: num2.toString(),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedOperation.name,
                  decoration: const InputDecoration(labelText: 'Operación'),
                  items: operationDescriptions.map((op) {
                    return DropdownMenuItem<String>(
                      value: op.operation.name,
                      child: Text(op.description),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedOperation = Enums.enumFromString(
                          Operations.values,
                          value,
                        );
                        _calculateResult();
                        widget.onChangeOperation(
                          operationDescriptions.firstWhere(
                            (op) => op.operation == selectedOperation,
                          ),
                        );
                      });
                    }
                  },
                ),
                const SizedBox(height: 24),
                Center(
                  child: Column(
                    children: [
                      const Text('Resultado:', style: TextStyle(fontSize: 18)),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 24,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          result?.toString() ?? 'N/A',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
