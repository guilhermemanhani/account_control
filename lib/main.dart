import 'package:account_control/core/service_locator/service_locator.dart';
import 'package:account_control/feature/home/presenter/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  initServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: BlocProvider(
        create: (_) => getIt<HomeAppCubit>(),
        child: const HomePage(),
      ),
    );
  }
}
