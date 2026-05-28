import 'package:flutter/widgets.dart';

class AppStrings {
  const AppStrings();

  static const LocalizationsDelegate<AppStrings> delegate =
      _AppStringsDelegate();

  static const List<Locale> supportedLocales = [Locale('en')];

  static AppStrings of(BuildContext context) {
    return Localizations.of<AppStrings>(context, AppStrings) ??
        const AppStrings();
  }

  String get appTitle => 'Sumit Rai';
  String get blinkitBrand => 'blinkit';
  String get moneyTitle => 'MONEY';

  String get singleTapPaymentsTitle => 'Single tap payments';
  String get singleTapPaymentsSubtitle =>
      'Enjoy seamless payments without the wait\nfor OTPs';

  String get zeroFailuresTitle => 'Zero failures';
  String get zeroFailuresSubtitle =>
      'Zero payment failures ensure you\nnever miss an order';

  String get realTimeRefundsTitle => 'Real-time refunds';
  String get realTimeRefundsSubtitle =>
      'No need to wait for refunds. Blinkit\nMoney refunds are instant!';

  String get addMoney => 'Add Money';
  String get claimGiftCard => 'Claim Gift Card';
  String get claimGiftCardSubtitle =>
      'Enter gift card details to claim your gift card';
  String get bottomPaymentText => 'Enjoy seamless\none tap payments';
}

class _AppStringsDelegate extends LocalizationsDelegate<AppStrings> {
  const _AppStringsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'en';

  @override
  Future<AppStrings> load(Locale locale) async => const AppStrings();

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppStrings> old) => false;
}
