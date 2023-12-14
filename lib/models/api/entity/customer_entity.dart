class CustomerEntity{
  final String? firstName;
  final String? lastName;
  final String? mobileNumber;

  CustomerEntity(this.firstName, this.lastName, this.mobileNumber);


  String fullName(){
    return "$firstName $lastName";
  }
}