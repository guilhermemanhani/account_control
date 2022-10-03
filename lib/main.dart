import 'package:account_control/core/service_locator/service_locator.dart';
import 'package:account_control/core/ui/uiconfig.dart';
import 'package:account_control/feature/home/presenter/cubits/home_app_cubit.dart';
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
      title: UiConfig.title,
      theme: UiConfig.theme,
      home: BlocProvider(
        create: (_) => getIt<HomeAppCubit>(),
        child: const HomePage(),
      ),
    );
  }
}
