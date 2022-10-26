import 'package:account_control/core/ui/extensions/theme_extension.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../core/ui/widgets/widgets.dart';
import '../../domain/entities/entities.dart';
import '../../presenter/cubits/cubits.dart';

class SaveAccountPage extends StatefulWidget {
  const SaveAccountPage({
    Key? key,
  }) : super(key: key);
  @override
  State<SaveAccountPage> createState() => _SaveAccountPageState();
}

class _SaveAccountPageState extends State<SaveAccountPage> {
  final _formKey = GlobalKey<FormState>();
  final _formKeyBank = GlobalKey<FormState>();
  final _numAccountEC = TextEditingController();
  final _controllerMoneyAccount =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  final _bankEC = TextEditingController();
  String? _bankSelected;

  bool _showBankEC = false;
  int? _bankSelectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account register'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              constraints: const BoxConstraints(minHeight: 200),
              child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  DentrodobolsoTextFormField(
                    label: 'conta',
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    textInputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: Validatorless.required('Campo obrigatório'),
                    controller: _numAccountEC,

                    // validator: Validatorless.required('Valor é obrigatório'),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  DentrodobolsoTextFormField(
                    label: 'Valor',
                    controller: _controllerMoneyAccount,
                    textInputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: Validatorless.required('Campo obrigatório'),
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    // validator: Validatorless.required('Valor é obrigatório'),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  BlocBuilder<SaveAccountCubit, SaveAccountState>(
                    builder: (context, state) {
                      if (state is SaveAccountLoadingState) {
                        return const Center(
                          key: Key('circular-progress-indicator'),
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is AccountBankLoadedState) {
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
                                validator:
                                    Validatorless.required('Campo obrigatório'),
                                hint: const Text('Banco'),
                                value: _bankSelected,
                                onChanged: (value) => setState(() {
                                  _bankSelected = value!;
                                }),
                                items: state.accountBank.map(
                                  (BankEntity map) {
                                    return DropdownMenuItem<String>(
                                      value: map.id.toString(),
                                      onTap: () => setState(() {
                                        _bankSelectedIndex = map.id;
                                      }),
                                      child: Text(
                                        map.instituicao,
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
                                _showBankEC = !_showBankEC;
                              }),
                              icon: _showBankEC
                                  ? const Icon(Icons.remove)
                                  : const Icon(Icons.add),
                            ),
                          ],
                        );
                      } else if (state is SaveAccountErrorState) {
                        return Center(
                          key: const Key('expense-error-message'),
                          child: Text(state.errorMessage),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                  SizedBox(
                    height: _showBankEC ? 16 : 0,
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _showBankEC ? _saveBank() : const SizedBox(),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: BlocConsumer<SaveAccountCubit, SaveAccountState>(
        listener: (context, state) {
          if (state is SaveAccountSuccessState) {
            showDialog(
              context: context,
              builder: (_) => const _SuccessDialogWidget(
                mensage: 'Conta inserida com sucesso',
                question: 'Deseja inserir outro dado?',
              ),
            );
          }
          if (state is SaveAccountErrorState) {
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
          final bool isLoadingState = state is SaveAccountLoadingState;
          return FloatingActionButton(
            onPressed: () {
              final formValid = _formKey.currentState?.validate() ?? false;
              if (formValid) {
                final request = SaveAccountEntity(
                  conta: int.parse(_numAccountEC.text),
                  id: 0,
                  idbanco: _bankSelectedIndex!,
                  saldo: _controllerMoneyAccount.numberValue,
                );
                context.read<SaveAccountCubit>().saveAccount(request);
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

  _saveBank() {
    return Form(
      key: _formKeyBank,
      child: Column(
        children: [
          DentrodobolsoTextFormField(
            label: 'Banco',
            controller: _bankEC,
            validator: Validatorless.required('Campo obrigatório'),
          ),
          const SizedBox(
            height: 16,
          ),
          BlocConsumer<SaveAccountCubit, SaveAccountState>(
            listener: (context, state) {
              if (state is SaveBankSuccessState) {
                showDialog(
                  context: context,
                  builder: (_) => const _SuccessDialogWidget(
                    mensage: 'Banco inserido com sucesso',
                    question: 'Deseja inserir outro dado?',
                  ),
                );
              }
              if (state is SaveAccountErrorState) {
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
              final bool isLoadingState = state is SaveAccountLoadingState;
              return AppButton(
                key: const Key('save-bank'),
                text: 'Salvar banco',
                onPressed: () {
                  final formValid =
                      _formKeyBank.currentState?.validate() ?? false;
                  if (formValid) {
                    final request = BankEntity(
                      id: 0,
                      instituicao: _bankEC.text,
                    );
                    context.read<SaveAccountCubit>().saveBank(request);
                    _bankEC.clear();
                  }
                },
                showProgress: isLoadingState,
              );
            },
          ),
        ],
      ),
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
          onTap: () => Navigator.of(context).popUntil((route) => route.isFirst),
        ),
      ],
    );
  }
}
