import 'package:account_control/feature/expense/presenter/cubits/expense_cubit.dart';
import 'package:account_control/feature/expense/presenter/page/expense_page.dart';
import 'package:account_control/feature/home/presenter/cubits/home_app_cubit.dart';
import 'package:account_control/feature/home/presenter/cubits/home_state.dart';
import 'package:account_control/feature/home/presenter/widgets/head_home.dart';
import 'package:account_control/feature/home/presenter/widgets/line_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/service_locator/service_locator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final reactionDisposer = <ReactionDisposer>[];
  // var formatter = NumberFormat.decimalPattern('pt-BR');
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocBuilder<HomeAppCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return const Center(
                key: Key('circular-progress-indicator'),
                child: CircularProgressIndicator(),
              );
            } else if (state is HomeLoadedState) {
              return Column(
                children: [
                  HeadHome(
                    value: state.home.balance,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  LineAccount(
                    accountList: state.home.accountsInfos,
                  ),
                ],
              );
            } else if (state is HomeErrorState) {
              return Center(
                key: const Key('expense-error-message'),
                child: Text(state.errorMessage),
              );
            }
            return const SizedBox();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (context) => getIt<ExpenseCubit>()..loadScreen(),
                child: const ExpensePage(),
              ),
            ),
          );
        },
        child: const Icon(Icons.payment),
      ),
    );
  }
}
