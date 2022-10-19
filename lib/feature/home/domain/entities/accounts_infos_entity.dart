// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import 'entities.dart';

class AccountsInfosEntity {
  final String balance;
  final List<AccountInfoEntity> accountsInfos;

  AccountsInfosEntity({
    required this.balance,
    required this.accountsInfos,
  });

  @override
  bool operator ==(covariant AccountsInfosEntity other) {
    if (identical(this, other)) return true;

    return other.balance == balance &&
        listEquals(other.accountsInfos, accountsInfos);
  }

  @override
  int get hashCode => balance.hashCode ^ accountsInfos.hashCode;
}
