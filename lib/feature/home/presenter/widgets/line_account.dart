import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LineAccount extends StatefulWidget {
  final List<AccountModel> accountList;
  const LineAccount({
    Key? key,
    required this.accountList,
  }) : super(key: key);

  @override
  State<LineAccount> createState() => _LineAccountState();
}

class _LineAccountState extends ModularState<LineAccount, HomeController> {
  var formatter = NumberFormat.decimalPattern('pt-BR');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.accountList.length,
        itemBuilder: (context, index) {
          final account = widget.accountList[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/home/detail/',
                    arguments: account.id);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                height: 60,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[50],
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(
                        0,
                        3,
                      ),
                    ),
                  ],
                ),
                constraints: const BoxConstraints(
                  minWidth: 160,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${account.instituicao!}  ${account.conta.toString()}",
                      style: const TextStyle(color: Colors.blue),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      controller.dealMoneyValue(
                        formatter.format(
                          DecimalIntl(
                            Decimal.parse(account.saldo.toString()),
                          ),
                        ),
                      ),

                      // account.saldo.toString(),
                      style: TextStyle(
                        color: account.saldo.toString().contains('-')
                            ? Colors.red
                            : Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
