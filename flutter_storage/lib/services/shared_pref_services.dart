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

  Future<UserInformation> verileriOku() async {
    final preferences = await SharedPreferences.getInstance();
    var _isim = preferences.getString('isim') ?? '';
    var _ogrenci = preferences.getBool('ogrenci') ?? false;
    var _cinsiyet = Cinsiyet.values[preferences.getInt('cinsiyet') ?? 0];
    var _renkler = preferences.getStringList('renkler') ?? <String>[];
    return UserInformation(_isim, _cinsiyet, _renkler, _ogrenci);
  }
}
