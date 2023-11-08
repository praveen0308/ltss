// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity(
      id: json['id'] as int?,
      name: json['name'] as String?,
      mobile_no: json['mobile_no'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      role_id: json['role_id'] as int?,
      restrictions: json['restrictions'] as String?,
      is_active: json['is_active'] as bool?,
    );

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mobile_no': instance.mobile_no,
      'email': instance.email,
      'address': instance.address,
      'restrictions': instance.restrictions,
      'role_id': instance.role_id,
      'is_active': instance.is_active,
    };
