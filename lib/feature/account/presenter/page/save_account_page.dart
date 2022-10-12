import 'package:account_control/core/ui/extensions/theme_extension.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/ui/widgets/widgets.dart';
import '../../../account/presenter/cubits/cubits.dart';
import '../../../expense/domain/entities/entities.dart';
import '../../domain/entities/entities.dart';

class SaveAccountPage extends StatefulWidget {
  SaveAccountPage({
    Key? key,
    required List<BankEntity> bankList,
  })  : bankListAccount = bankList.length > 1 ? bankList : [],
        super(key: key);
  List<BankEntity> bankListAccount;
  @override
  State<SaveAccountPage> createState() => _SaveAccountPageState();
}

class _SaveAccountPageState extends State<SaveAccountPage> {
  List<BankEntity> get bank => widget.bankListAccount;
  final _formKey = GlobalKey<FormState>();
  final _numAccountEC = TextEditingController();
  final _controllerMoneyAccount =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  String? _bankSelected;
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
                      value: _bankSelected,
                      // isDense: true,
                      onChanged: (value) => setState(() {
                        _bankSelected = value!;
                      }),
                      items: bank.map(
                        (BankEntity map) {
                          return DropdownMenuItem<String>(
                            onTap: () => setState(() {
                              _bankSelectedIndex = map.id;
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
                  BlocConsumer<SaveAccountCubit, SaveAccountState>(
                    listener: (context, state) {
                      if (state is SaveAccountSuccessState) {
                        showDialog(
                          context: context,
                          builder: (_) => const _SuccessDialogWidget(),
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
}

class _SuccessDialogWidget extends StatelessWidget {
  const _SuccessDialogWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text('Conta inserida com sucesso'),
          Text('Deseja inserir outra conta?'),
        ],
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
