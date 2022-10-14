import 'package:account_control/core/ui/extensions/theme_extension.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                    controller: _numAccountEC,
                    textInputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    // validator: Validatorless.required('Valor é obrigatório'),
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
                              widget: DropdownButton<String>(
                                isExpanded: true,
                                underline: Container(
                                  width: double.infinity,
                                ),
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                ),
                                hint: const Text('Local'),
                                value: _bankSelected,
                                onChanged: (value) => setState(() {
                                  _bankSelected = value!;
                                }),
                                items: state.accountBank.map(
                                  (BankEntity map) {
                                    return DropdownMenuItem<String>(
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
                  _showBankEC ? _saveBank() : const SizedBox(),
                  const SizedBox(
                    height: 16,
                  ),
                  BlocConsumer<SaveAccountCubit, SaveAccountState>(
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
                      final bool isLoadingState =
                          state is SaveAccountLoadingState;
                      return AppButton(
                        key: const Key('save-account'),
                        text: 'Salvar conta',
                        onPressed: () {
                          final request = SaveAccountEntity(
                            conta: int.parse(_numAccountEC.text),
                            id: 0,
                            idbanco: _bankSelectedIndex!,
                            saldo: _controllerMoneyAccount.numberValue,
                          );
                          context.read<SaveAccountCubit>().saveAccount(request);
                        },
                        showProgress: isLoadingState,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
                final request = BankEntity(
                  id: 0,
                  instituicao: _bankEC.text,
                );
                context.read<SaveAccountCubit>().saveBank(request);
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
