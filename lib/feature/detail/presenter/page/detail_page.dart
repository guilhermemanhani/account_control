import 'package:account_control/feature/detail/presenter/cubits/detail_cubit.dart';
import 'package:account_control/feature/detail/presenter/cubits/detail_state.dart';
import 'package:account_control/feature/detail/presenter/page/widget/line_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/ui/extensions/theme_extension.dart';
import '../../../../core/ui/widgets/widgets.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  DateTime _selectedInitialDate = DateTime.now();
  DateTime _selectedFinalDate = DateTime.now();
  final formatDate = DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Extrato'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Wrap(
            runSpacing: 16,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CalendarButton(
                  onChanged: (val) => setState(() {
                    _selectedInitialDate = val;
                  }),
                  selectdDate: _selectedInitialDate,
                  width: 150,
                  buttonLabel: 'Data início',
                ),
              ),
              CalendarButton(
                onChanged: (val) => setState(() {
                  _selectedFinalDate = val;
                }),
                selectdDate: _selectedFinalDate,
                width: 150,
                buttonLabel: 'Data final',
              ),
              IconButton(
                color: context.darkBlue,
                padding: const EdgeInsets.only(left: 8),
                onPressed: () => print('search'),
                icon: const Icon(Icons.search),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: BlocBuilder<DetailCubit, DetailState>(
              builder: (context, state) {
                if (state is DetailStateLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is DetailStateLoadedState) {
                  return ListView.builder(
                    itemCount: state.expenses.length,
                    itemBuilder: (context, index) {
                      var expense = state.expenses[index];
                      return InkWell(
                        onTap: () => _showDialogRegisterAccount(),
                        child: Dismissible(
                          key: Key(expense.idlancamento.toString()),
                          onDismissed: (val) => print('delete'),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      LineInfo(
                                        iconOne: Icons.monetization_on_outlined,
                                        iconTwo: Icons.description,
                                        textOne: expense.valor.toString(),
                                        // controller.dealMoneyValue(
                                        //     formatter.format(DecimalIntl(
                                        //         Decimal.parse(expense.valor
                                        //             .toString())))),
                                        textTwo: expense.descricao,
                                      ),
                                      LineInfo(
                                        iconOne: Icons.pin_drop_outlined,
                                        iconTwo: Icons.date_range_outlined,
                                        textOne: expense.local,
                                        textTwo:
                                            formatDate.format(expense.datahora),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: expense.tpagamento == 0
                                              ? Colors.red[100]
                                              : Colors.green[100],
                                        ),
                                        child: Icon(
                                          expense.tpagamento == 0
                                              ? Icons.arrow_circle_down_sharp
                                              : Icons.arrow_circle_up_sharp,
                                          color: expense.tpagamento == 0
                                              ? context.red
                                              : context.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                color: context.darkBlue,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is DetailStateErrorState) {
                  return Center(
                    key: const Key('expense-error-message'),
                    child: Text(state.errorMessage),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }

  _showDialogRegisterAccount() {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              16,
            ),
          ),
          content: Container(
            width: MediaQuery.of(context).size.width,
            constraints: const BoxConstraints(minHeight: 200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
          actionsOverflowButtonSpacing: 4,
          actions: [
            TextIconButton(
              icon: Icons.check_circle_outline,
              title: 'Editar',
              color: context.green,
              width: 100,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            TextIconButton(
              icon: Icons.cancel_outlined,
              title: 'Cancelar',
              color: context.red,
              width: 100,
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
          actionsPadding: const EdgeInsets.only(bottom: 12),
          actionsAlignment: MainAxisAlignment.center,
          title: Row(
            children: [
              Text(
                'Info',
                style: TextStyle(
                  color: context.darkBlue,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
