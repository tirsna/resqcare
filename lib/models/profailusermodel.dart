class profmodel {
  int? id;
  String nama;
  String email;
  String bio;
  String daerahAman;

  profmodel({
    this.id,
    required this.nama,
    required this.email,
    required this.bio,
    required this.daerahAman,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'email': email,
      'bio': bio,
      'daerahAman': daerahAman,
    };
  }

  factory profmodel.fromMap(Map<String, dynamic> map) {
    return profmodel(
      id: map['id'],
      nama: map['nama'],
      email: map['email'],
      bio: map['bio'],
      daerahAman: map['daerahAman'],
    );
  }
}
