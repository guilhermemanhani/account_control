import 'package:account_control/core/ui/extensions/theme_extension.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/ui/widgets/widgets.dart';
import '../../domain/entities/entities.dart';
import '../cubits/cubits.dart';
import '../widget/widget.dart';

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
  final _formKey = GlobalKey<FormState>();
  final _formKeyPopup = GlobalKey<FormState>();
  bool _isNegative = false;
  DateTime _selectedDate = DateTime.now();
  String _selectedBank = '';
  String? _selectedAccount;
  String? _selectedReason;
  String? _selectedLocal;
  List<BankEntity> listBank = [];

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
                          DialogReasonsAdd(
                            message: 'Local já cadastrados:',
                            messageHighlighted: state.expenseLocal
                                .map((local) => local.local)
                                .join(', '),
                            nameForm: 'Local',
                            title: 'Adicione um novo local',
                            saveController: (val) {
                              // controller.saveLocal(val);
                            },
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
                          IconButton(
                            onPressed: () => _showDialogAccount(),
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
                    return Row(
                      children: [
                        const Text('Você precisa cadastrar uma conta'),
                        IconButton(
                          onPressed: () => _showDialogAccount(),
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    );
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
                          DialogReasonsAdd(
                            message: 'Motivos já cadastrados:',
                            messageHighlighted: state.expenseReason
                                .map((reason) => reason.motivo)
                                .join(', '),
                            nameForm: 'Motivo',
                            title: 'Adicione um novo motivo',
                            saveController: (val) {
                              // controller.saveReason(val);
                            },
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

  _showDialogAccount() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogAccount(
          message: 'Bancos já cadastrados:',
          messageHighlighted:
              listBank.map((bank) => bank.instituicao).join(', '),
          title: 'Deseja adicionar uma conta ou um banco?',
          onTapBanco: () => _dialogSimpleRegisterBank(),
          onTapConta: () => _showDialogRegisterAccount(),
        );
      },
    );
  }

  _showDialogRegisterAccount() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              16,
            ),
          ),
          content: Form(
            key: _formKeyPopup,
            child: Container(
              width: MediaQuery.of(context).size.width,
              constraints: const BoxConstraints(minHeight: 200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  DentrodobolsoTextFormField(
                    label: 'conta',
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    controller: _numAccountEC,
                    textInputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    // validator: Validatorless.required('Valor é obrigatório'),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  DentrodobolsoDropDownButton(
                    widget: DropdownButton<String>(
                      underline: Container(
                        width: double.infinity,
                      ),
                      isExpanded: true,
                      icon: const Icon(
                        Icons.keyboard_arrow_down_sharp,
                      ),
                      hint: const Text('Banco'),
                      value: _selectedBank,
                      // isDense: true,
                      onChanged: (value) => setState(() {
                        _selectedBank = value!;
                      }),
                      items: listBank.map(
                        (BankEntity map) {
                          return DropdownMenuItem<String>(
                            onTap: () => setState(() {
                              _selectedBank = map.id.toString();
                            }),
                            value: map.id.toString(),
                            child: Text(
                              map.instituicao,
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  DentrodobolsoTextFormField(
                    label: 'Valor',
                    controller: _controllerMoneyAccount,
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    // validator: Validatorless.required('Valor é obrigatório'),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextIconButton(
              icon: Icons.check_circle_outline,
              title: 'Salvar',
              color: context.green,
              width: 110,
              onTap: () {
                final formValid =
                    _formKeyPopup.currentState?.validate() ?? false;
                if (formValid) {
                  Navigator.pop(context);
                  // controller.saveAccont(
                  //     _numAccountEC.text, _controllerMoneyAccount.numberValue);
                }

                // widget.onTapSave();
              },
            ),
            const SizedBox(
              width: 16,
            ),
            TextIconButton(
              icon: Icons.cancel_outlined,
              title: 'Cancelar',
              color: context.red,
              width: 110,
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
          actionsPadding: const EdgeInsets.only(bottom: 12),
          actionsAlignment: MainAxisAlignment.center,
          title: Text(
            'Adicionar um nova conta:',
            style: TextStyle(
              color: context.darkBlue,
            ),
          ),
        );
      },
    );
  }

  _dialogSimpleRegisterBank() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogSimpleRegister(
          message: 'Bancos já cadastrados:',
          messageHighlighted:
              listBank.map((bank) => bank.instituicao).join(', '),
          ontap: (val) {
            debugPrint('salvarbanco');
          },
          nameForm: 'Instituição',
          title: 'Adicione um novo banco',
        );
      },
    );
  }
}
