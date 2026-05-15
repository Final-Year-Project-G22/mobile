// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Adisu';

  @override
  String get welcome => 'Welcome';

  @override
  String get login => 'Login';

  @override
  String get logout => 'Logout';

  @override
  String get register => 'Register';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get firstName => 'First Name';

  @override
  String get lastName => 'Last Name';

  @override
  String get phone => 'Phone';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get signUp => 'Sign Up';

  @override
  String get signIn => 'Sign In';

  @override
  String get profile => 'Profile';

  @override
  String get settings => 'Settings';

  @override
  String get home => 'Home';

  @override
  String get search => 'Search';

  @override
  String get searchHint => 'Search...';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get done => 'Done';

  @override
  String get next => 'Next';

  @override
  String get back => 'Back';

  @override
  String get continueText => 'Continue';

  @override
  String get submit => 'Submit';

  @override
  String get retry => 'Retry';

  @override
  String get close => 'Close';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get ok => 'OK';

  @override
  String get loading => 'Loading...';

  @override
  String get pleaseWait => 'Please wait...';

  @override
  String get error => 'Error';

  @override
  String get success => 'Success';

  @override
  String get warning => 'Warning';

  @override
  String get info => 'Information';

  @override
  String get errorNetwork => 'No internet connection';

  @override
  String get errorServer => 'Server error. Please try again later';

  @override
  String get errorUnknown => 'Something went wrong';

  @override
  String get errorTimeout => 'Request timed out. Please try again';

  @override
  String get errorUnauthorized => 'Session expired. Please login again';

  @override
  String get errorValidation => 'Please check your input';

  @override
  String get confirmDelete => 'Are you sure you want to delete?';

  @override
  String get confirmLogout => 'Are you sure you want to logout?';

  @override
  String get confirm => 'Confirm';

  @override
  String get noData => 'No data available';

  @override
  String get noResults => 'No results found';

  @override
  String get pullToRefresh => 'Pull to refresh';

  @override
  String get loadingMore => 'Loading more...';

  @override
  String get all => 'All';

  @override
  String get none => 'None';

  @override
  String get select => 'Select';

  @override
  String get selected => 'Selected';

  @override
  String get required => 'This field is required';

  @override
  String get invalidEmail => 'Please enter a valid email';

  @override
  String get invalidPhone => 'Please enter a valid phone number';

  @override
  String get passwordTooShort => 'Password must be at least 8 characters';

  @override
  String get passwordMismatch => 'Passwords do not match';

  @override
  String fieldRequired(String fieldName) {
    return '$fieldName is required';
  }

  @override
  String itemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
      zero: 'No items',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days ago',
      one: '1 day ago',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hours ago',
      one: '1 hour ago',
    );
    return '$_temp0';
  }

  @override
  String minutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minutes ago',
      one: '1 minute ago',
    );
    return '$_temp0';
  }

  @override
  String get justNow => 'Just now';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get thisWeek => 'This week';

  @override
  String get language => 'Language';

  @override
  String get theme => 'Theme';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get lightMode => 'Light Mode';

  @override
  String get systemDefault => 'System Default';

  @override
  String get about => 'About';

  @override
  String get version => 'Version';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get contactSupport => 'Contact Support';

  @override
  String get rateApp => 'Rate App';

  @override
  String get shareApp => 'Share App';

  @override
  String get finish => 'Finish';

  @override
  String get onboardingTitle => 'Community Setup';

  @override
  String get onboardingLanguageLabel => 'Eng';

  @override
  String onboardingStepLabel(int current, int total) {
    return 'Step $current of $total';
  }

  @override
  String onboardingProgress(int percent) {
    return '$percent% Complete';
  }

  @override
  String get onboardingRegionTitle =>
      'Where is your business primarily located?';

  @override
  String get onboardingRegionSubtitle =>
      'We use your region to surface relevant local guidance.';

  @override
  String get onboardingRegionAddis => 'Addis Ababa';

  @override
  String get onboardingRegionOromia => 'Oromia';

  @override
  String get onboardingRegionAmhara => 'Amhara';

  @override
  String get onboardingRegionTigray => 'Tigray';

  @override
  String get onboardingRegionSidama => 'Sidama';

  @override
  String get onboardingRegionSouthWest => 'South West';

  @override
  String get onboardingRegionSouthern => 'Southern';

  @override
  String get onboardingRegionSomali => 'Somali';

  @override
  String get onboardingRegionAfar => 'Afar';

  @override
  String get onboardingRegionBenishangul => 'Benishangul-Gumuz';

  @override
  String get onboardingRegionGambella => 'Gambella';

  @override
  String get onboardingRegionHarari => 'Harari';

  @override
  String get onboardingRegionDireDawa => 'Dire Dawa';

  @override
  String get onboardingLifecycleTitle =>
      'What stage is your business currently in?';

  @override
  String get onboardingLifecycleSubtitle =>
      'This helps us tailor advice for your current needs.';

  @override
  String get onboardingLifecycleIdea => 'Just an Idea';

  @override
  String get onboardingLifecycleRegistration => 'Currently Registering';

  @override
  String get onboardingLifecycleOperational => 'Operational';

  @override
  String get onboardingLifecycleScaling => 'Scaling/Expanding';

  @override
  String get onboardingIndustryTitle => 'What is your main industry?';

  @override
  String get onboardingIndustrySubtitle =>
      'Pick the sector that best matches your business.';

  @override
  String get onboardingIndustryTrade => 'Trade';

  @override
  String get onboardingIndustryManufacturing => 'Manufacturing';

  @override
  String get onboardingIndustryServices => 'Services';

  @override
  String get onboardingIndustryAgriculture => 'Agriculture';

  @override
  String get onboardingIndustryConstruction => 'Construction';

  @override
  String get onboardingLegalTitle => 'How is your business legally structured?';

  @override
  String get onboardingLegalSubtitle =>
      'If you are planning, choose the structure you expect.';

  @override
  String get onboardingLegalSoleProprietor => 'Sole Proprietor';

  @override
  String get onboardingLegalPlc => 'Private Limited Company';

  @override
  String get onboardingLegalShareCompany => 'Share Company';

  @override
  String get onboardingLegalPartnership => 'Partnership';

  @override
  String get onboardingLegalCooperative => 'Cooperative';

  @override
  String get onboardingTaxTitle => 'What is your tax registration status?';

  @override
  String get onboardingTaxVat => 'VAT Payer (>2M ETB)';

  @override
  String get onboardingTaxTot => 'TOT Payer (<2M ETB)';

  @override
  String get onboardingTaxExcise => 'Excise Tax Payer';

  @override
  String get onboardingTaxExempt => 'Tax Exempt';

  @override
  String get onboardingOpsTitle => 'What activities will your business do?';

  @override
  String get onboardingOpsSubtitle => 'Check all that apply.';

  @override
  String get onboardingOpsImporter => 'I import goods';

  @override
  String get onboardingOpsExporter => 'I export goods';

  @override
  String get onboardingOpsTender => 'I supply to Gov or NGOs';

  @override
  String get onboardingOpsFoodHandling => 'I handle food or beverages';

  @override
  String get onboardingOpsVehicles => 'I operate commercial vehicles';

  @override
  String get onboardingOpsHazardous => 'I use hazardous chemicals';

  @override
  String get onboardingOpsEcommerce => 'I sell online (E-commerce)';

  @override
  String get onboardingOpsHomeBased => 'I operate from my home';

  @override
  String get onboardingOpsEmployees => 'I have official salaried employees';

  @override
  String get onboardingDemoTitle => 'Tell us a bit more about the founders';

  @override
  String get onboardingDemoSubtitle =>
      'Unlock specific grants and guides. Optional.';

  @override
  String get onboardingDemoWomenOwned => 'Women-Owned';

  @override
  String get onboardingDemoYouth => 'Youth Enterprise (18-35)';

  @override
  String get onboardingDemoInvestor => 'Diaspora/Foreign Investor';

  @override
  String get onboardingDemoOptional => 'You can skip this step if you prefer.';

  @override
  String get aiGuideTitle => 'AI Guide';

  @override
  String get aiGuideConversations => 'Conversations';

  @override
  String get aiGuideNoConversations => 'No conversations yet';

  @override
  String get aiGuideConversationsError => 'Couldn\'t load conversations';

  @override
  String get aiGuideInputHint => 'Ask a question...';

  @override
  String get aiGuideGreeting => 'Ask me anything about your guides';

  @override
  String get aiGuideNewChat => 'New Chat';

  @override
  String get aiGuideStreamError => 'Something went wrong. Tap to retry.';

  @override
  String get loginSubtitle => 'Log in to get started';

  @override
  String get emailOrUsername => 'Email or username';

  @override
  String get emailOrUsernameHint => 'Enter your email or username';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get errorInvalidCredentials => 'Invalid email or password';

  @override
  String get errorEmailInUse => 'Email already in use';

  @override
  String get errorGeneric => 'An error occurred';

  @override
  String get errorOAuthFailed => 'OAuth sign in failed';

  @override
  String get errorOAuthUnavailable => 'OAuth provider is unavailable';

  @override
  String get errorOAuthCallbackInvalid => 'Invalid OAuth callback';

  @override
  String get errorOAuthExpired => 'OAuth session expired, try again';

  @override
  String get errorOAuthUnsupported => 'Unsupported OAuth provider';

  @override
  String get errorOAuthCancelled => 'OAuth login was cancelled';

  @override
  String get createAccount => 'Create Account';

  @override
  String get registerSubtitle => 'Sign up to get started';

  @override
  String get firstNameHint => 'Enter your first name';

  @override
  String get lastNameHint => 'Enter your last name';

  @override
  String get emailHint => 'Enter your email';

  @override
  String get username => 'Username (optional)';

  @override
  String get usernameHint => 'Choose a username';

  @override
  String get registrationSuccessful => 'Registration successful';

  @override
  String get verifyEmail => 'Verify Your Email';

  @override
  String get otpSubtitle => 'Enter the 6-digit code sent to your email';

  @override
  String get otpCodeHint => 'Please enter the 6-digit code';

  @override
  String get verify => 'Verify';

  @override
  String get didNotReceiveCode => 'Didn\'t receive the code? ';

  @override
  String get resend => 'Resend';

  @override
  String resendIn(int seconds) {
    return 'Resend in ${seconds}s';
  }

  @override
  String get errorInvalidOtp => 'Invalid OTP code';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageAmharic => 'አማርኛ';

  @override
  String get completeBusinessProfile => 'Complete business profile';

  @override
  String get continueOnboardingAnytime => 'Continue onboarding anytime';

  @override
  String get plan => 'Plan';

  @override
  String get freePlan => 'Free plan';

  @override
  String activeUntil(String date) {
    return 'Active until $date';
  }

  @override
  String get pro => 'Pro';

  @override
  String get basic => 'Basic';

  @override
  String get skipForNow => 'Skip for now';

  @override
  String get saving => 'Saving...';

  @override
  String get errorSaveFailed =>
      'Failed to save business profile. Please try again.';

  @override
  String get unableToDisplayProfile => 'Unable to display profile data.';

  @override
  String get pleaseTryLoadingAgain => 'Please try loading your profile again.';

  @override
  String get editAvatar => 'Edit avatar';

  @override
  String get profileDetails => 'Profile Details';

  @override
  String get noBioYet => 'No bio yet';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get bio => 'Bio';
}
