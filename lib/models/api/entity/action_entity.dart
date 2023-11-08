class ActionEntity {
  ActionEntity({
      this.id, 
      this.isActive, 
      this.name,});

  ActionEntity.fromJson(dynamic json) {
    id = json['id'];
    isActive = json['is_active'];
    name = json['name'];
  }
  String? id;
  bool? isActive;
  String? name;
ActionEntity copyWith({  String? id,
  bool? isActive,
  String? name,
}) => ActionEntity(  id: id ?? this.id,
  isActive: isActive ?? this.isActive,
  name: name ?? this.name,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['is_active'] = isActive;
    map['name'] = name;
    return map;
  }

}