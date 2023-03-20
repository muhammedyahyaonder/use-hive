import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_storage/model/my_models.dart';
import 'package:flutter_storage/services/secure_storage.dart';
import 'package:flutter_storage/services/shared_pref_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceKullanimi extends StatefulWidget {
  const SharedPreferenceKullanimi({super.key});

  @override
  State<SharedPreferenceKullanimi> createState() =>
      _SharedPreferenceKullanimiState();
}

class _SharedPreferenceKullanimiState extends State<SharedPreferenceKullanimi> {
  var _secilenCinsiyet = Cinsiyet.ERKEK;
  var _secilenRenkler = <String>[];
  var _ogrenciMi = false;
  final TextEditingController _nameController = TextEditingController();
  var _preferenceService = SecureStorageService();

  @override
  void initState() {
    super.initState();
    _verileriOku();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SharedPreference Kullanimi'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Adinizi giriniz'),
            ),
          ),
          for (var item in Cinsiyet.values)
            _buildRadioListTiles(describeEnum(item), item),
          for (var item in Renkler.values) _buildCheckboxListTiles(item),
          SwitchListTile(
              title: const Text('Öğrenci Misin ?'),
              value: _ogrenciMi,
              onChanged: (bool ogrenciMi) {
                setState(() {
                  _ogrenciMi = ogrenciMi;
                });
              }),
          TextButton(
              onPressed: () {
                var _userInformation = UserInformation(_nameController.text,
                    _secilenCinsiyet, _secilenRenkler, _ogrenciMi);
                _preferenceService.verileriKaydet(_userInformation);
              },
              child: const Text('Kaydet'))
        ],
      ),
    );
  }

  Widget _buildCheckboxListTiles(Renkler renk) {
    return CheckboxListTile(
        title: Text(describeEnum(renk)),
        value: _secilenRenkler.contains(describeEnum(renk)),
        onChanged: (bool? deger) {
          if (deger == false) {
            _secilenRenkler.remove(describeEnum(renk));
          } else {
            _secilenRenkler.add(describeEnum(renk));
          }
          setState(() {});
        });
  }

  Widget _buildRadioListTiles(String title, Cinsiyet cinsiyet) {
    return RadioListTile(
        title: Text(title),
        value: cinsiyet,
        groupValue: _secilenCinsiyet,
        onChanged: (Cinsiyet? secilmisCinsiyet) {
          _secilenCinsiyet = secilmisCinsiyet!;
          setState(() {
            _secilenCinsiyet = secilmisCinsiyet;
          });
        });
  }

  /*final preferences = await SharedPreferences.getInstance();
    _nameController.text = preferences.getString('isim') ?? '';
    _ogrenciMi = preferences.getBool('ogrenci') ?? false;
    _secilenCinsiyet = Cinsiyet.values[preferences.getInt('cinsiyet') ?? 0];
    final _secilenRenkler = preferences.getStringList('renkler') ?? <String>[];
    @override
  setState(() {*/

  void _verileriOku() async {
    var info = await _preferenceService.verileriOku();
    _nameController.text = info.isim;
    _secilenCinsiyet = info.cinsiyet;
    _secilenRenkler = info.renkler;
    _ogrenciMi = info.ogrenciMi;
    setState(() {

    });
  }
}
