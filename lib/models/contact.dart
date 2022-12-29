class Contact {
  int id;
  String name;
  String mobileNumber;
  String landlineNumber;
  String image;

  Contact(
      {required this.id,
      required this.name,
      required this.mobileNumber,
      required this.landlineNumber,
      required this.image});

  factory Contact.fromDatabaseJson(Map<String, dynamic> data) => Contact(
        //This will be used to convert JSON objects that
        //are coming from querying the database and converting
        //it into a Contact object
        id: data['id'],
        name: data['name'],
        mobileNumber: data['mobile_number'],
        landlineNumber: data['landline_number'],
        image: data['image'],
      );
  // Convert a contact into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toDatabaseMap() {
    return {
      'id': id,
      'name': name,
      'mobile_number': mobileNumber,
      'landline_number': landlineNumber,
      'image': image,
    };
  }

  // Implement toString to make it easier to see information about
  // each contact when using the print statement.
  @override
  String toString() {
    return 'Contact{id: $id, name: $name, mobile_number: $mobileNumber,landline_number:$landlineNumber,image:$image}';
  }
}
