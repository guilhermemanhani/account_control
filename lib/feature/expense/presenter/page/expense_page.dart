import 'package:account_control/core/ui/extensions/theme_extension.dart';
import 'package:account_control/core/ui/widgets/calendar_button.dart';
import 'package:account_control/core/ui/widgets/dentrodobolso_drop_down_button.dart';
import 'package:account_control/core/ui/widgets/dentrodobolso_text_form_field.dart';
import 'package:account_control/core/ui/widgets/text_icon_button.dart';
import 'package:account_control/feature/expense/domain/entities/account_entity.dart';
import 'package:account_control/feature/expense/domain/entities/bank_entity.dart';
import 'package:account_control/feature/expense/domain/entities/local_entity.dart';
import 'package:account_control/feature/expense/domain/entities/reasons_entity.dart';
import 'package:account_control/feature/expense/presenter/cubits/expense_cubit.dart';
import 'package:account_control/feature/expense/presenter/cubits/expense_state.dart';
import 'package:account_control/feature/expense/presenter/widget/dialog_account.dart';
import 'package:account_control/feature/expense/presenter/widget/dialog_reasons_add.dart';
import 'package:account_control/feature/expense/presenter/widget/dialog_simple_register.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
  String _selectedAccount = '';
  String _selectedReasons = '';
  String _selectedLocal = '';
  List<AccountEntity> listAccount = [];
  List<LocalEntity> listLocal = [];
  List<ReasonsEntity> listReasons = [];
  List<BankEntity> listBank = [];

  // final reactionDisposer = <ReactionDisposer>[];
  @override
  void initState() {
    super.initState();
    // final autoRunDisposer = autorun(
    //   (_) {
    //     controller.loadAccounts();
    //     controller.loadReasons();
    //     controller.loadLocal();
    //     controller.loadBank();
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
          child: Container(
            padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
            width: 1,
            height: 16 - kToolbarHeight,
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
                Row(
                  children: [
                    BlocBuilder<ExpenseCubit, ExpenseState>(
                      builder: (context, state) {
                        if (state is ExpenseLoadingState) {
                          return const Center(
                            key: Key('circular-progress-indicator'),
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is ExpenseAccountLoadedState) {
                          return DentrodobolsoDropDownButton(
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
                          );
                          // return ListView.builder(
                          //   key: const Key('movies-list'),
                          //   itemCount: state.movies.length,
                          //   itemBuilder: (_, index) {
                          //     final movie = state.movies[index];
                          //     return _MovieTile(movie: movie);
                          //   },
                          // );
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
                      width: 16,
                    ),
                    IconButton(
                      onPressed: () => _showDialogAccount(),
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    DentrodobolsoDropDownButton(
                      widget: DropdownButton<String>(
                        underline: Container(
                          width: double.infinity,
                        ),
                        isExpanded: true,
                        icon: const Icon(
                          Icons.keyboard_arrow_down_sharp,
                        ),
                        hint: const Text('Local'),
                        value: _selectedLocal,
                        // isDense: true,
                        onChanged: (value) => setState(() {
                          _selectedLocal = value!;
                        }),
                        items: controller.listLocal.map(
                          (LocalEntity map) {
                            return DropdownMenuItem<String>(
                              onTap: () => controller.setIdLocal(map.id),
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
                      messageHighlighted: controller.listLocal
                          .map((local) => local.local)
                          .join(', '),
                      nameForm: 'Local',
                      title: 'Adicione um novo local',
                      saveController: (val) {
                        // controller.saveLocal(val);
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    DentrodobolsoDropDownButton(
                      widget: DropdownButton<String>(
                        underline: Container(
                          width: double.infinity,
                        ),
                        isExpanded: true,
                        icon: const Icon(
                          Icons.keyboard_arrow_down_sharp,
                        ),
                        hint: const Text('Motivo'),
                        value: _selectedReasons,
                        // isDense: true,
                        onChanged: (value) => setState(() {
                          _selectedReasons = value!;
                        }),
                        items: controller.listReasons.map(
                          (ReasonsEntity map) {
                            return DropdownMenuItem<String>(
                              onTap: () => controller.setIdReasonst(map.id),
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
                      message: 'Motivo já cadastrados:',
                      messageHighlighted: controller.listReasons
                          .map((reasons) => reasons.motivo)
                          .join(', '),
                      nameForm: 'Motivo',
                      title: 'Adicione um novo motivo',
                      saveController: (val) {
                        controller.saveReasons(val);
                      },
                    ),
                  ],
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
              controller.listBank.map((bank) => bank.instituicao).join(', '),
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
                      items: controller.listBank.map(
                        (BankEntity map) {
                          return DropdownMenuItem<String>(
                            onTap: () => controller.setIdBank(map.id),
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
              width: 100,
              onTap: () {
                final formValid =
                    _formKeyPopup.currentState?.validate() ?? false;
                if (formValid) {
                  Navigator.pop(context);
                  controller.saveAccont(
                      _numAccountEC.text, _controllerMoneyAccount.numberValue);
                }

                // widget.onTapSave();
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
              controller.listBank.map((bank) => bank.instituicao).join(', '),
          ontap: (val) {
            controller.saveBank(val);
          },
          nameForm: 'Instituição',
          title: 'Adicione um novo banco',
        );
      },
    );
  }
}
