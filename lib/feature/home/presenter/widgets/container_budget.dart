import 'package:flutter/material.dart';

import '../../domain/entities/budget_entity.dart';
import '../widgets/widgets.dart';

class ContainerBudget extends StatelessWidget {
  final BudgetEntity budgetEntity;
  const ContainerBudget({
    Key? key,
    required this.budgetEntity,
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
            RowInfo(
              colorText: Colors.green,
              title: 'Entrada',
              value: budgetEntity.entry,
            ),
            const SizedBox(
              height: 16,
            ),
            RowInfo(
              colorText: Colors.red,
              title: 'Saída',
              value: budgetEntity.exit,
            ),
            const SizedBox(
              height: 16,
            ),
            RowInfo(
                colorText: budgetEntity.exitD < budgetEntity.entryD
                    ? Colors.green
                    : Colors.red,
                title: 'Orçamento usado do mês',
                value: "${budgetEntity.budgetUse}%"
                // '${((controller.exit / controller.entry))}',

                ),
            const SizedBox(
              height: 16,
            ),
            RowInfo(
              colorText: Colors.green,
              title: 'Balanço entra/saída',
              value: budgetEntity.entryxsaida,
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
