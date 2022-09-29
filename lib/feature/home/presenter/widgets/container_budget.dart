import 'package:account_control/feature/home/presenter/widgets/row_info.dart';
import 'package:flutter/material.dart';

class ContainerBudget extends StatelessWidget {
  final double entryD;
  final double exitD;
  final String entry;
  final String exit;
  final String budgetUse;
  final String entryxsaida;
  const ContainerBudget({
    Key? key,
    required this.entryD,
    required this.exitD,
    required this.entry,
    required this.exit,
    required this.budgetUse,
    required this.entryxsaida,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 4.0,
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
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
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Orçamento mensal',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w700,
                fontSize: 16,
                fontFamily: 'Allura',
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Divider(
                color: Colors.blue,
                thickness: 1,
              ),
            ),
            Observer(
              builder: (_) {
                return RowInfo(
                  colorText: Colors.green,
                  title: 'Entrada',
                  value: entry,
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Observer(
              builder: (_) {
                return RowInfo(
                  colorText: Colors.red,
                  title: 'Saída',
                  value: exit,
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Observer(
              builder: (_) {
                return RowInfo(
                    colorText: exitD < entryD ? Colors.green : Colors.red,
                    title: 'Orçamento usado do mês',
                    value: "$budgetUse%"
                    // '${((controller.exit / controller.entry))}',
                    );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Observer(
              builder: (_) {
                return RowInfo(
                  colorText: Colors.green,
                  title: 'Balanço entra/saída',
                  value: entryxsaida,
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
