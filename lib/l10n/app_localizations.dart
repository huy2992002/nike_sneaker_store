import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi')
  ];

  /// No description provided for @welcomeTo.
  ///
  /// In en, this message translates to:
  /// **'Welcome To \nNike'**
  String get welcomeTo;

  /// No description provided for @letStartJourney.
  ///
  /// In en, this message translates to:
  /// **'Let’s Start Journey \nWith Nike'**
  String get letStartJourney;

  /// No description provided for @smartGorgeousFashionable.
  ///
  /// In en, this message translates to:
  /// **'Smart, Gorgeous & Fashionable \nCollection Explore Now'**
  String get smartGorgeousFashionable;

  /// No description provided for @youHavePowerTo.
  ///
  /// In en, this message translates to:
  /// **'You Have the \nPower To'**
  String get youHavePowerTo;

  /// No description provided for @thereAreManyBeautifulAttractive.
  ///
  /// In en, this message translates to:
  /// **'There Are Many Beautiful And Attractive \nPlants To Your Room'**
  String get thereAreManyBeautifulAttractive;

  /// No description provided for @helloAgain.
  ///
  /// In en, this message translates to:
  /// **'Hello Again!'**
  String get helloAgain;

  /// No description provided for @fillYourDetails.
  ///
  /// In en, this message translates to:
  /// **'Fill Your Details'**
  String get fillYourDetails;

  /// No description provided for @registerAccount.
  ///
  /// In en, this message translates to:
  /// **'Register Account'**
  String get registerAccount;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @yourName.
  ///
  /// In en, this message translates to:
  /// **'Your Name'**
  String get yourName;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// No description provided for @newUser.
  ///
  /// In en, this message translates to:
  /// **'New User? '**
  String get newUser;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @recoveryPassword.
  ///
  /// In en, this message translates to:
  /// **'Recovery Password'**
  String get recoveryPassword;

  /// No description provided for @alreadyAccount.
  ///
  /// In en, this message translates to:
  /// **'Already Have Account? '**
  String get alreadyAccount;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPassword;

  /// No description provided for @enterEmailResetPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Email Account To Reset \nYour Password'**
  String get enterEmailResetPassword;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @checkYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Check Your Email'**
  String get checkYourEmail;

  /// No description provided for @weHaveSendRecoveryCode.
  ///
  /// In en, this message translates to:
  /// **'We Have Send Password Recovery Code In Your Email'**
  String get weHaveSendRecoveryCode;

  /// No description provided for @otpVerification.
  ///
  /// In en, this message translates to:
  /// **'OTP Verification'**
  String get otpVerification;

  /// No description provided for @pleaseCheckYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Please Check Your Email To See The Verification Code'**
  String get pleaseCheckYourEmail;

  /// No description provided for @otpCode.
  ///
  /// In en, this message translates to:
  /// **'OTP Code'**
  String get otpCode;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend code to'**
  String get resendCode;

  /// No description provided for @explore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get explore;

  /// No description provided for @lookingForShoes.
  ///
  /// In en, this message translates to:
  /// **'Looking for shoes'**
  String get lookingForShoes;

  /// No description provided for @selectCategory.
  ///
  /// In en, this message translates to:
  /// **'Select Category'**
  String get selectCategory;

  /// No description provided for @allShoes.
  ///
  /// In en, this message translates to:
  /// **'All Shoes'**
  String get allShoes;

  /// No description provided for @outDoor.
  ///
  /// In en, this message translates to:
  /// **'Outdoor'**
  String get outDoor;

  /// No description provided for @tennis.
  ///
  /// In en, this message translates to:
  /// **'Tennis'**
  String get tennis;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @fieldIsRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldIsRequired;

  /// No description provided for @passwordLeast6.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 digits long'**
  String get passwordLeast6;

  /// No description provided for @validEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get validEmailAddress;

  /// No description provided for @validPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid phone number'**
  String get validPhoneNumber;

  /// No description provided for @confirmPasswordNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Confirm password is not match'**
  String get confirmPasswordNotMatch;

  /// No description provided for @emailOrPasswordIncorrect.
  ///
  /// In en, this message translates to:
  /// **'Email or password is incorrect'**
  String get emailOrPasswordIncorrect;

  /// No description provided for @emailAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'Email already exists'**
  String get emailAlreadyExists;

  /// No description provided for @hintTextEmail.
  ///
  /// In en, this message translates to:
  /// **'xyz@gmail.com'**
  String get hintTextEmail;

  /// No description provided for @hintTextPassword.
  ///
  /// In en, this message translates to:
  /// **'••••••••'**
  String get hintTextPassword;

  /// No description provided for @hintTextDefault.
  ///
  /// In en, this message translates to:
  /// **'xxxxxxxx'**
  String get hintTextDefault;

  /// No description provided for @nameNikeJordan.
  ///
  /// In en, this message translates to:
  /// **'Nike Jordan'**
  String get nameNikeJordan;

  /// No description provided for @descriptionNikeJordan.
  ///
  /// In en, this message translates to:
  /// **'The Nike Air Jordan 1 Retro High stands as an unmistakable icon in the sneaker world. Originating from the collaboration between Nike and Michael Jordan, this silhouette has transcended its basketball roots to become a staple in fashion, culture, and lifestyle.'**
  String get descriptionNikeJordan;

  /// No description provided for @nameNikeAirMax.
  ///
  /// In en, this message translates to:
  /// **'Nike Air Max'**
  String get nameNikeAirMax;

  /// No description provided for @descriptionNikeAirMax.
  ///
  /// In en, this message translates to:
  /// **'The Nike Air Max 90 is an iconic sneaker that revolutionized the world of athletic footwear. With its distinctive design and pioneering air cushioning technology, this shoe has captivated sneaker enthusiasts, athletes, and fashion-forward individuals for decades.'**
  String get descriptionNikeAirMax;

  /// No description provided for @nameNikeAirMax200.
  ///
  /// In en, this message translates to:
  /// **'Nike Air Max 200'**
  String get nameNikeAirMax200;

  /// No description provided for @descriptionNikeAirMax200.
  ///
  /// In en, this message translates to:
  /// **'The Nike Air Max 200 is a modern twist on the classic Air Max legacy, offering a bold, refreshed look while retaining the comfort and performance that fans have come to expect from the Air Max series.'**
  String get descriptionNikeAirMax200;

  /// No description provided for @nameNikeAirMax270.
  ///
  /// In en, this message translates to:
  /// **'Nike Air Max 270'**
  String get nameNikeAirMax270;

  /// No description provided for @descriptionNikeAirMax270.
  ///
  /// In en, this message translates to:
  /// **'The Nike Air Max 270 represents a significant milestone in the evolution of the Air Max family, blending classic style with modern technology to create a sneaker that\'s visually striking and supremely comfortable. Designed to support lifestyle wear rather than sports performance, the Air Max 270 draws inspiration from the Air Max lineage, showcasing Nike\'s biggest heel Air unit yet.'**
  String get descriptionNikeAirMax270;

  /// No description provided for @nameNikeClubMax.
  ///
  /// In en, this message translates to:
  /// **'Nike Club Max'**
  String get nameNikeClubMax;

  /// No description provided for @descriptionNikeClubMax.
  ///
  /// In en, this message translates to:
  /// **'The Nike Club Max represents a significant milestone in the evolution of the Air Max family, blending classic style with modern technology to create a sneaker that\'s visually striking and supremely comfortable. Designed to support lifestyle wear rather than sports performance, the Air Max 270 draws inspiration from the Air Max lineage, showcasing Nike\'s biggest heel Air unit yet.'**
  String get descriptionNikeClubMax;

  /// No description provided for @popularShoes.
  ///
  /// In en, this message translates to:
  /// **'Popular Shoes'**
  String get popularShoes;

  /// No description provided for @newArrivals.
  ///
  /// In en, this message translates to:
  /// **'New Arrivals'**
  String get newArrivals;

  /// No description provided for @summerSale.
  ///
  /// In en, this message translates to:
  /// **'Summer Sale'**
  String get summerSale;

  /// No description provided for @readMore.
  ///
  /// In en, this message translates to:
  /// **'Read More'**
  String get readMore;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get addToCart;

  /// No description provided for @favorite.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get favorite;

  /// No description provided for @myCart.
  ///
  /// In en, this message translates to:
  /// **'My Cart'**
  String get myCart;

  /// No description provided for @bestSeller.
  ///
  /// In en, this message translates to:
  /// **'Best Seller'**
  String get bestSeller;

  /// No description provided for @subTotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subTotal;

  /// No description provided for @delivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get delivery;

  /// No description provided for @totalCost.
  ///
  /// In en, this message translates to:
  /// **'Total Cost'**
  String get totalCost;

  /// No description provided for @checkOut.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkOut;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @contactInformation.
  ///
  /// In en, this message translates to:
  /// **'Contact Information'**
  String get contactInformation;

  /// No description provided for @yourPaymentSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Your Payment Is Successful'**
  String get yourPaymentSuccessful;

  /// No description provided for @backToShopping.
  ///
  /// In en, this message translates to:
  /// **'Back To Shopping'**
  String get backToShopping;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @recent.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get recent;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @productAlreadyInCart.
  ///
  /// In en, this message translates to:
  /// **'The product is already in the cart'**
  String get productAlreadyInCart;

  /// No description provided for @productAddSuccess.
  ///
  /// In en, this message translates to:
  /// **'The product has been added successfully'**
  String get productAddSuccess;

  /// No description provided for @cartEmpty.
  ///
  /// In en, this message translates to:
  /// **'There are no products in the cart yet'**
  String get cartEmpty;

  /// No description provided for @searchProduct.
  ///
  /// In en, this message translates to:
  /// **'Search product'**
  String get searchProduct;

  /// No description provided for @isNoResult.
  ///
  /// In en, this message translates to:
  /// **'There is no result'**
  String get isNoResult;

  /// No description provided for @noFavoriteProduct.
  ///
  /// In en, this message translates to:
  /// **'Currently there are no favorite products'**
  String get noFavoriteProduct;

  /// No description provided for @noFavoriteNotification.
  ///
  /// In en, this message translates to:
  /// **'Currently there are no notification'**
  String get noFavoriteNotification;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @changeProfilePicture.
  ///
  /// In en, this message translates to:
  /// **'Change Profile Picture'**
  String get changeProfilePicture;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @mobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobileNumber;

  /// No description provided for @saveNow.
  ///
  /// In en, this message translates to:
  /// **'Save Now'**
  String get saveNow;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @informationChangedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Information changed successfully'**
  String get informationChangedSuccess;

  /// No description provided for @avatarChangedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Avatar changed successfully'**
  String get avatarChangedSuccess;

  /// No description provided for @passwordChangedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully'**
  String get passwordChangedSuccess;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @currentPasswordIncorrect.
  ///
  /// In en, this message translates to:
  /// **'Current password is incorrect'**
  String get currentPasswordIncorrect;

  /// No description provided for @setting.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get setting;

  /// No description provided for @changeTheme.
  ///
  /// In en, this message translates to:
  /// **'Change Theme'**
  String get changeTheme;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @doYouWantLogout.
  ///
  /// In en, this message translates to:
  /// **'Do you want to log out?'**
  String get doYouWantLogout;

  /// No description provided for @doYouWantRemoveFromCart.
  ///
  /// In en, this message translates to:
  /// **'Do you want to remove the product from the cart?'**
  String get doYouWantRemoveFromCart;

  /// No description provided for @confirmInYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Please confirm registration in your email'**
  String get confirmInYourEmail;

  /// No description provided for @goToEmail.
  ///
  /// In en, this message translates to:
  /// **'Go to email'**
  String get goToEmail;

  /// No description provided for @goToSignIn.
  ///
  /// In en, this message translates to:
  /// **'Go to sign in'**
  String get goToSignIn;

  /// No description provided for @couldNotLaunchGmail.
  ///
  /// In en, this message translates to:
  /// **'Could not launch gmail'**
  String get couldNotLaunchGmail;

  /// No description provided for @notFoundUser.
  ///
  /// In en, this message translates to:
  /// **'Login version has expired, please log in again'**
  String get notFoundUser;

  /// No description provided for @productHaveBeenRemove.
  ///
  /// In en, this message translates to:
  /// **'Product has been removed from the cart'**
  String get productHaveBeenRemove;

  /// No description provided for @selectImageSuccess.
  ///
  /// In en, this message translates to:
  /// **'Select image failed'**
  String get selectImageSuccess;

  /// No description provided for @cancelError.
  ///
  /// In en, this message translates to:
  /// **'Request was cancelled. Please try again.'**
  String get cancelError;

  /// No description provided for @connectionTimeOutError.
  ///
  /// In en, this message translates to:
  /// **'Connection timeout. Please check your internet connection.'**
  String get connectionTimeOutError;

  /// No description provided for @receiveTimeoutError.
  ///
  /// In en, this message translates to:
  /// **'Receive timeout. Please try again later.'**
  String get receiveTimeoutError;

  /// No description provided for @badResponseError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load data. Please try again later.'**
  String get badResponseError;

  /// No description provided for @sendTimeOutError.
  ///
  /// In en, this message translates to:
  /// **'Send timeout. Please try again later.'**
  String get sendTimeOutError;

  /// No description provided for @defaultError.
  ///
  /// In en, this message translates to:
  /// **'Unknown error occurred. Please try again later.'**
  String get defaultError;

  /// No description provided for @connectionError.
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Please check your network settings.'**
  String get connectionError;

  /// No description provided for @productNotFound.
  ///
  /// In en, this message translates to:
  /// **'Product not found'**
  String get productNotFound;

  /// No description provided for @emailNotConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Email not confirmed'**
  String get emailNotConfirmed;

  /// No description provided for @invalidLoginCredentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid login credentials'**
  String get invalidLoginCredentials;

  /// No description provided for @userAlreadyRegistered.
  ///
  /// In en, this message translates to:
  /// **'User already registered'**
  String get userAlreadyRegistered;

  /// No description provided for @dontFindUser.
  ///
  /// In en, this message translates to:
  /// **'Dont find User'**
  String get dontFindUser;

  /// No description provided for @doYouWantCancelFavorite.
  ///
  /// In en, this message translates to:
  /// **'Do you want to cancel your favorite?'**
  String get doYouWantCancelFavorite;

  /// No description provided for @discountOff.
  ///
  /// In en, this message translates to:
  /// **'{discount}% OFF'**
  String discountOff(int discount);

  /// No description provided for @intItem.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No items} =1{1 item} other{{count} items}}'**
  String intItem(num count);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'vi': return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
