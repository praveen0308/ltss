enum UserRole {
  admin(roleId: 2, name: "Admin"),
  distributor(roleId: 3, name: "Distributor"),
  retailer(roleId: 4, name: "Retailer"),
  vendor(roleId: 5, name: "Vendor"),
  customer(roleId: 6, name: "Customer");

  final int roleId;
  final String name;

  const UserRole({required this.roleId, required this.name});


  @override
  String toString() => name;

  static String? getUserRoleName(int? roleId){
    for(var type in UserRole.values){
      if(type.roleId==roleId){
        return type.name;
      }
    }
    return null;
  }

  static UserRole? getUserRole(int? roleId){
    for(var type in UserRole.values){
      if(type.roleId==roleId){
        return type;
      }
    }
    return null;
  }
}

