import 'dart:convert';

import 'package:bmi_calculator/main/main_screen.dart';
import 'package:bmi_calculator/model/user_bmi_data.dart';
import 'package:bmi_calculator/result/result_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const MainScreen(),
  ),
  GoRoute(
      path: '/result',
      builder: (context, state) {
        final userBmiData = UserBmiData.fromJson(
            jsonDecode(state.uri.queryParameters['userBmiData']!));

        return ResultScreen(
          userBmiData: userBmiData,
        );
      }),
]);
