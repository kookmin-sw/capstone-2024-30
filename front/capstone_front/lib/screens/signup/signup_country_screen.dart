import 'package:capstone_front/screens/signup/signup_service.dart';
import 'package:capstone_front/utils/basic_button.dart';
import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignupCountryScreen extends StatefulWidget {
  const SignupCountryScreen({super.key});

  @override
  State<SignupCountryScreen> createState() => _SignupCountryScreenState();
}

class _SignupCountryScreenState extends State<SignupCountryScreen> {
  String _country = tr('signup.select_country');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tr('signup.enter_country'),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              tr('signup.country'),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 5),
            InkWell(
              onTap: () {
                showCountryPicker(
                  context: context,
                  //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                  // exclude: <String>['KN', 'MF'],
                  favorite: <String>['KR', 'US', 'CN', 'JP'],
                  //Optional. Shows phone code before the country name.
                  showPhoneCode: false,
                  onSelect: (Country country) {
                    setState(() {
                      _country = country.name;
                    });
                  },
                  // Optional. Sets the theme for the country list picker.
                  countryListTheme: CountryListThemeData(
                    // Optional. Sets the border radius for the bottomsheet.
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                    // Optional. Styles the search field.
                    inputDecoration: InputDecoration(
                      labelText: 'Search',
                      hintText: 'Start typing to search',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: const Color(0xFF8C98A8).withOpacity(0.2),
                        ),
                      ),
                    ),
                    // Optional. Styles the text in the search field
                    searchTextStyle: const TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                    ),
                  ),
                );
              },
              child: Ink(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: Color(0xFFB4B9C3)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _country,
                    ),
                    const Icon(Icons.arrow_drop_down_outlined)
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            const Spacer(),
            BasicButton(
              text: tr('signup.complete_signup'),
              onPressed: () async {
                if (_country != tr('signup.select_country')) {
                  userInfo['country'] = _country;
                  print(userInfo['id']);
                  print(userInfo['pw']);
                  print(userInfo['college']);
                  print(userInfo['department']);
                  print(userInfo['country']);

                  String result = await signup();
                  switch (result) {
                    case "success":
                      context.go('/login');
                      makeToast("회원가입에 성공하였습니다");
                    default:
                      makeToast("에러: $result");
                  }
                }
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
