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
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
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

  /// Login page subtitle
  ///
  /// In en, this message translates to:
  /// **'Log in to get started'**
  String get loginSubtitle;

  /// Email or username label
  ///
  /// In en, this message translates to:
  /// **'Email or username'**
  String get emailOrUsername;

  /// Email or username hint
  ///
  /// In en, this message translates to:
  /// **'Enter your email or username'**
  String get emailOrUsernameHint;

  /// Password hint
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordHint;

  /// Login error
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password'**
  String get errorInvalidCredentials;

  /// Registration error
  ///
  /// In en, this message translates to:
  /// **'Email already in use'**
  String get errorEmailInUse;

  /// Generic error
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get errorGeneric;

  /// OAuth error
  ///
  /// In en, this message translates to:
  /// **'OAuth sign in failed'**
  String get errorOAuthFailed;

  /// OAuth unavailable error
  ///
  /// In en, this message translates to:
  /// **'OAuth provider is unavailable'**
  String get errorOAuthUnavailable;

  /// OAuth callback error
  ///
  /// In en, this message translates to:
  /// **'Invalid OAuth callback'**
  String get errorOAuthCallbackInvalid;

  /// OAuth expired error
  ///
  /// In en, this message translates to:
  /// **'OAuth session expired, try again'**
  String get errorOAuthExpired;

  /// OAuth unsupported error
  ///
  /// In en, this message translates to:
  /// **'Unsupported OAuth provider'**
  String get errorOAuthUnsupported;

  /// OAuth cancelled error
  ///
  /// In en, this message translates to:
  /// **'OAuth login was cancelled'**
  String get errorOAuthCancelled;

  /// Register page title
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// Register page subtitle
  ///
  /// In en, this message translates to:
  /// **'Sign up to get started'**
  String get registerSubtitle;

  /// First name hint
  ///
  /// In en, this message translates to:
  /// **'Enter your first name'**
  String get firstNameHint;

  /// Last name hint
  ///
  /// In en, this message translates to:
  /// **'Enter your last name'**
  String get lastNameHint;

  /// Email hint
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get emailHint;

  /// Username label
  ///
  /// In en, this message translates to:
  /// **'Username (optional)'**
  String get username;

  /// Username hint
  ///
  /// In en, this message translates to:
  /// **'Choose a username'**
  String get usernameHint;

  /// Success message after registration
  ///
  /// In en, this message translates to:
  /// **'Registration successful'**
  String get registrationSuccessful;

  /// OTP page title
  ///
  /// In en, this message translates to:
  /// **'Verify Your Email'**
  String get verifyEmail;

  /// OTP page subtitle
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit code sent to your email'**
  String get otpSubtitle;

  /// OTP code hint
  ///
  /// In en, this message translates to:
  /// **'Please enter the 6-digit code'**
  String get otpCodeHint;

  /// Verify button
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// OTP resend prompt
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the code? '**
  String get didNotReceiveCode;

  /// Resend button
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// Resend cooldown text
  ///
  /// In en, this message translates to:
  /// **'Resend in {seconds}s'**
  String resendIn(int seconds);

  /// Invalid OTP error
  ///
  /// In en, this message translates to:
  /// **'Invalid OTP code'**
  String get errorInvalidOtp;

  /// English language option
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// Amharic language option
  ///
  /// In en, this message translates to:
  /// **'አማርኛ'**
  String get languageAmharic;

  /// Business profile prompt
  ///
  /// In en, this message translates to:
  /// **'Complete business profile'**
  String get completeBusinessProfile;

  /// Onboarding continue prompt
  ///
  /// In en, this message translates to:
  /// **'Continue onboarding anytime'**
  String get continueOnboardingAnytime;

  /// Plan section header
  ///
  /// In en, this message translates to:
  /// **'Plan'**
  String get plan;

  /// Free plan label
  ///
  /// In en, this message translates to:
  /// **'Free plan'**
  String get freePlan;

  /// Subscription active until date
  ///
  /// In en, this message translates to:
  /// **'Active until {date}'**
  String activeUntil(String date);

  /// Pro plan label
  ///
  /// In en, this message translates to:
  /// **'Pro'**
  String get pro;

  /// Basic plan label
  ///
  /// In en, this message translates to:
  /// **'Basic'**
  String get basic;

  /// Skip onboarding button
  ///
  /// In en, this message translates to:
  /// **'Skip for now'**
  String get skipForNow;

  /// Saving state text
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get saving;

  /// Onboarding save error
  ///
  /// In en, this message translates to:
  /// **'Failed to save business profile. Please try again.'**
  String get errorSaveFailed;

  /// Profile error state title
  ///
  /// In en, this message translates to:
  /// **'Unable to display profile data.'**
  String get unableToDisplayProfile;

  /// Profile error state subtitle
  ///
  /// In en, this message translates to:
  /// **'Please try loading your profile again.'**
  String get pleaseTryLoadingAgain;

  /// Edit avatar tooltip
  ///
  /// In en, this message translates to:
  /// **'Edit avatar'**
  String get editAvatar;

  /// Profile details section title
  ///
  /// In en, this message translates to:
  /// **'Profile Details'**
  String get profileDetails;

  /// Empty bio placeholder
  ///
  /// In en, this message translates to:
  /// **'No bio yet'**
  String get noBioYet;

  /// Edit profile form title
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// Bio label
  ///
  /// In en, this message translates to:
  /// **'Bio'**
  String get bio;

  /// Inbox title
  ///
  /// In en, this message translates to:
  /// **'Inbox'**
  String get inbox;

  /// Mark all notifications as read
  ///
  /// In en, this message translates to:
  /// **'Mark all read'**
  String get markAllRead;

  /// Empty notifications state
  ///
  /// In en, this message translates to:
  /// **'No notifications yet'**
  String get noNotifications;

  /// Just now short form
  ///
  /// In en, this message translates to:
  /// **'now'**
  String get timeNow;

  /// Minutes ago short form
  ///
  /// In en, this message translates to:
  /// **'{minutes}m'**
  String timeMinutesShort(int minutes);

  /// Hours ago short form
  ///
  /// In en, this message translates to:
  /// **'{hours}h'**
  String timeHoursShort(int hours);

  /// Days ago short form
  ///
  /// In en, this message translates to:
  /// **'{days}d'**
  String timeDaysShort(int days);

  /// Citations expandable label
  ///
  /// In en, this message translates to:
  /// **'Sources ({count})'**
  String citationSources(int count);

  /// Fallback citation title
  ///
  /// In en, this message translates to:
  /// **'Untitled source'**
  String get citationUntitled;

  /// Citation source metadata
  ///
  /// In en, this message translates to:
  /// **'{sourceType} · {score}% match'**
  String citationMatch(String sourceType, int score);

  /// Archive dialog title
  ///
  /// In en, this message translates to:
  /// **'Archive conversation'**
  String get archiveConversationTitle;

  /// Archive dialog body
  ///
  /// In en, this message translates to:
  /// **'This will remove the conversation from your history. This cannot be undone.'**
  String get archiveConversationContent;

  /// Archive confirm button
  ///
  /// In en, this message translates to:
  /// **'Archive'**
  String get archiveConversationAction;

  /// English language badge
  ///
  /// In en, this message translates to:
  /// **'EN'**
  String get languageLabelEn;

  /// Amharic language badge
  ///
  /// In en, this message translates to:
  /// **'አማ'**
  String get languageLabelAm;

  /// Guide tab/placeholder label
  ///
  /// In en, this message translates to:
  /// **'Guide'**
  String get guide;

  /// Community tab label
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get community;

  /// Templates tab/placeholder label
  ///
  /// In en, this message translates to:
  /// **'Templates'**
  String get templates;

  /// Quick action to continue last guide
  ///
  /// In en, this message translates to:
  /// **'Continue Last Guide'**
  String get continueLastGuide;

  /// Quick action to continue AI chat
  ///
  /// In en, this message translates to:
  /// **'Continue Chat'**
  String get continueChat;

  /// Guide tab placeholder subtitle
  ///
  /// In en, this message translates to:
  /// **'Browse guided learning paths and tips.'**
  String get guidePlaceholderSubtitle;

  /// Templates tab placeholder subtitle
  ///
  /// In en, this message translates to:
  /// **'Use ready-made templates to move faster.'**
  String get templatesPlaceholderSubtitle;

  /// Continue section header
  ///
  /// In en, this message translates to:
  /// **'Continue Where You Left Off'**
  String get continueWhereYouLeftOff;

  /// Empty dashboard welcome message
  ///
  /// In en, this message translates to:
  /// **'Welcome! Start your first guide to see your progress here.'**
  String get dashboardEmptyMessage;

  /// Quick actions section header
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActions;

  /// Monthly completion section header
  ///
  /// In en, this message translates to:
  /// **'Monthly Completion'**
  String get monthlyCompletion;

  /// Progress summary text
  ///
  /// In en, this message translates to:
  /// **'{completed} completed · {inProgress} in progress'**
  String progressSummary(int completed, int inProgress);

  /// Notifications tooltip/label
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// My downloads page title
  ///
  /// In en, this message translates to:
  /// **'My Downloads'**
  String get myDownloads;

  /// Templates search hint
  ///
  /// In en, this message translates to:
  /// **'Search templates...'**
  String get searchTemplates;

  /// Empty templates list
  ///
  /// In en, this message translates to:
  /// **'No templates found'**
  String get noTemplatesFound;

  /// Empty downloads list
  ///
  /// In en, this message translates to:
  /// **'No downloads yet'**
  String get noDownloadsYet;

  /// Download count badge
  ///
  /// In en, this message translates to:
  /// **'{count} downloads'**
  String downloadCount(int count);

  /// Categories section title
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// Show all categories button
  ///
  /// In en, this message translates to:
  /// **'Show All'**
  String get showAll;

  /// Preview button
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get preview;

  /// Upgrade button
  ///
  /// In en, this message translates to:
  /// **'Upgrade'**
  String get upgrade;

  /// Open in browser button
  ///
  /// In en, this message translates to:
  /// **'Open in Browser'**
  String get openInBrowser;

  /// Preview error message
  ///
  /// In en, this message translates to:
  /// **'Could not open preview'**
  String get previewFailed;

  /// Download success snackbar
  ///
  /// In en, this message translates to:
  /// **'Downloaded {filename}'**
  String downloadedFile(String filename);

  /// Download error snackbar
  ///
  /// In en, this message translates to:
  /// **'Download failed: {message}'**
  String downloadFailed(String message);

  /// Pro upgrade dialog title
  ///
  /// In en, this message translates to:
  /// **'Pro Template'**
  String get proTemplateTitle;

  /// Pro upgrade dialog body
  ///
  /// In en, this message translates to:
  /// **'This template is available with a Pro subscription. Upgrade to download and preview.'**
  String get proTemplateDescription;

  /// Upgrade to Pro button
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Pro'**
  String get upgradeToPro;

  /// Dismiss upgrade button
  ///
  /// In en, this message translates to:
  /// **'Maybe Later'**
  String get maybeLater;

  /// Open file action
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// PDF load error
  ///
  /// In en, this message translates to:
  /// **'Failed to load PDF: {error}'**
  String failedToLoadPDF(String error);

  /// Template detail page title
  ///
  /// In en, this message translates to:
  /// **'Template Details'**
  String get templateDetails;

  /// Download button
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// Plans page title
  ///
  /// In en, this message translates to:
  /// **'Choose Your Plan'**
  String get chooseYourPlan;

  /// Free plan period label
  ///
  /// In en, this message translates to:
  /// **'free forever'**
  String get freeForever;

  /// Monthly period label
  ///
  /// In en, this message translates to:
  /// **'/month'**
  String get perMonth;

  /// Yearly period label
  ///
  /// In en, this message translates to:
  /// **'/year'**
  String get perYear;

  /// Pro monthly plan name
  ///
  /// In en, this message translates to:
  /// **'Pro Monthly'**
  String get proMonthly;

  /// Pro yearly plan name
  ///
  /// In en, this message translates to:
  /// **'Pro Yearly'**
  String get proYearly;

  /// Subscribe button
  ///
  /// In en, this message translates to:
  /// **'Subscribe'**
  String get subscribe;

  /// Current plan badge
  ///
  /// In en, this message translates to:
  /// **'Current Plan'**
  String get currentPlan;

  /// Popular plan badge
  ///
  /// In en, this message translates to:
  /// **'Most Popular'**
  String get mostPopular;

  /// Active pro banner title
  ///
  /// In en, this message translates to:
  /// **'You are on Pro'**
  String get youAreOnPro;

  /// Yearly savings text
  ///
  /// In en, this message translates to:
  /// **'Save {percent}% with yearly billing'**
  String savePercentYearly(int percent);

  /// Billing disclaimer
  ///
  /// In en, this message translates to:
  /// **'Subscriptions are billed in ETB. You can cancel anytime.'**
  String get billingDisclaimer;

  /// Basic plan feature
  ///
  /// In en, this message translates to:
  /// **'Access to all guides'**
  String get planFeatureAllGuides;

  /// Basic plan feature
  ///
  /// In en, this message translates to:
  /// **'Community read-only access'**
  String get planFeatureCommunity;

  /// Basic plan feature
  ///
  /// In en, this message translates to:
  /// **'3 AI questions per month'**
  String get planFeatureAiQuestions;

  /// Pro plan feature
  ///
  /// In en, this message translates to:
  /// **'Everything in Basic'**
  String get planFeatureEverythingBasic;

  /// Pro plan feature
  ///
  /// In en, this message translates to:
  /// **'Unlimited AI questions'**
  String get planFeatureUnlimitedAi;

  /// Pro plan feature
  ///
  /// In en, this message translates to:
  /// **'Template downloads'**
  String get planFeatureTemplates;

  /// Pro plan feature
  ///
  /// In en, this message translates to:
  /// **'Priority community support'**
  String get planFeatureSupport;

  /// Pro plan feature
  ///
  /// In en, this message translates to:
  /// **'Advanced business profile'**
  String get planFeatureAdvancedProfile;

  /// Checkout loading text
  ///
  /// In en, this message translates to:
  /// **'Opening secure payment...'**
  String get openingSecurePayment;

  /// Cancelled payment snackbar
  ///
  /// In en, this message translates to:
  /// **'Payment cancelled'**
  String get paymentCancelled;

  /// Payment verification loading
  ///
  /// In en, this message translates to:
  /// **'Verifying your payment...'**
  String get verifyingPayment;

  /// Null verification error
  ///
  /// In en, this message translates to:
  /// **'No verification result'**
  String get noVerificationResult;

  /// Success result title
  ///
  /// In en, this message translates to:
  /// **'Payment Successful'**
  String get paymentSuccessful;

  /// Success result subtitle
  ///
  /// In en, this message translates to:
  /// **'Your Pro plan is now active.'**
  String get proPlanActive;

  /// Pending result title
  ///
  /// In en, this message translates to:
  /// **'Payment Processing'**
  String get paymentProcessing;

  /// Pending result subtitle
  ///
  /// In en, this message translates to:
  /// **'Your payment is being processed by your bank. This may take a moment.'**
  String get paymentBeingProcessed;

  /// Failed result title
  ///
  /// In en, this message translates to:
  /// **'Payment Failed'**
  String get paymentFailed;

  /// Failed result subtitle
  ///
  /// In en, this message translates to:
  /// **'Your payment could not be completed.'**
  String get couldNotCompletePayment;

  /// Retry payment button
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// Navigate home button
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;

  /// Plans load error
  ///
  /// In en, this message translates to:
  /// **'Failed to load plans: {error}'**
  String failedToLoadPlans(String error);

  /// Taxonomy filter bar load error
  ///
  /// In en, this message translates to:
  /// **'Failed to load filters'**
  String get failedToLoadFilters;

  /// Guide search hint
  ///
  /// In en, this message translates to:
  /// **'Search guides...'**
  String get guideSearchHint;

  /// Active filter indicator
  ///
  /// In en, this message translates to:
  /// **'Filtered'**
  String get guideFiltered;

  /// Clear filters link
  ///
  /// In en, this message translates to:
  /// **'Clear all'**
  String get guideClearAll;

  /// Bookmark toggle label
  ///
  /// In en, this message translates to:
  /// **'Bookmarked'**
  String get guideBookmarked;

  /// Empty guide list
  ///
  /// In en, this message translates to:
  /// **'No guides found'**
  String get guideNoGuidesFound;

  /// Empty bookmarks list
  ///
  /// In en, this message translates to:
  /// **'No bookmarks yet'**
  String get guideNoBookmarks;

  /// Recent guides section header
  ///
  /// In en, this message translates to:
  /// **'Recently Viewed'**
  String get guideRecentlyViewed;

  /// Recent badge label
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get guideRecent;

  /// Guide progress text
  ///
  /// In en, this message translates to:
  /// **'{completed} of {total} completed'**
  String guideProgressOf(int completed, int total);

  /// Progress percentage
  ///
  /// In en, this message translates to:
  /// **'{percent}%'**
  String guideProgressPercent(int percent);

  /// Sector count badge
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 sector} other{{count} sectors}}'**
  String guideSectorCount(int count);

  /// Tag count badge
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 tag} other{{count} tags}}'**
  String guideTagCount(int count);

  /// Step estimated time
  ///
  /// In en, this message translates to:
  /// **'~{minutes} min'**
  String stepEstimatedTime(String minutes);

  /// Empty step content
  ///
  /// In en, this message translates to:
  /// **'No content available for this step.'**
  String get stepNoContent;

  /// Completed status badge
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get stepStatusCompleted;

  /// In progress status badge
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get stepStatusInProgress;

  /// Skipped status badge
  ///
  /// In en, this message translates to:
  /// **'Skipped'**
  String get stepStatusSkipped;

  /// Locked status badge
  ///
  /// In en, this message translates to:
  /// **'Locked'**
  String get stepStatusLocked;

  /// Start step button
  ///
  /// In en, this message translates to:
  /// **'Start Step'**
  String get stepStart;

  /// Complete step button
  ///
  /// In en, this message translates to:
  /// **'Complete Step'**
  String get stepComplete;

  /// Skip step button
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get stepSkip;

  /// Mark step incomplete button
  ///
  /// In en, this message translates to:
  /// **'Mark Incomplete'**
  String get stepMarkIncomplete;

  /// Add bookmark tooltip
  ///
  /// In en, this message translates to:
  /// **'Add bookmark'**
  String get stepAddBookmark;

  /// Remove bookmark tooltip
  ///
  /// In en, this message translates to:
  /// **'Remove bookmark'**
  String get stepRemoveBookmark;

  /// For You tab
  ///
  /// In en, this message translates to:
  /// **'For You'**
  String get communityForYou;

  /// All tab
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get communityAll;

  /// Threads search hint
  ///
  /// In en, this message translates to:
  /// **'Search threads...'**
  String get searchThreads;

  /// Search empty state
  ///
  /// In en, this message translates to:
  /// **'No threads found for {query}'**
  String noThreadsFound(String query);

  /// Empty all threads
  ///
  /// In en, this message translates to:
  /// **'No threads available yet'**
  String get noThreadsAvailable;

  /// Empty filtered threads
  ///
  /// In en, this message translates to:
  /// **'No personalized threads available yet'**
  String get noPersonalizedThreads;

  /// Reply count
  ///
  /// In en, this message translates to:
  /// **'{count} replies'**
  String threadReplies(int count);

  /// View count
  ///
  /// In en, this message translates to:
  /// **'{count} views'**
  String threadViews(int count);

  /// Owned badge
  ///
  /// In en, this message translates to:
  /// **'Owned'**
  String get owned;

  /// Solved badge
  ///
  /// In en, this message translates to:
  /// **'Solved'**
  String get solved;

  /// Followed chip
  ///
  /// In en, this message translates to:
  /// **'Followed'**
  String get followed;

  /// Filter button tooltip
  ///
  /// In en, this message translates to:
  /// **'More filters'**
  String get moreFilters;

  /// Filter sheet title
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filters;

  /// Reset filters button
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// Filter search hint
  ///
  /// In en, this message translates to:
  /// **'Search sectors and tags...'**
  String get searchSectorsTags;

  /// Sectors section
  ///
  /// In en, this message translates to:
  /// **'Sectors'**
  String get sectors;

  /// Tags section
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get tags;

  /// Followed filter title
  ///
  /// In en, this message translates to:
  /// **'Followed only'**
  String get followedOnly;

  /// Followed filter subtitle
  ///
  /// In en, this message translates to:
  /// **'Show only threads you follow'**
  String get showFollowedOnly;

  /// Filter no results
  ///
  /// In en, this message translates to:
  /// **'No items match your search'**
  String get noItemsMatchSearch;

  /// Threads load error
  ///
  /// In en, this message translates to:
  /// **'Error loading threads: {error}'**
  String errorLoadingThreads(String error);

  /// Create thread title
  ///
  /// In en, this message translates to:
  /// **'Create Thread'**
  String get createThread;

  /// Post button
  ///
  /// In en, this message translates to:
  /// **'Post'**
  String get post;

  /// Title label
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// Title validation
  ///
  /// In en, this message translates to:
  /// **'Title required'**
  String get titleRequired;

  /// Min chars validation
  ///
  /// In en, this message translates to:
  /// **'Min {count} chars'**
  String minChars(int count);

  /// Initial post label
  ///
  /// In en, this message translates to:
  /// **'Initial Post'**
  String get initialPost;

  /// Post validation
  ///
  /// In en, this message translates to:
  /// **'Post required'**
  String get postRequired;

  /// Add images button
  ///
  /// In en, this message translates to:
  /// **'Add Images'**
  String get addImages;

  /// Add files button
  ///
  /// In en, this message translates to:
  /// **'Add Files'**
  String get addFiles;

  /// Sectors picker label
  ///
  /// In en, this message translates to:
  /// **'Sectors (optional)'**
  String get sectorsOptional;

  /// Tags picker label
  ///
  /// In en, this message translates to:
  /// **'Tags (optional)'**
  String get tagsOptional;

  /// Delete post dialog title
  ///
  /// In en, this message translates to:
  /// **'Delete Post'**
  String get deletePost;

  /// Delete post confirmation
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this post?'**
  String get confirmDeletePost;

  /// Post deleted snackbar
  ///
  /// In en, this message translates to:
  /// **'Post deleted successfully'**
  String get postDeleted;

  /// Mark solution dialog title
  ///
  /// In en, this message translates to:
  /// **'Mark as Solution'**
  String get markAsSolution;

  /// Mark solution confirmation
  ///
  /// In en, this message translates to:
  /// **'Mark this post as the accepted solution?'**
  String get confirmMarkSolution;

  /// Mark solution confirm
  ///
  /// In en, this message translates to:
  /// **'Mark'**
  String get mark;

  /// Marked solution snackbar
  ///
  /// In en, this message translates to:
  /// **'Marked as solution'**
  String get markedAsSolution;

  /// Delete thread dialog title
  ///
  /// In en, this message translates to:
  /// **'Delete Thread'**
  String get deleteThread;

  /// Delete thread confirmation
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this thread? This action cannot be undone.'**
  String get confirmDeleteThread;

  /// Thread deleted snackbar
  ///
  /// In en, this message translates to:
  /// **'Thread deleted successfully'**
  String get threadDeleted;

  /// Follow thread tooltip
  ///
  /// In en, this message translates to:
  /// **'Follow thread'**
  String get followThread;

  /// Unfollow thread tooltip
  ///
  /// In en, this message translates to:
  /// **'Unfollow thread'**
  String get unfollowThread;

  /// Follow success snackbar
  ///
  /// In en, this message translates to:
  /// **'Following thread'**
  String get followingThread;

  /// Unfollow success snackbar
  ///
  /// In en, this message translates to:
  /// **'Unfollowed thread'**
  String get unfollowedThread;

  /// Edit thread menu item
  ///
  /// In en, this message translates to:
  /// **'Edit Thread'**
  String get editThread;

  /// Report thread menu item
  ///
  /// In en, this message translates to:
  /// **'Report Thread'**
  String get reportThread;

  /// Empty replies state
  ///
  /// In en, this message translates to:
  /// **'No replies yet. Be the first!'**
  String get noRepliesYet;

  /// Reply button
  ///
  /// In en, this message translates to:
  /// **'Reply'**
  String get reply;

  /// Save image option
  ///
  /// In en, this message translates to:
  /// **'Save to Gallery'**
  String get saveToGallery;

  /// Image save success
  ///
  /// In en, this message translates to:
  /// **'Image saved to gallery!'**
  String get imageSaved;

  /// Report menu item
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get report;

  /// Report reason prompt
  ///
  /// In en, this message translates to:
  /// **'Select a reason:'**
  String get selectReason;

  /// Report reason
  ///
  /// In en, this message translates to:
  /// **'Spam'**
  String get reasonSpam;

  /// Report reason
  ///
  /// In en, this message translates to:
  /// **'Harassment'**
  String get reasonHarassment;

  /// Report reason
  ///
  /// In en, this message translates to:
  /// **'Inappropriate Content'**
  String get reasonInappropriate;

  /// Report reason
  ///
  /// In en, this message translates to:
  /// **'Misinformation'**
  String get reasonMisinformation;

  /// Report reason
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get reasonOther;

  /// Submit report button
  ///
  /// In en, this message translates to:
  /// **'Submit Report'**
  String get submitReport;

  /// Report success
  ///
  /// In en, this message translates to:
  /// **'{type} reported successfully'**
  String reportedSuccessfully(String type);

  /// Report reason hint
  ///
  /// In en, this message translates to:
  /// **'Describe why you are reporting this...'**
  String get reasonHint;

  /// Label when editing a post
  ///
  /// In en, this message translates to:
  /// **'Editing post'**
  String get editingPost;

  /// Label when replying to a user
  ///
  /// In en, this message translates to:
  /// **'Replying to {name}'**
  String replyingTo(String name);

  /// Label when creating a new post
  ///
  /// In en, this message translates to:
  /// **'New post'**
  String get newPost;

  /// Hint text for editing a post
  ///
  /// In en, this message translates to:
  /// **'Update your post...'**
  String get updateYourPost;

  /// Hint text for writing a reply
  ///
  /// In en, this message translates to:
  /// **'Write your reply...'**
  String get writeYourReply;

  /// Hint text for writing a new post
  ///
  /// In en, this message translates to:
  /// **'Write a post...'**
  String get writeAPost;

  /// Label for newly added attachments
  ///
  /// In en, this message translates to:
  /// **'New attachments ({count}):'**
  String newAttachments(int count);

  /// Label for existing attachments being edited
  ///
  /// In en, this message translates to:
  /// **'Existing attachments ({count}):'**
  String existingAttachments(int count);

  /// Button to remove all items
  ///
  /// In en, this message translates to:
  /// **'Remove all'**
  String get removeAll;

  /// Warning that attachments will be removed
  ///
  /// In en, this message translates to:
  /// **'Attachments will be removed on update'**
  String get attachmentsRemovedOnUpdate;

  /// Button to undo removing an attachment
  ///
  /// In en, this message translates to:
  /// **'Undo remove'**
  String get undoRemove;

  /// Tooltip to remove a specific attachment
  ///
  /// In en, this message translates to:
  /// **'Remove this attachment'**
  String get removeThisAttachment;

  /// Success snackbar after updating a post
  ///
  /// In en, this message translates to:
  /// **'Post updated successfully'**
  String get postUpdated;

  /// Success snackbar when image is saved to gallery
  ///
  /// In en, this message translates to:
  /// **'Image saved to gallery!'**
  String get imageSavedToGallery;

  /// Error when an image fails to load
  ///
  /// In en, this message translates to:
  /// **'Failed to load image'**
  String get failedToLoadImage;

  /// Error snackbar when post deletion fails
  ///
  /// In en, this message translates to:
  /// **'Failed to delete: {error}'**
  String failedToDeletePost(String error);

  /// Error snackbar when marking solution fails
  ///
  /// In en, this message translates to:
  /// **'Failed to mark solution: {error}'**
  String failedToMarkSolution(String error);

  /// Generic error snackbar with error details
  ///
  /// In en, this message translates to:
  /// **'Failed: {error}'**
  String failedWithError(String error);

  /// Title for OAuth email completion page
  ///
  /// In en, this message translates to:
  /// **'Complete your sign in'**
  String get oAuthCompletionTitle;

  /// Subtitle for OAuth email completion page
  ///
  /// In en, this message translates to:
  /// **'Add an email to finish signing in with {provider}.'**
  String oAuthCompletionSubtitle(String provider);

  /// Label showing the signed-in OAuth identity
  ///
  /// In en, this message translates to:
  /// **'Signed in as {name}'**
  String oAuthCompletionSignedInAs(String name);

  /// Label showing the OAuth provider subject
  ///
  /// In en, this message translates to:
  /// **'Provider subject: {subject}'**
  String oAuthCompletionProviderSubject(String subject);

  /// Loading message on OAuth callback page
  ///
  /// In en, this message translates to:
  /// **'Finishing sign in...'**
  String get oAuthFinishingSignIn;

  /// Message when no pending OAuth email completion
  ///
  /// In en, this message translates to:
  /// **'No OAuth email completion request found.'**
  String get oAuthNoCompletionRequest;

  /// Button to return to login page
  ///
  /// In en, this message translates to:
  /// **'Back to Login'**
  String get oAuthBackToLogin;

  /// Banner title prompting to complete business profile
  ///
  /// In en, this message translates to:
  /// **'Complete your business profile'**
  String get completeYourBusinessProfile;

  /// Banner subtitle for business profile completion
  ///
  /// In en, this message translates to:
  /// **'Unlock personalized guidance and better recommendations.'**
  String get unlockPersonalizedGuidance;

  /// Offline banner message
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get noInternetConnection;

  /// Empty filter results message
  ///
  /// In en, this message translates to:
  /// **'No items match your search'**
  String get filterNoResults;

  /// Attachments label
  ///
  /// In en, this message translates to:
  /// **'Attachments'**
  String get attachments;

  /// Remove this item action
  ///
  /// In en, this message translates to:
  /// **'Remove this'**
  String get removeThis;

  /// Inbox tab label
  ///
  /// In en, this message translates to:
  /// **'Inbox'**
  String get inboxTab;

  /// Scheduled tab label
  ///
  /// In en, this message translates to:
  /// **'Scheduled'**
  String get scheduledTab;

  /// Compliance tab/AppBar title
  ///
  /// In en, this message translates to:
  /// **'Compliance'**
  String get compliance;

  /// Empty inbox state
  ///
  /// In en, this message translates to:
  /// **'Your inbox is empty'**
  String get inboxEmpty;

  /// Auto-tracked section header
  ///
  /// In en, this message translates to:
  /// **'Auto-tracked'**
  String get complianceAutoTracked;

  /// Manual section header
  ///
  /// In en, this message translates to:
  /// **'Manual'**
  String get complianceManual;

  /// Empty compliance list title
  ///
  /// In en, this message translates to:
  /// **'No compliance entries yet'**
  String get complianceNoEntries;

  /// Empty compliance list description
  ///
  /// In en, this message translates to:
  /// **'Auto-tracked entries appear when you add TIN, license, or registration numbers to your business profile.'**
  String get complianceAutoTrackedDesc;

  /// No business profile state title
  ///
  /// In en, this message translates to:
  /// **'Business profile required'**
  String get businessProfileRequired;

  /// No business profile state description
  ///
  /// In en, this message translates to:
  /// **'Create your business profile first to track compliance deadlines.'**
  String get complianceCreateProfileDesc;

  /// Create business profile button
  ///
  /// In en, this message translates to:
  /// **'Create Business Profile'**
  String get createBusinessProfile;

  /// Expiry date prefix
  ///
  /// In en, this message translates to:
  /// **'Expires: '**
  String get expires;

  /// Auto-generated badge
  ///
  /// In en, this message translates to:
  /// **'Auto-generated'**
  String get autoGenerated;

  /// Add compliance entry page title
  ///
  /// In en, this message translates to:
  /// **'Add Compliance Entry'**
  String get addComplianceEntry;

  /// Reference number label
  ///
  /// In en, this message translates to:
  /// **'Reference Number'**
  String get referenceNumber;

  /// Reference number hint
  ///
  /// In en, this message translates to:
  /// **'Enter reference number'**
  String get enterReferenceNumber;

  /// Expiry date label
  ///
  /// In en, this message translates to:
  /// **'Expiry Date'**
  String get expiryDate;

  /// Reminder days label
  ///
  /// In en, this message translates to:
  /// **'Remind before (days)'**
  String get remindBeforeDays;

  /// Compliance entry page title
  ///
  /// In en, this message translates to:
  /// **'Compliance Entry'**
  String get complianceEntry;

  /// Entry not found message
  ///
  /// In en, this message translates to:
  /// **'Entry not found'**
  String get entryNotFound;

  /// Auto-generated info card text
  ///
  /// In en, this message translates to:
  /// **'Auto-generated from your business profile'**
  String get autoGeneratedFromProfile;

  /// Compliance type label
  ///
  /// In en, this message translates to:
  /// **'Compliance Type'**
  String get complianceType;

  /// Fallback for unset values
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get notSet;

  /// Empty compliance calendar title
  ///
  /// In en, this message translates to:
  /// **'No upcoming deadlines'**
  String get noUpcomingDeadlines;

  /// Empty compliance calendar description
  ///
  /// In en, this message translates to:
  /// **'Add compliance entries from your business profile'**
  String get complianceAddEntriesDesc;

  /// Manage compliance button
  ///
  /// In en, this message translates to:
  /// **'Manage Compliance'**
  String get manageCompliance;

  /// Upcoming section header
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// Manage action link
  ///
  /// In en, this message translates to:
  /// **'Manage'**
  String get manage;

  /// Current password label
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentPassword;

  /// New password label
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// Change password button/section label
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// Password changed success message
  ///
  /// In en, this message translates to:
  /// **'Password updated successfully'**
  String get passwordUpdated;

  /// Password change error fallback
  ///
  /// In en, this message translates to:
  /// **'Failed to change password'**
  String get errorPasswordChangeFailed;

  /// Scheduled alerts section header
  ///
  /// In en, this message translates to:
  /// **'Scheduled Alerts'**
  String get scheduledAlerts;

  /// Days remaining label
  ///
  /// In en, this message translates to:
  /// **'remaining'**
  String get remaining;

  /// Compliance calendar widget title
  ///
  /// In en, this message translates to:
  /// **'Compliance Calendar'**
  String get complianceCalendar;

  /// See all action link
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// Pro upgrade dialog body
  ///
  /// In en, this message translates to:
  /// **'You\'ve reached the max of 3 scheduled alerts. Upgrade to Pro for unlimited alerts.'**
  String get upgradeToProDesc;

  /// View plans dialog action
  ///
  /// In en, this message translates to:
  /// **'View Plans'**
  String get viewPlans;

  /// New scheduled alert page title
  ///
  /// In en, this message translates to:
  /// **'New Scheduled Alert'**
  String get newScheduledAlert;

  /// Template dropdown label
  ///
  /// In en, this message translates to:
  /// **'Template'**
  String get template;

  /// No template option
  ///
  /// In en, this message translates to:
  /// **'None (Custom)'**
  String get noneCustom;

  /// Body field label
  ///
  /// In en, this message translates to:
  /// **'Body'**
  String get bodyField;

  /// Body validation message
  ///
  /// In en, this message translates to:
  /// **'Body is required'**
  String get bodyRequired;

  /// Channels section label
  ///
  /// In en, this message translates to:
  /// **'Channels'**
  String get channels;

  /// In-App channel label
  ///
  /// In en, this message translates to:
  /// **'In-App'**
  String get inAppChannel;

  /// Push channel label
  ///
  /// In en, this message translates to:
  /// **'Push'**
  String get pushChannel;

  /// Free user alert usage counter
  ///
  /// In en, this message translates to:
  /// **'Free users: {count} of 3 used'**
  String freeUserAlertCount(int count);

  /// Empty scheduled alerts title
  ///
  /// In en, this message translates to:
  /// **'No scheduled alerts yet'**
  String get noScheduledAlerts;

  /// Empty scheduled alerts description
  ///
  /// In en, this message translates to:
  /// **'Tap + to create one'**
  String get tapToCreate;

  /// Pending status label
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// Sent status label
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get sent;

  /// Cancelled status label
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelledStatus;

  /// Reschedule button
  ///
  /// In en, this message translates to:
  /// **'Reschedule'**
  String get reschedule;

  /// Overdue date label
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get overdue;

  /// Tomorrow label
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get tomorrow;

  /// Compliance entry created success
  ///
  /// In en, this message translates to:
  /// **'Compliance entry created'**
  String get complianceCreated;

  /// Compliance entry updated success
  ///
  /// In en, this message translates to:
  /// **'Compliance entry updated'**
  String get complianceUpdated;

  /// Compliance entry deleted success
  ///
  /// In en, this message translates to:
  /// **'Compliance entry deleted'**
  String get complianceDeleted;

  /// Create compliance error
  ///
  /// In en, this message translates to:
  /// **'Unable to create compliance entry'**
  String get complianceUnableToCreate;

  /// Update compliance error
  ///
  /// In en, this message translates to:
  /// **'Unable to update compliance entry'**
  String get complianceUnableToUpdate;

  /// Delete compliance error
  ///
  /// In en, this message translates to:
  /// **'Unable to delete compliance entry'**
  String get complianceUnableToDelete;

  /// Compliance entry not found error
  ///
  /// In en, this message translates to:
  /// **'Compliance entry not found'**
  String get complianceNotFound;

  /// Create alert error
  ///
  /// In en, this message translates to:
  /// **'Unable to create alert'**
  String get unableToCreateAlert;

  /// Cancel alert error
  ///
  /// In en, this message translates to:
  /// **'Unable to cancel alert'**
  String get unableToCancelAlert;

  /// Reschedule alert error
  ///
  /// In en, this message translates to:
  /// **'Unable to reschedule alert'**
  String get unableToRescheduleAlert;

  /// Max scheduled alerts limit error
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Pro to create more than 3 scheduled alerts'**
  String get maxLimitReached;

  /// Scheduled alert not found error
  ///
  /// In en, this message translates to:
  /// **'Scheduled alert not found'**
  String get scheduledAlertNotFound;

  /// Notification preferences page title
  ///
  /// In en, this message translates to:
  /// **'Notification Preferences'**
  String get notificationPreferences;

  /// Email notifications toggle label
  ///
  /// In en, this message translates to:
  /// **'Email Notifications'**
  String get emailNotifications;

  /// Push notifications toggle label
  ///
  /// In en, this message translates to:
  /// **'Push Notifications'**
  String get pushNotifications;

  /// In-app notifications are always enabled
  ///
  /// In en, this message translates to:
  /// **'Always enabled'**
  String get inAppAlwaysOn;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['am', 'en'].contains(locale.languageCode);

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
