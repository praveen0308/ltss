import 'package:ltss/models/api/entity/wallet_ledger_entity.dart';

class WalletLedgerResponse {
  WalletLedgerResponse({
      this.items, 
      this.skip, 
      this.limit, 
      this.totalCount,});

  WalletLedgerResponse.fromJson(dynamic json) {
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(WalletLedgerEntity.fromJson(v));
      });
    }
    skip = json['skip'];
    limit = json['limit'];
    totalCount = json['total_count'];
  }
  List<WalletLedgerEntity>? items;
  int? skip;
  int? limit;
  int? totalCount;
WalletLedgerResponse copyWith({  List<WalletLedgerEntity>? items,
  int? skip,
  int? limit,
  int? totalCount,
}) => WalletLedgerResponse(  items: items ?? this.items,
  skip: skip ?? this.skip,
  limit: limit ?? this.limit,
  totalCount: totalCount ?? this.totalCount,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (items != null) {
      map['items'] = items?.map((v) => v.toJson()).toList();
    }
    map['skip'] = skip;
    map['limit'] = limit;
    map['total_count'] = totalCount;
    return map;
  }

}