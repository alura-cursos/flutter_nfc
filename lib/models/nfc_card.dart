import 'dart:convert';

class NfcCard {
  String id;
  String description;

  NfcCard({
    required this.id,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
    };
  }

  factory NfcCard.fromMap(Map<String, dynamic> map) {
    return NfcCard(
      id: map['id'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NfcCard.fromJson(String source) =>
      NfcCard.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'NfcCard(id: $id, description: $description)';
}
