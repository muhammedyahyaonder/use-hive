import 'package:flutter_storage/model/my_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  Future<void> verileriKaydet(UserInformation userInformation) async {
    final name = userInformation.isim;
    final preferences = await SharedPreferences.getInstance();

    preferences.setString('isim', name);
    preferences.setBool('ogrenci', userInformation.ogrenciMi);
    preferences.setInt('cinsiyet', userInformation.cinsiyet.index);
    preferences.setStringList('renkler', userInformation.renkler);
   
  }

  /*void verileriOku() async {
    final preferences = await SharedPreferences.getInstance();
    userInformation= preferences.getString('isim') ?? '';
    _ogrenciMi = preferences.getBool('ogrenci') ?? false;
    _secilenCinsiyet = Cinsiyet.valuess[preferences.getInt('cinsiyet') ?? 0];
    _secilenRenkler = preferences.getStringList('renkler') ?? <String>[];
    setState(() {});
  }
}
