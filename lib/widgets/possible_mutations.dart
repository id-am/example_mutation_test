import 'package:example_mutation_test/models/operation_details.dart';
import 'package:example_mutation_test/enums/operations.dart';
import 'package:flutter/material.dart';

class PossibleMutations extends StatelessWidget {
  final OperationDetails operationDescriptions;

  const PossibleMutations({super.key, required this.operationDescriptions});

  static const Map<Operations, List<String>> possibleMutations = {
    Operations.add: ['a - b', 'a * b', 'a / b'],
    Operations.subtract: ['a + b', 'a * b', 'a / b'],
    Operations.multiply: ['a + b', 'a - b', 'a / b'],
    Operations.divide: ['a + b', 'a - b', 'a * b'],
    Operations.isEven: ['a % 2 != 0', 'true', 'false'],
    Operations.max: ['a < b ? a : b', 'a == b ? a : b', 'a'],
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        const Text(
          'Posibles Mutaciones',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Card(
          color: Colors.amber.shade100,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Código original:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    operationDescriptions.function,
                    style: const TextStyle(fontFamily: 'monospace'),
                  ),
                ),
                const Divider(),
                const Text(
                  'Posibles mutantes que se generarían:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ...possibleMutations[operationDescriptions.operation]!
                    .map(
                      (mutation) => Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.red.shade300),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.warning, color: Colors.red),
                            const SizedBox(width: 8),
                            Text(
                              mutation,
                              style: const TextStyle(fontFamily: 'monospace'),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                const SizedBox(height: 8),
                const Text(
                  '⚠️ Si tus pruebas pasan después de estas mutaciones, entonces no son lo suficientemente efectivas.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
