import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String address;
  final String type;
  final String password;
  final String token;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.type,
    required this.password,
    required this.token,
  });

  /*JSON SERIALIZATION : JSON serialization is the process of converting an object into JSON format,
  /// so it can be sent over the network or stored.
  /// And the reverse process is called deserialization.
  
  /// In our Amazon Clone:
  /// Flutter App  ⇄  Express API  ⇄  MongoDB
  
  /// Communication happens using JSON:
    /// Backend sends user data as JSON
    /// Flutter receives JSON
    /// Flutter converts JSON → Dart object
    /// Dart object used inside UI & logic
    /// Flutter cannot directly understand backend objects.
    /// It only understands Maps & JSON.
    /// 
  ///Every Flutter model should have:
    ///toMap() / toJson() → Object → JSON
    ///fromMap() / fromJson() → JSON → Object
*/

  //Convert User → Map (Serialization)
  ///This is used when:
  ///Sending data to backend
  ///Saving to local storage
  ///Logging/debugging

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'address': address,
      'type': type,
      'password': password,
      'token': token,
    };
  }

  //Convert Map → User (Deserialization)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      type: map['type'] ?? '',
      password: map['password'] ?? '',
      token: map['token'] ?? '',
    );
  }

/* ?? is called the Null-Coalescing Operator
Syntax:
value ?? fallback
Meaning:
If value is null, use fallback.
Example:
map['name'] ?? ''
Means:
If map['name'] exists → use it
If it’s missing or null → use empty string
*/

// JSON Helpers
String toJson() => json.encode(toMap());

factory User.fromJson(String source) =>
    User.fromMap(json.decode(source));

}
