import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'l10n/messages_all.dart';

class AppLocalizations {
  AppLocalizations(this.localeName);

  static Future<AppLocalizations> load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      return AppLocalizations(localeName);
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  final String localeName;

  String get title {
    return Intl.message(
      'Flutter Demo',
      name: 'title',
      desc: 'Title for the application',
      locale: localeName,
    );
  }

  String get verificationCodeLogin {
    return Intl.message('Verification Code Login',
        name: 'verificationCodeLogin', desc: 'Title for the Login page', locale: localeName);
  }

  String get passwordLogin {
    return Intl.message('Password Login', name: 'passwordLogin', desc: 'Password Login', locale: localeName);
  }

  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: 'Login',
      locale: localeName,
    );
  }

  String get forgotPasswordLink {
    return Intl.message('Forgot Password', name: 'forgotPasswordLink', desc: 'Forgot Password', locale: localeName);
  }

  String get inputPasswordHint {
    return Intl.message('Please enter the password',
        name: 'inputPasswordHint', desc: 'Please enter the password', locale: localeName);
  }

  String get inputUsernameHint {
    return Intl.message('Please input username',
        name: 'inputUsernameHint', desc: 'Please input username', locale: localeName);
  }

  String get noAccountRegisterLink {
    return Intl.message('No account yet? Register now',
        name: 'noAccountRegisterLink', desc: 'No account yet? Register now', locale: localeName);
  }

  String get register {
    return Intl.message('Register', name: 'register', desc: 'Register', locale: localeName);
  }

  String get openYourAccount {
    return Intl.message('Open your account', // 开启你的账号
        name: 'openYourAccount',
        desc: 'Open your account',
        locale: localeName);
  }

  String get inputPhoneHint {
    return Intl.message('Please enter phone number', // 请输入手机号
        name: 'inputPhoneHint',
        desc: 'Please enter phone number',
        locale: localeName);
  }

  String get inputVerificationCodeHint {
    return Intl.message('Please enter verification code', // 请输入验证码
        name: 'inputVerificationCodeHint',
        desc: 'Please enter verification code',
        locale: localeName);
  }

  String get inputPhoneInvalid {
    return Intl.message('Please input valid mobile phone number', // 请输入有效的手机号
        name: 'inputPhoneInvalid',
        desc: 'Please input valid mobile phone number',
        locale: localeName);
  }

  String get verificationButton {
    return Intl.message(
      'Not really sent, just log in!', // 并没有真正发送哦，直接登录吧！
      name: 'verificationButton',
      desc: 'Not really sent, just log in!',
      locale: localeName,
    );
  }

  String get getVerificationCode {
    return Intl.message(
      'Get verification code', // 获取验证码
      name: 'getVerificationCode',
      desc: 'Get verification code',
      locale: localeName,
    );
  }

  String get resetLoginPassword {
    return Intl.message(
      'Reset Login Password', // 获取验证码
      name: 'resetLoginPassword',
      desc: 'Reset login password',
      locale: localeName,
    );
  }

  //Note: Unregistered mobile phone number, please
  String get registeredTips {
    return Intl.message('Unregistered mobile phone number, please ',
        name: 'registeredTips', desc: 'Registered Tips', locale: localeName);
  }

  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      locale: localeName,
    );
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  //是否支持某个Local
  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  // Flutter会调用此类加载相应的Locale资源类
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  // 当Localizations Widget重新build时，是否调用load重新加载Locale资源
  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
