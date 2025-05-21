import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/colors/main_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/login_page.dart';
import '../widgets/unified_appbar.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../data/user_profile.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late UserProfile _profile;
  final _formKey = GlobalKey<FormState>();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('user_profile_admin');
    setState(() {
      _profile = raw != null ? UserProfile.fromRawJson(raw) : UserProfile.empty();
      _loading = false;
    });
  }

  Future<void> _saveProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_profile_admin', _profile.toRawJson());
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Профиль сохранён!'), backgroundColor: Colors.green));
  }

  Future<void> _pickPhoto() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (picked != null) {
      final dir = await getApplicationDocumentsDirectory();
      final file = await File(picked.path).copy('${dir.path}/profile_photo_admin.png');
      setState(() {
        _profile.photoPath = file.path;
      });
      await _saveProfile();
    }
  }

  Future<void> _deletePhoto() async {
    if (_profile.photoPath != null) {
      final file = File(_profile.photoPath!);
      if (await file.exists()) {
        await file.delete();
      }
    }
    setState(() {
      _profile.photoPath = null;
    });
    await _saveProfile();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        backgroundColor: primaryLightColor,
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      backgroundColor: primaryLightColor,
      appBar: const UnifiedAppBar(title: 'Gift Portal'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Блок с аватаром и кнопками
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.07),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 38,
                        backgroundColor: ironManMetal.withOpacity(0.2),
                        backgroundImage: _profile.photoPath != null ? FileImage(File(_profile.photoPath!)) : null,
                        child: _profile.photoPath == null ? const Icon(Icons.person, size: 48, color: ironManMetal) : null,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: _pickPhoto,
                            icon: const Icon(Icons.upload, color: ironManRed),
                            label: const Text('Загрузить'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: accentGoldColor,
                              foregroundColor: ironManRed,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton.icon(
                            onPressed: _deletePhoto,
                            icon: const Icon(Icons.delete, color: ironManRed),
                            label: const Text('Удалить'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ironManMetal,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Блок с личной информацией
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.07),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Личная информация',
                          style: GoogleFonts.merriweather(
                            textStyle: const TextStyle(
                              fontSize: 18,
                              color: ironManRed,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                      const SizedBox(height: 16),
                      TextFormField(
                        initialValue: _profile.firstName,
                        decoration: InputDecoration(
                          labelText: 'Имя',
                          filled: true,
                          fillColor: ironManMetal.withOpacity(0.08),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: accentBlueColor, width: 2),
                          ),
                        ),
                        onChanged: (v) => _profile.firstName = v,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        initialValue: _profile.lastName,
                        decoration: InputDecoration(
                          labelText: 'Фамилия',
                          filled: true,
                          fillColor: ironManMetal.withOpacity(0.08),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: accentBlueColor, width: 2),
                          ),
                        ),
                        onChanged: (v) => _profile.lastName = v,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: _profile.gender.isNotEmpty ? _profile.gender : null,
                              decoration: InputDecoration(
                                labelText: 'Пол',
                                filled: true,
                                fillColor: ironManMetal.withOpacity(0.08),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(color: accentBlueColor, width: 2),
                                ),
                              ),
                              items: const [
                                DropdownMenuItem(value: 'Мужской', child: Text('Мужской')),
                                DropdownMenuItem(value: 'Женский', child: Text('Женский')),
                              ],
                              onChanged: (value) => setState(() => _profile.gender = value ?? ''),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextFormField(
                              readOnly: true,
                              controller: TextEditingController(text: _profile.birthday),
                              decoration: InputDecoration(
                                labelText: 'День рождения',
                                filled: true,
                                fillColor: ironManMetal.withOpacity(0.08),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(color: accentBlueColor, width: 2),
                                ),
                              ),
                              onTap: () async {
                                final picked = await showDatePicker(
                                  context: context,
                                  initialDate: _profile.birthday.isNotEmpty ? DateTime.tryParse(_profile.birthday) ?? DateTime(2000) : DateTime(2000),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );
                                if (picked != null) {
                                  setState(() => _profile.birthday = picked.toIso8601String().split('T').first);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _saveProfile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: accentGoldColor,
                            foregroundColor: ironManRed,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 3,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            child: Text('Сохранить изменения', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Кнопка выхода
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('is_logged_in', false);
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentBlueColor,
                      foregroundColor: accentLightColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 3,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Text('Выйти', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: accentLightColor,
        unselectedItemColor: ironManMetal,
        currentIndex: 2,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
        onTap: (index) {},
      ),
    );
  }
}
