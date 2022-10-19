import 'package:account_control/core/service_locator/service_locator.dart';
import 'package:account_control/core/ui/extensions/theme_extension.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';

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

  final _formKey = GlobalKey<FormState>();

  bool _isNegative = false;
  DateTime _selectedDate = DateTime.now();
  String? _selectedAccount;
  String? _selectedReason;
  String? _selectedLocal;
  int? _localId;
  int? _reasonId;
  int? _accountId;
  bool _showLocalEC = false;
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
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
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
                        validator: Validatorless.required('Campo obrigatório'),
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
                  validator: Validatorless.required('Campo obrigatório'),
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
                            widget: DropdownButtonFormField<String>(
                              isExpanded: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                    borderSide: BorderSide(width: 1)),
                              ),
                              icon: const Icon(
                                Icons.keyboard_arrow_down_sharp,
                              ),
                              hint: const Text('Local'),
                              value: _selectedLocal,
                              validator:
                                  Validatorless.required('Campo obrigatório'),
                              onChanged: (value) => setState(() {
                                _selectedLocal = value!;
                              }),
                              items: state.expenseLocal.map(
                                (LocalEntity map) {
                                  return DropdownMenuItem<String>(
                                    value: map.id.toString(),
                                    onTap: () => setState(() {
                                      _localId = map.id;
                                    }),
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
                            widget: DropdownButtonFormField<String>(
                              isExpanded: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                    borderSide: BorderSide(width: 1)),
                              ),
                              icon: const Icon(
                                Icons.keyboard_arrow_down_sharp,
                              ),
                              hint: const Text('Conta'),
                              value: _selectedAccount,
                              validator:
                                  Validatorless.required('Campo obrigatório'),
                              onChanged: (value) => setState(() {
                                _selectedAccount = value!;
                              }),
                              items: state.expenseAccount.map(
                                (AccountEntity map) {
                                  return DropdownMenuItem<String>(
                                    value: map.id.toString(),
                                    onTap: () => setState(() {
                                      _accountId = map.id;
                                    }),
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
                                      getIt<SaveAccountCubit>()..loadBanks(),
                                  child: const SaveAccountPage(),
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
                            widget: DropdownButtonFormField<String>(
                              isExpanded: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                    borderSide: BorderSide(width: 1)),
                              ),
                              icon: const Icon(
                                Icons.keyboard_arrow_down_sharp,
                              ),
                              hint: const Text('Motivo'),
                              validator:
                                  Validatorless.required('Campo obrigatório'),
                              value: _selectedReason,
                              onChanged: (value) => setState(() {
                                _selectedReason = value!;
                              }),
                              items: state.expenseReason.map(
                                (ReasonEntity map) {
                                  return DropdownMenuItem<String>(
                                    value: map.id.toString(),
                                    onTap: () => setState(() {
                                      _reasonId = map.id;
                                    }),
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
      floatingActionButton: BlocConsumer<ExpenseCubit, ExpenseState>(
        listener: (context, state) {
          if (state is SaveExpenseSuccessState) {
            showDialog(
              context: context,
              builder: (_) => const _SuccessDialogWidget(
                mensage: 'Lançamento salvo com sucesso!',
                question: 'Deseja inserir mais?',
              ),
            );
          }
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
          return FloatingActionButton(
            key: const Key('save-account'),
            onPressed: () {
              final formValid = _formKey.currentState?.validate() ?? false;
              if (formValid) {
                final request = ExpenseEntity(
                  descricao: _descriptionEC.text,
                  valor: _controllerMoneyExpense.numberValue,
                  tpagamento: _isNegative == true ? 0 : 1,
                  datahora: _selectedDate,
                  idlancamento: 0,
                  instituicao: _selectedAccount!,
                  localid: _localId!,
                  motivoid: _reasonId!,
                  idconta: _accountId!,
                  local: _localEC.text,
                  motivo: _reasonEC.text,
                );
                context.read<ExpenseCubit>().saveExpense(request);
              }
            },
            child: isLoadingState
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : const Icon(Icons.payment),
          );
        },
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
            if (state is SaveReasonSuccessState) {
              showDialog(
                context: context,
                builder: (_) => const _SuccessDialogWidget(
                  mensage: 'Motivo inserido com sucesso',
                  question: 'Deseja inserir mais?',
                ),
              );
            }
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
                final formValid = _formKey.currentState?.validate() ?? false;
                if (formValid) {
                  final request = ReasonEntity(
                    id: 0,
                    motivo: _reasonEC.text,
                  );
                  context.read<ExpenseCubit>().saveReason(request);
                }
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
            if (state is SaveLocalSuccessState) {
              showDialog(
                context: context,
                builder: (_) => const _SuccessDialogWidget(
                  mensage: 'Local inserido com sucesso',
                  question: 'Deseja inserir mais?',
                ),
              );
            }
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
                final formValid = _formKey.currentState?.validate() ?? false;
                if (formValid) {
                  final request = LocalEntity(
                    id: 0,
                    local: _localEC.text,
                  );
                  context.read<ExpenseCubit>().saveLocal(request);
                }
              },
              showProgress: isLoadingState,
            );
          },
        ),
      ],
    );
  }
}

class _SuccessDialogWidget extends StatelessWidget {
  final String _mensage;
  final String _question;
  const _SuccessDialogWidget({
    Key? key,
    required String mensage,
    required String question,
  })  : _mensage = mensage,
        _question = question,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24.0))),
      backgroundColor: context.white,
      icon: const Icon(
        Icons.check_circle_outline,
        color: Colors.green,
        size: 48,
      ),
      title: Text(_mensage),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(_question),
        ],
      ),
      actionsPadding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 24,
      ),
      actions: [
        TextIconButton(
          icon: Icons.check_circle_outline,
          title: 'Sim',
          color: context.green,
          width: 110,
          onTap: () => Navigator.pop(context),
        ),
        const SizedBox(
          width: 8,
        ),
        TextIconButton(
            icon: Icons.cancel_outlined,
            title: 'Não',
            color: context.red,
            width: 110,
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
            }),
      ],
    );
  }
}
