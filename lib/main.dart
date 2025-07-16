import 'package:example_mutation_test/models/operation_details.dart';
import 'package:example_mutation_test/enums/operations.dart';
import 'package:example_mutation_test/utils/enums.dart';
import 'package:example_mutation_test/widgets/operations_card.dart';
import 'package:example_mutation_test/widgets/possible_mutations.dart';
import 'package:flutter/material.dart';
import 'calculator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mutation Test Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MutationTestDemoPage(),
    );
  }
}

class MutationTestDemoPage extends StatefulWidget {
  const MutationTestDemoPage({super.key});

  @override
  State<MutationTestDemoPage> createState() => _MutationTestDemoPageState();
}

class _MutationTestDemoPageState extends State<MutationTestDemoPage> {
  OperationDetails? selectedOperation;
  bool showMutationPanel = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Demostración de Mutation Testing'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              const Text(
                '¿Qué es Mutation Testing?',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Text(
                'El mutation testing evalúa la calidad de las pruebas unitarias introduciendo pequeñas '
                'mutaciones en el código fuente y verificando si las pruebas detectan estos cambios.',
                style: TextStyle(fontSize: 16),
              ),
              OperationsCard(
                onChangeOperation: (operation) {
                  setState(() {
                    selectedOperation = operation;
                  });
                },
              ),
              if (selectedOperation != null)
                ElevatedButton.icon(
                  icon: Icon(
                    showMutationPanel ? Icons.visibility_off : Icons.visibility,
                  ),
                  label: Text(
                    showMutationPanel
                        ? 'Ocultar posibles mutaciones'
                        : 'Mostrar posibles mutaciones',
                  ),
                  onPressed: () {
                    setState(() {
                      showMutationPanel = !showMutationPanel;
                    });
                  },
                ),
              if (showMutationPanel)
                PossibleMutations(operationDescriptions: selectedOperation!),
            ],
          ),
        ),
      ),
    );
  }
}
