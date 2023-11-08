class ServiceEntity {
  ServiceEntity({
      this.isActive, 
      this.name, 
      this.addedOn, 
      this.id,});

  ServiceEntity.fromJson(dynamic json) {
    isActive = json['is_active'];
    name = json['name'];
    addedOn = json['added_on'];
    id = json['id'];
  }
  bool? isActive;
  String? name;
  String? addedOn;
  int? id;


  @override
  String toString() {
    return name??"";
  }

  ServiceEntity copyWith({  bool? isActive,
  String? name,
  String? addedOn,
  int? id,
}) => ServiceEntity(  isActive: isActive ?? this.isActive,
  name: name ?? this.name,
  addedOn: addedOn ?? this.addedOn,
  id: id ?? this.id,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_active'] = isActive;
    map['name'] = name;
    map['added_on'] = addedOn;
    map['id'] = id;
    return map;
  }

}