import 'package:ltss/base/base.dart';
import 'package:tuple/tuple.dart';

class CommissionEntity {
  CommissionEntity({
      this.commissionId, 
      this.value, 
      this.name, 
      this.serviceId, 
      this.addedOn, 
      this.isActive,});

  CommissionEntity.fromJson(dynamic json) {
    commissionId = json['commission_id'];
    value = json['value'];
    name = json['name'];
    serviceId = json['service_id'];
    addedOn = json['added_on'];
    isActive = json['is_active'];
  }
  int? commissionId;
  String? value;
  String? name;
  int? serviceId;
  String? addedOn;
  bool? isActive;
CommissionEntity copyWith({  int? commissionId,
  String? value,
  String? name,
  int? serviceId,
  String? addedOn,
  bool? isActive,
}) => CommissionEntity(  commissionId: commissionId ?? this.commissionId,
  value: value ?? this.value,
  name: name ?? this.name,
  serviceId: serviceId ?? this.serviceId,
  addedOn: addedOn ?? this.addedOn,
  isActive: isActive ?? this.isActive,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['commission_id'] = commissionId;
    map['value'] = value;
    map['name'] = name;
    map['service_id'] = serviceId;
    map['added_on'] = addedOn;
    map['is_active'] = isActive;
    return map;
  }

  List<Tuple2> getValues(){
    if(value!=null){
      return splitIntoTuples(value!);
    }else{
      return [];
    }
  }
}