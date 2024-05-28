import 'package:flutter/material.dart';
import 'package:finance_mobile/src/constants/text_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RememberMe extends StatefulWidget {
  @override
  State<RememberMe> createState() => _RememberMeState();
}

class _RememberMeState extends State<RememberMe> {
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    super.setState(() {
      _loadRememberMePreference();
    });
  }

  Future<void> _loadRememberMePreference() async {
    final prefs = await SharedPreferences.getInstance();
    bool rememberMe = prefs.getBool('rememberMe') ?? false;
    String? userEmail = prefs.getString('userEmail');

    if (rememberMe && userEmail != null) {
      return;
    }
  }

  Future<void> _saveRememberMePreference(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('rememberMe', value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.0,
      child: Row(
        children: [
          Theme(
            data: ThemeData(
              unselectedWidgetColor: Colors.white,
            ),
            child: Checkbox(
              value: _isChecked,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _isChecked = value!;
                });
                _saveRememberMePreference(_isChecked);
              },
            ),
          ),
          Text('Lembre-me', style: kTextLabel),
        ],
      ),
    );
  }
}
