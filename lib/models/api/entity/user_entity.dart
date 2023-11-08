import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity {
  final int? id;
  final String? name;
  final String? mobile_no;
  final String? email;
  final String? address;
  final String? restrictions;
  final int? role_id;
  final bool? is_active;

  UserEntity(
      {this.id,
      this.name,
      this.mobile_no,
      this.email,
      this.address,
      this.role_id,
      this.restrictions,
      this.is_active});

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}
