import 'dart:math';

import 'package:flutter/material.dart';

import 'dice.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dice Game',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const DiceScreen(),
    );
  }
}

class DiceScreen extends StatefulWidget {
  const DiceScreen({super.key});

  @override
  State<DiceScreen> createState() => _DiceScreenState();
}

class _DiceScreenState extends State<DiceScreen> {
  int firstDie = 1;
  int secondDie = 1;
  int total = 2;

  String imagePath = 'assets/sad.png';
  String resultText = 'You Lose';

  void rollDice() {
    setState(() {
      firstDie = Random().nextInt(6) + 1;
      secondDie = Random().nextInt(6) + 1;
      total = firstDie + secondDie;

      if (total >= 10) {
        imagePath = 'assets/happy.png';
        resultText = 'You Win';
      } else {
        imagePath = 'assets/sad.png';
        resultText = 'You Lose';
      }
    });
  }

  void resetDice() {
    setState(() {
      firstDie = 1;
      secondDie = 1;
      total = 2;
      imagePath = 'assets/sad.png';
      resultText = 'You Lose';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dice Game'),
        centerTitle: true,
        leading: const Icon(Icons.casino),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 12),

              Text(
                'Total: $total',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.image_not_supported,
                      size: 120,
                    );
                  },
                ),
              ),

              const SizedBox(height: 8),

              Text(
                resultText,
                style: Theme.of(context).textTheme.titleLarge,
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Dice(value: firstDie),
                  Dice(value: secondDie),
                ],
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: rollDice,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Roll'),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: resetDice,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Reset'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}