import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_am.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
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
    Locale('am'),
    Locale('en'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Adisu'**
  String get appTitle;

  /// Welcome message
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// Login button text
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Logout button text
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// Register button text
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// Email label
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Password label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Confirm password label
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// First name label
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// Last name label
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// Phone label
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// Forgot password text
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// Sign up prompt
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// Login prompt
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// Sign up action
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// Sign in action
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// Profile menu item
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// Settings menu item
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Home menu item
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Search label
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// Search hint text
  ///
  /// In en, this message translates to:
  /// **'Search...'**
  String get searchHint;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Save button text
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Delete button text
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Edit button text
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// Done button text
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// Next button text
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// Back button text
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// Continue button text
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// Submit button text
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// Retry button text
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Close button text
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// Yes button text
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No button text
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// OK button text
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// Loading text
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Please wait text
  ///
  /// In en, this message translates to:
  /// **'Please wait...'**
  String get pleaseWait;

  /// Error title
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// Success title
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// Warning title
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// Information title
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get info;

  /// Network error message
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get errorNetwork;

  /// Server error message
  ///
  /// In en, this message translates to:
  /// **'Server error. Please try again later'**
  String get errorServer;

  /// Unknown error message
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorUnknown;

  /// Timeout error message
  ///
  /// In en, this message translates to:
  /// **'Request timed out. Please try again'**
  String get errorTimeout;

  /// Unauthorized error message
  ///
  /// In en, this message translates to:
  /// **'Session expired. Please login again'**
  String get errorUnauthorized;

  /// Validation error message
  ///
  /// In en, this message translates to:
  /// **'Please check your input'**
  String get errorValidation;

  /// Delete confirmation message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete?'**
  String get confirmDelete;

  /// Logout confirmation message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get confirmLogout;

  /// Confirm button text
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No data message
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get noData;

  /// No results message
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResults;

  /// Pull to refresh hint
  ///
  /// In en, this message translates to:
  /// **'Pull to refresh'**
  String get pullToRefresh;

  /// Loading more text
  ///
  /// In en, this message translates to:
  /// **'Loading more...'**
  String get loadingMore;

  /// All filter option
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// None option
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get none;

  /// Select action
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// Selected label
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get selected;

  /// Required field error
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get required;

  /// Invalid email error
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get invalidEmail;

  /// Invalid phone error
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number'**
  String get invalidPhone;

  /// Password too short error
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordTooShort;

  /// Password mismatch error
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordMismatch;

  /// Field required error
  ///
  /// In en, this message translates to:
  /// **'{fieldName} is required'**
  String fieldRequired(String fieldName);

  /// Items count message
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No items} =1{1 item} other{{count} items}}'**
  String itemsCount(int count);

  /// Days ago message
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 day ago} other{{count} days ago}}'**
  String daysAgo(int count);

  /// Hours ago message
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 hour ago} other{{count} hours ago}}'**
  String hoursAgo(int count);

  /// Minutes ago message
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 minute ago} other{{count} minutes ago}}'**
  String minutesAgo(int count);

  /// Just now text
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get justNow;

  /// Today text
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// Yesterday text
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// This week text
  ///
  /// In en, this message translates to:
  /// **'This week'**
  String get thisWeek;

  /// Language setting
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Theme setting
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// Dark mode setting
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// Light mode setting
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// System default setting
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get systemDefault;

  /// About menu item
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// Version label
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// Privacy policy link
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// Terms of service link
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// Contact support text
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get contactSupport;

  /// Rate app text
  ///
  /// In en, this message translates to:
  /// **'Rate App'**
  String get rateApp;

  /// Share app text
  ///
  /// In en, this message translates to:
  /// **'Share App'**
  String get shareApp;

  /// Finish button text
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// Onboarding title
  ///
  /// In en, this message translates to:
  /// **'Community Setup'**
  String get onboardingTitle;

  /// Language pill label
  ///
  /// In en, this message translates to:
  /// **'Eng'**
  String get onboardingLanguageLabel;

  /// Onboarding step label
  ///
  /// In en, this message translates to:
  /// **'Step {current} of {total}'**
  String onboardingStepLabel(int current, int total);

  /// Onboarding progress label
  ///
  /// In en, this message translates to:
  /// **'{percent}% Complete'**
  String onboardingProgress(int percent);

  /// Onboarding geography question
  ///
  /// In en, this message translates to:
  /// **'Where is your business primarily located?'**
  String get onboardingRegionTitle;

  /// Onboarding geography subtitle
  ///
  /// In en, this message translates to:
  /// **'We use your region to surface relevant local guidance.'**
  String get onboardingRegionSubtitle;

  /// Region option
  ///
  /// In en, this message translates to:
  /// **'Addis Ababa'**
  String get onboardingRegionAddis;

  /// Region option
  ///
  /// In en, this message translates to:
  /// **'Oromia'**
  String get onboardingRegionOromia;

  /// Region option
  ///
  /// In en, this message translates to:
  /// **'Amhara'**
  String get onboardingRegionAmhara;

  /// Region option
  ///
  /// In en, this message translates to:
  /// **'Tigray'**
  String get onboardingRegionTigray;

  /// Region option
  ///
  /// In en, this message translates to:
  /// **'Sidama'**
  String get onboardingRegionSidama;

  /// Region option
  ///
  /// In en, this message translates to:
  /// **'South West'**
  String get onboardingRegionSouthWest;

  /// Region option
  ///
  /// In en, this message translates to:
  /// **'Southern'**
  String get onboardingRegionSouthern;

  /// Region option
  ///
  /// In en, this message translates to:
  /// **'Somali'**
  String get onboardingRegionSomali;

  /// Region option
  ///
  /// In en, this message translates to:
  /// **'Afar'**
  String get onboardingRegionAfar;

  /// Region option
  ///
  /// In en, this message translates to:
  /// **'Benishangul-Gumuz'**
  String get onboardingRegionBenishangul;

  /// Region option
  ///
  /// In en, this message translates to:
  /// **'Gambella'**
  String get onboardingRegionGambella;

  /// Region option
  ///
  /// In en, this message translates to:
  /// **'Harari'**
  String get onboardingRegionHarari;

  /// Region option
  ///
  /// In en, this message translates to:
  /// **'Dire Dawa'**
  String get onboardingRegionDireDawa;

  /// Onboarding lifecycle question
  ///
  /// In en, this message translates to:
  /// **'What stage is your business currently in?'**
  String get onboardingLifecycleTitle;

  /// Onboarding lifecycle subtitle
  ///
  /// In en, this message translates to:
  /// **'This helps us tailor advice for your current needs.'**
  String get onboardingLifecycleSubtitle;

  /// Lifecycle option
  ///
  /// In en, this message translates to:
  /// **'Just an Idea'**
  String get onboardingLifecycleIdea;

  /// Lifecycle option
  ///
  /// In en, this message translates to:
  /// **'Currently Registering'**
  String get onboardingLifecycleRegistration;

  /// Lifecycle option
  ///
  /// In en, this message translates to:
  /// **'Operational'**
  String get onboardingLifecycleOperational;

  /// Lifecycle option
  ///
  /// In en, this message translates to:
  /// **'Scaling/Expanding'**
  String get onboardingLifecycleScaling;

  /// Onboarding industry question
  ///
  /// In en, this message translates to:
  /// **'What is your main industry?'**
  String get onboardingIndustryTitle;

  /// Onboarding industry subtitle
  ///
  /// In en, this message translates to:
  /// **'Pick the sector that best matches your business.'**
  String get onboardingIndustrySubtitle;

  /// Industry option
  ///
  /// In en, this message translates to:
  /// **'Trade'**
  String get onboardingIndustryTrade;

  /// Industry option
  ///
  /// In en, this message translates to:
  /// **'Manufacturing'**
  String get onboardingIndustryManufacturing;

  /// Industry option
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get onboardingIndustryServices;

  /// Industry option
  ///
  /// In en, this message translates to:
  /// **'Agriculture'**
  String get onboardingIndustryAgriculture;

  /// Industry option
  ///
  /// In en, this message translates to:
  /// **'Construction'**
  String get onboardingIndustryConstruction;

  /// Onboarding legal question
  ///
  /// In en, this message translates to:
  /// **'How is your business legally structured?'**
  String get onboardingLegalTitle;

  /// Onboarding legal subtitle
  ///
  /// In en, this message translates to:
  /// **'If you are planning, choose the structure you expect.'**
  String get onboardingLegalSubtitle;

  /// Legal option
  ///
  /// In en, this message translates to:
  /// **'Sole Proprietor'**
  String get onboardingLegalSoleProprietor;

  /// Legal option
  ///
  /// In en, this message translates to:
  /// **'Private Limited Company'**
  String get onboardingLegalPlc;

  /// Legal option
  ///
  /// In en, this message translates to:
  /// **'Share Company'**
  String get onboardingLegalShareCompany;

  /// Legal option
  ///
  /// In en, this message translates to:
  /// **'Partnership'**
  String get onboardingLegalPartnership;

  /// Legal option
  ///
  /// In en, this message translates to:
  /// **'Cooperative'**
  String get onboardingLegalCooperative;

  /// Onboarding tax question
  ///
  /// In en, this message translates to:
  /// **'What is your tax registration status?'**
  String get onboardingTaxTitle;

  /// Tax option
  ///
  /// In en, this message translates to:
  /// **'VAT Payer (>2M ETB)'**
  String get onboardingTaxVat;

  /// Tax option
  ///
  /// In en, this message translates to:
  /// **'TOT Payer (<2M ETB)'**
  String get onboardingTaxTot;

  /// Tax option
  ///
  /// In en, this message translates to:
  /// **'Excise Tax Payer'**
  String get onboardingTaxExcise;

  /// Tax option
  ///
  /// In en, this message translates to:
  /// **'Tax Exempt'**
  String get onboardingTaxExempt;

  /// Onboarding operations question
  ///
  /// In en, this message translates to:
  /// **'What activities will your business do?'**
  String get onboardingOpsTitle;

  /// Onboarding operations subtitle
  ///
  /// In en, this message translates to:
  /// **'Check all that apply.'**
  String get onboardingOpsSubtitle;

  /// Operations option
  ///
  /// In en, this message translates to:
  /// **'I import goods'**
  String get onboardingOpsImporter;

  /// Operations option
  ///
  /// In en, this message translates to:
  /// **'I export goods'**
  String get onboardingOpsExporter;

  /// Operations option
  ///
  /// In en, this message translates to:
  /// **'I supply to Gov or NGOs'**
  String get onboardingOpsTender;

  /// Operations option
  ///
  /// In en, this message translates to:
  /// **'I handle food or beverages'**
  String get onboardingOpsFoodHandling;

  /// Operations option
  ///
  /// In en, this message translates to:
  /// **'I operate commercial vehicles'**
  String get onboardingOpsVehicles;

  /// Operations option
  ///
  /// In en, this message translates to:
  /// **'I use hazardous chemicals'**
  String get onboardingOpsHazardous;

  /// Operations option
  ///
  /// In en, this message translates to:
  /// **'I sell online (E-commerce)'**
  String get onboardingOpsEcommerce;

  /// Operations option
  ///
  /// In en, this message translates to:
  /// **'I operate from my home'**
  String get onboardingOpsHomeBased;

  /// Operations option
  ///
  /// In en, this message translates to:
  /// **'I have official salaried employees'**
  String get onboardingOpsEmployees;

  /// Onboarding demographics question
  ///
  /// In en, this message translates to:
  /// **'Tell us a bit more about the founders'**
  String get onboardingDemoTitle;

  /// Onboarding demographics subtitle
  ///
  /// In en, this message translates to:
  /// **'Unlock specific grants and guides. Optional.'**
  String get onboardingDemoSubtitle;

  /// Demographics option
  ///
  /// In en, this message translates to:
  /// **'Women-Owned'**
  String get onboardingDemoWomenOwned;

  /// Demographics option
  ///
  /// In en, this message translates to:
  /// **'Youth Enterprise (18-35)'**
  String get onboardingDemoYouth;

  /// Demographics option
  ///
  /// In en, this message translates to:
  /// **'Diaspora/Foreign Investor'**
  String get onboardingDemoInvestor;

  /// Demographics optional helper text
  ///
  /// In en, this message translates to:
  /// **'You can skip this step if you prefer.'**
  String get onboardingDemoOptional;

  /// AI Guide chat page title
  ///
  /// In en, this message translates to:
  /// **'AI Guide'**
  String get aiGuideTitle;

  /// Conversation history drawer title
  ///
  /// In en, this message translates to:
  /// **'Conversations'**
  String get aiGuideConversations;

  /// Empty conversation list message
  ///
  /// In en, this message translates to:
  /// **'No conversations yet'**
  String get aiGuideNoConversations;

  /// Conversation list error message
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load conversations'**
  String get aiGuideConversationsError;

  /// Chat input placeholder
  ///
  /// In en, this message translates to:
  /// **'Ask a question...'**
  String get aiGuideInputHint;

  /// Empty chat greeting subtitle
  ///
  /// In en, this message translates to:
  /// **'Ask me anything about your guides'**
  String get aiGuideGreeting;

  /// New chat button label
  ///
  /// In en, this message translates to:
  /// **'New Chat'**
  String get aiGuideNewChat;

  /// Stream error message with retry
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Tap to retry.'**
  String get aiGuideStreamError;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['am', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'am':
      return AppLocalizationsAm();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
