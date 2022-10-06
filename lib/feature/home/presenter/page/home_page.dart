import 'package:account_control/feature/expense/presenter/cubits/expense_cubit.dart';
import 'package:account_control/feature/expense/presenter/page/expense_page.dart';
import 'package:account_control/feature/home/presenter/cubits/home_app_cubit.dart';
import 'package:account_control/feature/home/presenter/cubits/home_state.dart';
import 'package:account_control/feature/home/presenter/widgets/container_budget.dart';
import 'package:account_control/feature/home/presenter/widgets/head_home.dart';
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
    // final autoRunDisposer = autorun(
    //   (_) {
    //     controller.loadHome();
    //     // controller.loadAccounts();
    //     // controller.findPeriod();
    //     // controller.getExpenseByLocal();
    //   },
    // );
    // reactionDisposer.add(autoRunDisposer);
  }

  @override
  void dispose() {
    super.dispose();
    // for (var element in reactionDisposer) {
    //   element();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<HomeAppCubit, HomeState>(
          listener: (context, state) {
            // todo implement listener
          },
          builder: (context, state) {
            return Column(
              children: const [
                HeadHome(
                  value: '0',
                  // value: controller.dealMoneyValue(formatter.format(
                  //     DecimalIntl(controller.accountInfoModel?.balance ??
                  //         Decimal.parse('0.0')))),
                ),

                SizedBox(
                  height: 12,
                ),
                // LineAccount(
                //   accountList: controller.accountInfoModel?.listAccount ??
                //       <AccountModel>[],
                // ),

                ContainerBudget(
                  entryD: 2.2, // controller.entry,
                  exitD: 22, // controller.exit,
                  entry: '22', // controller.dealMoneyValue(formatter.format(
                  // DecimalIntl(Decimal.parse(controller.entry.toString())))),
                  exit: '22', // controller.dealMoneyValue(formatter.format(
                  // DecimalIntl(Decimal.parse(controller.exit.toString())))),
                  budgetUse: '22',
                  // controller.dealMoneyValue(controller.mathValueBudget()),
                  entryxsaida:
                      '22', // controller.dealMoneyValue(formatter.format(
                  // DecimalIntl(Decimal.parse(controller.entry.toString()) -
                  // Decimal.parse(controller.exit.toString())))),
                ),

                // if (controller.dataMapExit.isNotEmpty) {
                //   return Padding(
                //     padding: const EdgeInsets.all(16.0),
                //     child: PieChart(
                //       dataMap: controller.dataMapExit,
                //       chartType: ChartType.ring,
                //       centerText: 'Saídas',
                //       chartValuesOptions: const ChartValuesOptions(
                //         showChartValueBackground: true,
                //         showChartValues: true,
                //         chartValueBackgroundColor: Colors.transparent,
                //         decimalPlaces: 0,
                //         showChartValuesInPercentage: true,
                //         showChartValuesOutside: false,
                //       ),
                //     ),
                //   );
                // } else if (controller.expenseLocalExitObs == null ||
                //     controller.expenseLocalExitObs!.isEmpty) {
                //   return Container(
                //     color: Colors.grey,
                //   );
                // } else {
                //   return Container(
                //     color: Colors.red,
                //   );
                // }
                // },
                // ),
                SizedBox(
                  height: 16,
                ),
                // Observer(
                //   builder: (_) {
                //     if (controller.dataMapEntry.isNotEmpty) {
                //       return Padding(
                //         padding: const EdgeInsets.all(16.0),
                //         child: PieChart(
                //           chartValuesOptions: const ChartValuesOptions(
                //             showChartValueBackground: true,
                //             showChartValues: true,
                //             chartValueBackgroundColor: Colors.transparent,
                //             decimalPlaces: 0,
                //             showChartValuesInPercentage: true,
                //             showChartValuesOutside: false,
                //           ),
                //           dataMap: controller.dataMapEntry,
                //           chartType: ChartType.ring,
                //           centerText: 'Entradas',
                //         ),
                //       );
                //     } else if (controller.expenseLocalEntryObs == null ||
                //         controller.expenseLocalEntryObs!.isEmpty) {
                //       return Container(
                //         color: Colors.grey,
                //       );
                //     } else {
                //       return Container(
                //         color: Colors.red,
                //       );
                //     }
                //   },
                // ),
                SizedBox(
                  height: 40,
                ),
              ],
            );
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

          // controller.loadHome();
        },
        child: const Icon(Icons.payment),
      ),
    );
  }
}
