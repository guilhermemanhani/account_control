import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../../../core/service_locator/service_locator.dart';
import '../../../expense/presenter/cubits/cubits.dart';
import '../../../expense/presenter/page/expense_page.dart';
import '../cubits/cubits.dart';
import '../widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      body: Padding(
        padding: const EdgeInsets.only(bottom: 32.0),
        child: RefreshIndicator(
          onRefresh: () => context.read<HomeAppCubit>().loadAccounts(),
          child: SingleChildScrollView(
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
                        value: state.accountsInfosEntity.balance,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      LineAccount(
                        accountList: state.accountsInfosEntity.accountsInfos,
                      ),
                      ContainerBudget(
                        budgetEntity: state.budgetEntity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: PieChart(
                          dataMap: state.expenseByLocalExitEntity.isEmpty
                              ? const {
                                  'Sem dados': 1,
                                }
                              : state.expenseByLocalExitEntity,
                          chartType: ChartType.ring,
                          centerText: 'Saídas',
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValueBackground: true,
                            showChartValues: true,
                            chartValueBackgroundColor: Colors.transparent,
                            decimalPlaces: 0,
                            showChartValuesInPercentage: true,
                            showChartValuesOutside: false,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: PieChart(
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValueBackground: true,
                            showChartValues: true,
                            chartValueBackgroundColor: Colors.transparent,
                            decimalPlaces: 0,
                            showChartValuesInPercentage: true,
                            showChartValuesOutside: false,
                          ),
                          dataMap: state.expenseByLocalEntryEntity.isEmpty
                              ? const {
                                  'Sem dados': 1,
                                }
                              : state.expenseByLocalEntryEntity,
                          chartType: ChartType.ring,
                          centerText: 'Entradas',
                        ),
                      ),
                    ],
                  );
                } else if (state is HomeErrorState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                      ),
                      Center(
                        key: const Key('expense-error-message'),
                        child: Text(state.errorMessage),
                      ),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          ),
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
