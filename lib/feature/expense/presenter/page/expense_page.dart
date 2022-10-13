import 'package:account_control/core/service_locator/service_locator.dart';
import 'package:account_control/core/ui/extensions/theme_extension.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/ui/widgets/widgets.dart';
import '../../../account/presenter/presenter.dart';
import '../../domain/entities/entities.dart';
import '../cubits/cubits.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({Key? key}) : super(key: key);

  @override
  _ExpensePageState createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  final _controllerMoneyExpense =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  final _controllerMoneyAccount =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  final dateFormat = DateFormat('dd/MM/y');
  final _descriptionEC = TextEditingController();
  final _numAccountEC = TextEditingController();
  final _localEC = TextEditingController();
  final _reasonEC = TextEditingController();
  final _bankEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isNegative = false;
  DateTime _selectedDate = DateTime.now();
  String? _selectedAccount;
  String? _selectedReason;
  String? _selectedLocal;
  bool _showLocalEC = false;
  final bool _showBankEC = false;
  bool _showReasonEC = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionEC.dispose();
    _controllerMoneyExpense.dispose();
    _controllerMoneyAccount.dispose();
    _numAccountEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entradas / Saídas'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.add),
                    CupertinoSwitch(
                      activeColor: context.red,
                      trackColor: context.green,
                      value: _isNegative,
                      onChanged: (value) => setState(() {
                        _isNegative = value;
                      }),
                    ),
                    const Icon(Icons.remove),
                    Expanded(
                      child: DentrodobolsoTextFormField(
                        controller: _controllerMoneyExpense,
                        label: 'valor',
                        textInputType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        // validator:
                        //     Validatorless.required('Valor é obrigatório'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                CalendarButton(
                  onChanged: (val) => setState(() {
                    _selectedDate = val;
                  }),
                  selectdDate: _selectedDate,
                  width: double.infinity,
                  buttonLabel: 'Selecione uma data',
                ),
                const SizedBox(
                  height: 16,
                ),
                DentrodobolsoTextFormField(
                  label: 'Descrição',
                  controller: _descriptionEC,
                ),
                const SizedBox(
                  height: 16,
                ),
                BlocBuilder<ExpenseCubit, ExpenseState>(
                  builder: (context, state) {
                    if (state is ExpenseLoadingState) {
                      return const Center(
                        key: Key('circular-progress-indicator'),
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is ExpenseScreenLoadedState) {
                      return Row(
                        children: [
                          DentrodobolsoDropDownButton(
                            widget: DropdownButton<String>(
                              isExpanded: true,
                              underline: Container(
                                width: double.infinity,
                              ),
                              icon: const Icon(
                                Icons.keyboard_arrow_down_sharp,
                              ),
                              hint: const Text('Local'),
                              value: _selectedLocal,
                              onChanged: (value) => setState(() {
                                _selectedLocal = value!;
                              }),
                              items: state.expenseLocal.map(
                                (LocalEntity map) {
                                  return DropdownMenuItem<String>(
                                    value: map.id.toString(),
                                    child: Text(
                                      map.local,
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          IconButton(
                            onPressed: () => setState(() {
                              _showLocalEC = !_showLocalEC;
                            }),
                            icon: _showLocalEC
                                ? const Icon(Icons.remove)
                                : const Icon(Icons.add),
                          ),
                        ],
                      );
                    } else if (state is ExpenseErrorState) {
                      return Center(
                        key: const Key('expense-error-message'),
                        child: Text(state.errorMessage),
                      );
                    }
                    return const SizedBox();
                  },
                ),
                SizedBox(
                  height: _showLocalEC ? 16 : 0,
                ),
                _showLocalEC ? _saveLocal() : const SizedBox(),
                const SizedBox(
                  height: 16,
                ),
                BlocBuilder<ExpenseCubit, ExpenseState>(
                  builder: (context, state) {
                    if (state is ExpenseLoadingState) {
                      return const Center(
                        key: Key('circular-progress-indicator'),
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is ExpenseScreenLoadedState) {
                      return Row(
                        children: [
                          DentrodobolsoDropDownButton(
                            widget: DropdownButton<String>(
                              isExpanded: true,
                              underline: Container(
                                width: double.infinity,
                              ),
                              icon: const Icon(
                                Icons.keyboard_arrow_down_sharp,
                              ),
                              hint: const Text('Conta'),
                              value: _selectedAccount,
                              onChanged: (value) => setState(() {
                                _selectedAccount = value!;
                              }),
                              items: state.expenseAccount.map(
                                (AccountEntity map) {
                                  return DropdownMenuItem<String>(
                                    value: map.id.toString(),
                                    // onTap: () =>
                                    //     state.expenseAccount.setIdAcccount(map.id),
                                    child: Text(
                                      '${map.instituicao} ${map.conta}',
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          // todo: add bank
                          IconButton(
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => BlocProvider(
                                  create: (context) =>
                                      getIt<SaveAccountCubit>(),
                                  child: SaveAccountPage(
                                    bankList: state.expenseBank,
                                  ),
                                ),
                              ),
                            ),
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      );
                    } else if (state is ExpenseErrorState) {
                      return Center(
                        key: const Key('expense-error-message'),
                        child: Text(state.errorMessage),
                      );
                    }
                    return const SizedBox();
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                BlocBuilder<ExpenseCubit, ExpenseState>(
                  builder: (context, state) {
                    if (state is ExpenseLoadingState) {
                      return const Center(
                        key: Key('circular-progress-indicator'),
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is ExpenseScreenLoadedState) {
                      return Row(
                        children: [
                          DentrodobolsoDropDownButton(
                            widget: DropdownButton<String>(
                              isExpanded: true,
                              underline: Container(
                                width: double.infinity,
                              ),
                              icon: const Icon(
                                Icons.keyboard_arrow_down_sharp,
                              ),
                              hint: const Text('Motivo'),
                              value: _selectedReason,
                              onChanged: (value) => setState(() {
                                _selectedReason = value!;
                              }),
                              items: state.expenseReason.map(
                                (ReasonEntity map) {
                                  return DropdownMenuItem<String>(
                                    value: map.id.toString(),
                                    child: Text(
                                      map.motivo,
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          IconButton(
                            onPressed: () => setState(() {
                              _showReasonEC = !_showReasonEC;
                            }),
                            icon: _showReasonEC
                                ? const Icon(Icons.remove)
                                : const Icon(Icons.add),
                          ),
                        ],
                      );
                    } else if (state is ExpenseErrorState) {
                      return Center(
                        key: const Key('expense-error-message'),
                        child: Text(state.errorMessage),
                      );
                    }
                    return const SizedBox();
                  },
                ),
                SizedBox(
                  height: _showReasonEC ? 16 : 0,
                ),
                _showReasonEC ? _saveReason() : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final formValid = _formKey.currentState?.validate() ?? false;
          if (formValid) {
            // controller.saveExpense(
            //   _descriptionEC.text,
            //   _controllerMoneyExpense.numberValue,
            // );
          }
        },
        child: const Icon(Icons.payment),
      ),
    );
  }

  _saveReason() {
    return Column(
      children: [
        DentrodobolsoTextFormField(
          label: 'Motivo',
          controller: _reasonEC,
        ),
        const SizedBox(
          height: 16,
        ),
        BlocConsumer<ExpenseCubit, ExpenseState>(
          listener: (context, state) {
            if (state is ExpenseErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.errorMessage,
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            final bool isLoadingState = state is ExpenseLoadingState;
            return AppButton(
              key: const Key('save-account'),
              text: 'Salvar motivo',
              onPressed: () {
                final request = ReasonEntity(
                  id: 0,
                  motivo: _reasonEC.text,
                );
                context.read<ExpenseCubit>().saveReason(request);
              },
              showProgress: isLoadingState,
            );
          },
        ),
      ],
    );
  }

  _saveLocal() {
    return Column(
      children: [
        DentrodobolsoTextFormField(
          label: 'Local',
          controller: _localEC,
        ),
        const SizedBox(
          height: 16,
        ),
        BlocConsumer<ExpenseCubit, ExpenseState>(
          listener: (context, state) {
            if (state is ExpenseErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.errorMessage,
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            final bool isLoadingState = state is ExpenseLoadingState;
            return AppButton(
              key: const Key('save-account'),
              text: 'Salvar local',
              onPressed: () {
                final request = LocalEntity(
                  id: 0,
                  local: _localEC.text,
                );
                context.read<ExpenseCubit>().saveLocal(request);
              },
              showProgress: isLoadingState,
            );
          },
        ),
      ],
    );
  }

  _saveBank() {
    return Column(
      children: [
        DentrodobolsoTextFormField(
          label: 'Banco',
          controller: _bankEC,
        ),
        const SizedBox(
          height: 16,
        ),
        BlocConsumer<ExpenseCubit, ExpenseState>(
          listener: (context, state) {
            if (state is ExpenseErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.errorMessage,
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            final bool isLoadingState = state is ExpenseLoadingState;
            return AppButton(
              key: const Key('save-account'),
              text: 'Salvar banco',
              onPressed: () {
                final request = BankEntity(
                  id: 0,
                  instituicao: _bankEC.text,
                );
                context.read<ExpenseCubit>().saveBank(request);
              },
              showProgress: isLoadingState,
            );
          },
        ),
      ],
    );
  }
}
