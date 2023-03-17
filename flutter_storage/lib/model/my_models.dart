// ignore_for_file: constant_identifier_names

enum Cinsiyet { KADIN, ERKEK, DIGER }

enum Renkler { SARI, MAVI, YESIL, PEMBE, KIRMIZI, MOR }

class UserInformation {
  final String isim;
  final Cinsiyet cinsiyet;
  final List<String> renkler;
  final bool ogrenciMi;

  UserInformation(this.isim, this.cinsiyet, this.renkler, this.ogrenciMi);
}
