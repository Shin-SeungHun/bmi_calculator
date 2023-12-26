import 'dart:convert';

import 'package:bmi_calculator/model/user_bmi_data.dart';
import 'package:bmi_calculator/result/result_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  void dispose() {
    super.dispose();
    _heightController.dispose();
    _weightController.dispose();
  }

  Future save() async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('height', double.parse(_heightController.text));
    await prefs.setDouble('weight', double.parse(_weightController.text));
  }

  Future load() async {
    final prefs = await SharedPreferences.getInstance();
    final double? height = prefs.getDouble('height');
    final double? weight = prefs.getDouble('weight');
    if (height != null && weight != null) {
      _heightController.text = '$height';
      _weightController.text = '$weight';
      if (kDebugMode) {
        print('키 : $height, 몸무게 $weight');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('비만도 계산기'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                controller: _heightController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: '키'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '키를 입력하세요';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _weightController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: '몸무게'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '몸무게를 입력하세요';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() == false) {
                    return;
                  }

                  final height = double.parse(_heightController.text);
                  final weight = double.parse(_weightController.text);
                  save();

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ResultScreen(
                  //         height: double.parse(_heightController.text),
                  //         weight: double.parse(_weightController.text)),
                  //   ),
                  // );

                  final userBmiData =
                      UserBmiData(height: height, weight: weight);
                  context.push(
                    Uri(
                      path: '/result',
                      queryParameters: {
                        'userBmiData': jsonEncode(userBmiData.toJson())
                      },
                    ).toString(),
                  );
                },
                child: const Text('결과'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
