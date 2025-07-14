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
  final Calculator calculator = Calculator();

  int num1 = 10;
  int num2 = 5;
  String selectedOperation = 'add';
  dynamic result;
  bool showMutationPanel = false;

  final Map<String, String> operationDescriptions = {
    'add': 'Suma (a + b)',
    'subtract': 'Resta (a - b)',
    'multiply': 'Multiplicación (a * b)',
    'divide': 'División (a / b)',
    'isEven': 'Es Par (a % 2 == 0)',
    'max': 'Máximo (a ≥ b ? a : b)',
  };

  final Map<String, List<String>> possibleMutations = {
    'add': ['a - b', 'a * b', 'a / b'],
    'subtract': ['a + b', 'a * b', 'a / b'],
    'multiply': ['a + b', 'a - b', 'a / b'],
    'divide': ['a + b', 'a - b', 'a * b'],
    'isEven': ['a % 2 != 0', 'true', 'false'],
    'max': ['a < b ? a : b', 'a == b ? a : b', 'a'],
  };

  void _calculateResult() {
    setState(() {
      switch (selectedOperation) {
        case 'add':
          result = calculator.add(num1, num2);
          break;
        case 'subtract':
          result = calculator.subtract(num1, num2);
          break;
        case 'multiply':
          result = calculator.multiply(num1, num2);
          break;
        case 'divide':
          try {
            result = calculator.divide(num1, num2);
          } catch (e) {
            result = 'Error: $e';
          }
          break;
        case 'isEven':
          result = calculator.isEven(num1) ? 'Es par' : 'No es par';
          break;
        case 'max':
          result = calculator.max(num1, num2);
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _calculateResult();
  }

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
            children: [
              // Título principal
              const Text(
                '¿Qué es Mutation Testing?',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'El mutation testing evalúa la calidad de las pruebas unitarias introduciendo pequeñas '
                'mutaciones en el código fuente y verificando si las pruebas detectan estos cambios.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),

              // Calculadora para demostración
              const Text(
                'Demostración Interactiva',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Valores de entrada
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                labelText: 'Valor A',
                              ),
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
                      ),
                      const SizedBox(height: 16),

                      // Selección de operación
                      DropdownButtonFormField<String>(
                        value: selectedOperation,
                        decoration: const InputDecoration(
                          labelText: 'Operación',
                        ),
                        items: operationDescriptions.entries
                            .map(
                              (entry) => DropdownMenuItem(
                                value: entry.key,
                                child: Text(entry.value),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              selectedOperation = value;
                              _calculateResult();
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 24),

                      // Resultado
                      Center(
                        child: Column(
                          children: [
                            const Text(
                              'Resultado:',
                              style: TextStyle(fontSize: 18),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 24,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primaryContainer,
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

              const SizedBox(height: 24),

              // Panel de mutaciones
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

              showMutationPanel
                  ? ShowPossibleMutations(
                      operationDescriptions: operationDescriptions,
                      possibleMutations: possibleMutations,
                      selectedOperation: selectedOperation,
                    )
                  : ShowCode(),
            ],
          ),
        ),
      ),
    );
  }
}

class ShowPossibleMutations extends StatelessWidget {
  final Map<String, String> operationDescriptions;
  final Map<String, List<String>> possibleMutations;
  final String selectedOperation;

  const ShowPossibleMutations({
    super.key,
    required this.operationDescriptions,
    required this.possibleMutations,
    required this.selectedOperation,
  });

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
                    operationDescriptions[selectedOperation]
                            ?.split('(')[1]
                            .split(')')[0] ??
                        '',
                    style: const TextStyle(fontFamily: 'monospace'),
                  ),
                ),
                const Divider(),
                const Text(
                  'Posibles mutantes que se generarían:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ...possibleMutations[selectedOperation]!
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

class ShowCode extends StatelessWidget {
  const ShowCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: TextButton.icon(
            icon: const Icon(Icons.code),
            label: const Text('Ver código fuente y pruebas'),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Explorar el Código'),
                  content: const Text(
                    'Para explorar el código fuente y las pruebas, revisa los archivos:\n\n'
                    '- lib/calculator.dart\n'
                    '- test/calculator_test.dart\n'
                    '- mutest.config.json',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cerrar'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
