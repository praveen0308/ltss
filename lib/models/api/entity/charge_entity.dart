import 'package:tuple/tuple.dart';

import '../../../utils/ext_methods.dart';

class ChargeEntity {
  ChargeEntity({
      this.chargeId, 
      this.serviceId, 
      this.isActive, 
      this.name, 
      this.addedOn, 
      this.value,});

  ChargeEntity.fromJson(dynamic json) {
    chargeId = json['charge_id'];
    serviceId = json['service_id'];
    isActive = json['is_active'];
    name = json['name'];
    addedOn = json['added_on'];
    value = json['value'];
  }
  int? chargeId;
  int? serviceId;
  bool? isActive;
  String? name;
  String? addedOn;
  String? value;
ChargeEntity copyWith({  int? chargeId,
  int? serviceId,
  bool? isActive,
  String? name,
  String? addedOn,
  String? value,
}) => ChargeEntity(  chargeId: chargeId ?? this.chargeId,
  serviceId: serviceId ?? this.serviceId,
  isActive: isActive ?? this.isActive,
  name: name ?? this.name,
  addedOn: addedOn ?? this.addedOn,
  value: value ?? this.value,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['charge_id'] = chargeId;
    map['service_id'] = serviceId;
    map['is_active'] = isActive;
    map['name'] = name;
    map['added_on'] = addedOn;
    map['value'] = value;
    return map;
  }

  List<Tuple2<String,String>> getValues(){
    if(value!=null){
      return splitIntoTuples(value!);
    }else{
      return [];
    }
  }
}