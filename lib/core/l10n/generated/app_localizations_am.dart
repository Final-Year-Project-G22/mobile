// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Amharic (`am`).
class AppLocalizationsAm extends AppLocalizations {
  AppLocalizationsAm([String locale = 'am']) : super(locale);

  @override
  String get appTitle => 'አዲሱ';

  @override
  String get welcome => 'እንኳን ደህና መጡ';

  @override
  String get login => 'ግባ';

  @override
  String get logout => 'ውጣ';

  @override
  String get register => 'መዝግብ';

  @override
  String get email => 'ኢሜይል';

  @override
  String get password => 'ይለፍ';

  @override
  String get confirmPassword => 'ይለፍ አረጋግጥ';

  @override
  String get firstName => 'ስም';

  @override
  String get lastName => 'የአባት ስም';

  @override
  String get phone => 'ስልክ';

  @override
  String get forgotPassword => 'ይለፍ ረሳኽ?';

  @override
  String get dontHaveAccount => 'አካውንት የለህም?';

  @override
  String get alreadyHaveAccount => 'አካውንት አለህ?';

  @override
  String get signUp => 'ይመዝገብ';

  @override
  String get signIn => 'ግባ';

  @override
  String get profile => 'ፕሮፋይል';

  @override
  String get settings => 'ቅንብሮች';

  @override
  String get home => 'ቤት';

  @override
  String get search => 'ፈልግ';

  @override
  String get searchHint => 'ፈልግ...';

  @override
  String get cancel => 'ሰርዝ';

  @override
  String get save => 'አስቀምጥ';

  @override
  String get delete => 'ሰርዝ';

  @override
  String get edit => 'አርስ';

  @override
  String get done => 'ተያያዥ';

  @override
  String get next => 'ቀጣይ';

  @override
  String get back => 'ተመልስ';

  @override
  String get continueText => 'ቀጥል';

  @override
  String get submit => 'ላክ';

  @override
  String get retry => 'እንደገና ሞክር';

  @override
  String get close => 'ዝጋ';

  @override
  String get yes => 'አዎ';

  @override
  String get no => 'አይ';

  @override
  String get ok => 'ነው';

  @override
  String get loading => 'በመጫን ላይ...';

  @override
  String get pleaseWait => 'እባክህ ጠብቅ...';

  @override
  String get error => 'ስህተት';

  @override
  String get success => 'ተሳካ';

  @override
  String get warning => 'ማስጠንቀቂያ';

  @override
  String get info => 'መረጃ';

  @override
  String get errorNetwork => 'አውታረመር የለም';

  @override
  String get errorServer => 'አገልጋይ ስህተት ነው። እንደገና ሞክር';

  @override
  String get errorUnknown => 'ያልታወቀ ስህተት ሆኗል';

  @override
  String get errorTimeout => 'ጊዜው አልቋል። እንደገና ሞክር';

  @override
  String get errorUnauthorized => 'ክፈፍ ጠፍቷል። እንደገና ግባ';

  @override
  String get errorValidation => 'ግብዓትህን ፈተሻሻ';

  @override
  String get confirmDelete => 'ለማሰር ታስቧል?';

  @override
  String get confirmLogout => 'ለመውጣት ታስቧል?';

  @override
  String get confirm => 'አረጋግጥ';

  @override
  String get noData => 'ምንም ውሂብ የለም';

  @override
  String get noResults => 'ውጤት አልተገኘም';

  @override
  String get pullToRefresh => 'ለማደስ ድረስ ድርቅ';

  @override
  String get loadingMore => 'ተጨማሪ በመጫን ላይ...';

  @override
  String get all => 'ሁሉም';

  @override
  String get none => 'ምንም';

  @override
  String get select => 'ምረጥ';

  @override
  String get selected => 'ተመርጦሃል';

  @override
  String get required => 'ይሄ መስክ ያስፈልጋል';

  @override
  String get invalidEmail => 'ትክክለኛ ኢሜይል አስገባ';

  @override
  String get invalidPhone => 'ትክክለኛ ስልክ አስገባ';

  @override
  String get passwordTooShort => 'ይለፍ ቢያንስ 8 ቁምፊዎች መሆን አለበት';

  @override
  String get passwordMismatch => 'ይለፎች አይዛመዱም';

  @override
  String fieldRequired(String fieldName) {
    return '$fieldName ያስፈልጋል';
  }

  @override
  String itemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ዕቃዎች',
      one: '1 ዕቃ',
      zero: 'ምንም ዕቃ የለም',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ቀናት በፊት',
      one: '1 ቀን በፊት',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ሰዓታት በፊት',
      one: '1 ሰዓት በፊት',
    );
    return '$_temp0';
  }

  @override
  String minutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ደቂቃዎች በፊት',
      one: '1 ደቂቃ በፊት',
    );
    return '$_temp0';
  }

  @override
  String get justNow => 'አሁን';

  @override
  String get today => 'ዛሬ';

  @override
  String get yesterday => 'ትናንት';

  @override
  String get thisWeek => 'ይህ ሳምንት';

  @override
  String get language => 'ቋንቋ';

  @override
  String get theme => 'ገጽታ';

  @override
  String get darkMode => 'ጨለማ ሁኔታ';

  @override
  String get lightMode => 'ብርሃን ሁኔታ';

  @override
  String get systemDefault => 'ስርዓት ነባር';

  @override
  String get about => 'ስለ';

  @override
  String get version => 'ስሪት';

  @override
  String get privacyPolicy => 'ግላዊነት ፖሊሲ';

  @override
  String get termsOfService => 'አገልግሎት ውሎች';

  @override
  String get contactSupport => 'ድጋፍ ያግኙ';

  @override
  String get rateApp => 'አፕሊኬሽን ደርስ';

  @override
  String get shareApp => 'አፕሊኬሽን አጋራ';

  @override
  String get finish => 'ጨርስ';

  @override
  String get onboardingTitle => 'የማህበረሰብ ማዋቀር';

  @override
  String get onboardingLanguageLabel => 'አማ';

  @override
  String onboardingStepLabel(int current, int total) {
    return 'ደረጃ $current ከ $total';
  }

  @override
  String onboardingProgress(int percent) {
    return '$percent% ተጠናቋል';
  }

  @override
  String get onboardingRegionTitle => 'የንግድ ድርጅትዎ በዋናነት የት ይገኛል?';

  @override
  String get onboardingRegionSubtitle => 'የክልል መመሪያዎችን ለማሳየት ክልልዎን እንጠቀማለን።';

  @override
  String get onboardingRegionAddis => 'አዲስ አበባ';

  @override
  String get onboardingRegionOromia => 'ኦሮሚያ';

  @override
  String get onboardingRegionAmhara => 'አማራ';

  @override
  String get onboardingRegionTigray => 'ትግራይ';

  @override
  String get onboardingRegionSidama => 'ሲዳማ';

  @override
  String get onboardingRegionSouthWest => 'ደቡብ ምዕራብ';

  @override
  String get onboardingRegionSouthern => 'ደቡብ';

  @override
  String get onboardingRegionSomali => 'ሶማሊ';

  @override
  String get onboardingRegionAfar => 'አፋር';

  @override
  String get onboardingRegionBenishangul => 'ቤንሻንጉል-ጉሙዝ';

  @override
  String get onboardingRegionGambella => 'ጋምቤላ';

  @override
  String get onboardingRegionHarari => 'ሐረሪ';

  @override
  String get onboardingRegionDireDawa => 'ድሬዳዋ';

  @override
  String get onboardingLifecycleTitle => 'የንግድ ድርጅትዎ አሁን በምን ደረጃ ላይ ይገኛል?';

  @override
  String get onboardingLifecycleSubtitle => 'ለእርስዎ ተስማሚ መመሪያ እንድንሰጥ ይረዳል።';

  @override
  String get onboardingLifecycleIdea => 'ሀሳብ ደረጃ';

  @override
  String get onboardingLifecycleRegistration => 'ምዝገባ ላይ';

  @override
  String get onboardingLifecycleOperational => 'ስራ የጀመረ';

  @override
  String get onboardingLifecycleScaling => 'በማደግ ላይ';

  @override
  String get onboardingIndustryTitle => 'ዋና የንግድ ዘርፍዎ ምንድነው?';

  @override
  String get onboardingIndustrySubtitle => 'ከእቅድዎ ጋር በጣም የሚዛመደውን ዘርፍ ይምረጡ።';

  @override
  String get onboardingIndustryTrade => 'ንግድ';

  @override
  String get onboardingIndustryManufacturing => 'ማምረቻ';

  @override
  String get onboardingIndustryServices => 'አገልግሎት';

  @override
  String get onboardingIndustryAgriculture => 'ግብርና';

  @override
  String get onboardingIndustryConstruction => 'ኮንስትራክሽን';

  @override
  String get onboardingLegalTitle => 'የንግድ ድርጅትዎ ህጋዊ አወቃቀር ምን ይመስላል?';

  @override
  String get onboardingLegalSubtitle => 'እቅድ ካለ የሚገመተውን አወቃቀር ይምረጡ።';

  @override
  String get onboardingLegalSoleProprietor => 'የግል ማህበር';

  @override
  String get onboardingLegalPlc => 'ኃ.የተ.የግ.ማ';

  @override
  String get onboardingLegalShareCompany => 'አ.ማ';

  @override
  String get onboardingLegalPartnership => 'ሽርክና ማህበር';

  @override
  String get onboardingLegalCooperative => 'ህብረት ስራ ማህበር';

  @override
  String get onboardingTaxTitle => 'የታክስ ምዝገባ ሁኔታዎ ምን ይመስላል?';

  @override
  String get onboardingTaxVat => 'የተጨማሪ እሴት ታክስ';

  @override
  String get onboardingTaxTot => 'የሽያጭ ታክስ';

  @override
  String get onboardingTaxExcise => 'ኤክሳይዝ ታክስ';

  @override
  String get onboardingTaxExempt => 'ከታክስ ነፃ';

  @override
  String get onboardingOpsTitle => 'ድርጅትዎ ምን አይነት የስራ እንቅስቃሴዎችን ያደርጋል?';

  @override
  String get onboardingOpsSubtitle => 'የሚመለከቱትን ሁሉ ይምረጡ።';

  @override
  String get onboardingOpsImporter => 'አስመጪ';

  @override
  String get onboardingOpsExporter => 'ላኪ';

  @override
  String get onboardingOpsTender => 'ለመንግስት/NGO አቅራቢ';

  @override
  String get onboardingOpsFoodHandling => 'ምግብና መጠጥ ነክ';

  @override
  String get onboardingOpsVehicles => 'የንግድ መኪና';

  @override
  String get onboardingOpsHazardous => 'አደገኛ ኬሚካል';

  @override
  String get onboardingOpsEcommerce => 'ኢ-ኮሜርስ';

  @override
  String get onboardingOpsHomeBased => 'ከቤት የሚሰራ';

  @override
  String get onboardingOpsEmployees => 'ሰራተኛ ያለው';

  @override
  String get onboardingDemoTitle => 'ስለ መስራቾቹ ተጨማሪ ይንገሩን';

  @override
  String get onboardingDemoSubtitle => 'ልዩ ድጋፎችን እና መመሪያዎችን ለማግኘት።';

  @override
  String get onboardingDemoWomenOwned => 'በሴቶች የተመሰረተ';

  @override
  String get onboardingDemoYouth => 'የወጣቶች ኢንተርፕራይዝ (18-35)';

  @override
  String get onboardingDemoInvestor => 'የውጭ/ዳያስፖራ ባለሀብት';

  @override
  String get onboardingDemoOptional => 'ይህን ደረጃ መዝለል ይችላሉ።';

  @override
  String get aiGuideTitle => 'AI መምሪያ';

  @override
  String get aiGuideConversations => 'ውይይቶች';

  @override
  String get aiGuideNoConversations => 'እስካሁን ምንም ውይይት የለም';

  @override
  String get aiGuideConversationsError => 'ውይይቶችን መጫን አልተቻለም';

  @override
  String get aiGuideInputHint => 'ጥያቄ ይጠይቁ...';

  @override
  String get aiGuideGreeting => 'ስለ መመሪያዎችዎ ማንኛውንም ነገር ይጠይቁ';

  @override
  String get aiGuideNewChat => 'አዲስ ውይይት';

  @override
  String get aiGuideStreamError => 'የሆነ ችግር ተከስቷል። እንደገና ለመሞከር ይንኩ።';

  @override
  String get loginSubtitle => 'ለመግባት ይመዝገቡ';

  @override
  String get emailOrUsername => 'ኢሜይል ወይም የተጠቃሚ ስም';

  @override
  String get emailOrUsernameHint => 'ኢሜይልዎን ወይም የተጠቃሚ ስምዎን ያስገቡ';

  @override
  String get passwordHint => 'ይለፍ ቃልዎን ያስገቡ';

  @override
  String get errorInvalidCredentials => 'የተሳሳተ ኢሜይል ወይም ይለፍ ቃል';

  @override
  String get errorEmailInUse => 'ኢሜይል ቀድሞ ጥቅም ላይ ውሏል';

  @override
  String get errorGeneric => 'ስህተት ተከስቷል';

  @override
  String get errorOAuthFailed => 'OAuth መግባት አልተሳካም';

  @override
  String get errorOAuthUnavailable => 'OAuth አገልግሎት አይገኝም';

  @override
  String get errorOAuthCallbackInvalid => 'ልክ ያልሆነ OAuth ጥሪ';

  @override
  String get errorOAuthExpired => 'OAuth ክፍለ ጊዜ ጊዜው አልፏል፣ እንደገና ይሞክሩ';

  @override
  String get errorOAuthUnsupported => 'የማይደገፍ OAuth አገልግሎት';

  @override
  String get errorOAuthCancelled => 'OAuth መግባት ተሰርዟል';

  @override
  String get createAccount => 'መለያ ይፍጠሩ';

  @override
  String get registerSubtitle => 'ለመጀመር ይመዝገቡ';

  @override
  String get firstNameHint => 'ስምዎን ያስገቡ';

  @override
  String get lastNameHint => 'የአባት ስምዎን ያስገቡ';

  @override
  String get emailHint => 'ኢሜይልዎን ያስገቡ';

  @override
  String get username => 'የተጠቃሚ ስም (አማራጭ)';

  @override
  String get usernameHint => 'የተጠቃሚ ስም ይምረጡ';

  @override
  String get registrationSuccessful => 'ምዝገባ ተሳክቷል';

  @override
  String get verifyEmail => 'ኢሜይልዎን ያረጋግጡ';

  @override
  String get otpSubtitle => 'ወደ ኢሜይልዎ የተላከውን ባለ 6-አሃዝ ኮድ ያስገቡ';

  @override
  String get otpCodeHint => 'እባክዎ ባለ 6-አሃዝ ኮዱን ያስገቡ';

  @override
  String get verify => 'አረጋግጥ';

  @override
  String get didNotReceiveCode => 'ኮዱ አልደረሰም?';

  @override
  String get resend => 'እንደገና ላክ';

  @override
  String resendIn(int seconds) {
    return 'በ $seconds ሰከንድ ውስጥ እንደገና ይላኩ';
  }

  @override
  String get errorInvalidOtp => 'ልክ ያልሆነ OTP ኮድ';

  @override
  String get languageEnglish => 'እንግሊዝኛ';

  @override
  String get languageAmharic => 'አማርኛ';

  @override
  String get completeBusinessProfile => 'የንግድ መገለጫ ያጠናቅቁ';

  @override
  String get continueOnboardingAnytime => 'ማስተዋወቂያውን በማንኛውም ጊዜ ይቀጥሉ';

  @override
  String get plan => 'እቅድ';

  @override
  String get freePlan => 'ነጻ እቅድ';

  @override
  String activeUntil(String date) {
    return 'እስከ $date ድረስ ንቁ';
  }

  @override
  String get pro => 'ፕሮ';

  @override
  String get basic => 'መሰረታዊ';

  @override
  String get skipForNow => 'ለአሁን ዝለል';

  @override
  String get saving => 'በማስቀመጥ ላይ...';

  @override
  String get errorSaveFailed => 'የንግድ መገለጫውን ማስቀመጥ አልተሳካም። እንደገና ይሞክሩ';

  @override
  String get unableToDisplayProfile => 'የመገለጫ ውሂብ ማሳየት አልተቻለም';

  @override
  String get pleaseTryLoadingAgain => 'እባክዎ መገለጫዎን እንደገና ለመጫን ይሞክሩ';

  @override
  String get editAvatar => 'አምሳል ያስተካክሉ';

  @override
  String get profileDetails => 'የመገለጫ ዝርዝሮች';

  @override
  String get noBioYet => 'ገና የህይወት ታሪክ የለም';

  @override
  String get editProfile => 'መገለጫ ያስተካክሉ';

  @override
  String get bio => 'የህይወት ታሪክ';

  @override
  String get inbox => 'የገቢ መልዕክት';

  @override
  String get markAllRead => 'ሁሉንም እንደተነበበ ምልክት አድርግ';

  @override
  String get noNotifications => 'እስካሁን ምንም ማሳወቂያ የለም';

  @override
  String get timeNow => 'አሁን';

  @override
  String timeMinutesShort(int minutes) {
    return '$minutesደቂቃ';
  }

  @override
  String timeHoursShort(int hours) {
    return '$hoursሰአት';
  }

  @override
  String timeDaysShort(int days) {
    return '$daysቀን';
  }

  @override
  String citationSources(int count) {
    return 'ምንጮች ($count)';
  }

  @override
  String get citationUntitled => 'ርዕስ የሌለው ምንጭ';

  @override
  String citationMatch(String sourceType, int score) {
    return '$sourceType · $score% ተዛማጅ';
  }

  @override
  String get archiveConversationTitle => 'ውይይት አርክብ';

  @override
  String get archiveConversationContent =>
      'ይህ ውይይቱን ከታሪክዎ ያስወግዳል። ይህን መቀልበስ አይቻልም።';

  @override
  String get archiveConversationAction => 'አርክብ';

  @override
  String get languageLabelEn => 'EN';

  @override
  String get languageLabelAm => 'አማ';

  @override
  String get guide => 'መመሪያ';

  @override
  String get community => 'ማህበረሰብ';

  @override
  String get templates => 'አብነቶች';

  @override
  String get continueLastGuide => 'የመጨረሻውን መመሪያ ቀጥል';

  @override
  String get continueChat => 'ውይይት ቀጥል';

  @override
  String get guidePlaceholderSubtitle => 'የተመራ የመማሪያ መንገዶችን እና ምክሮችን ያስሱ።';

  @override
  String get templatesPlaceholderSubtitle =>
      'በፍጥነት ለመንቀሳቀስ ዝግጁ የሆኑ አብነቶችን ይጠቀሙ።';

  @override
  String get continueWhereYouLeftOff => 'በቆሙበት ቀጥል';

  @override
  String get dashboardEmptyMessage =>
      'እንኳን ደህና መጡ! ሂደትዎን ለማየት የመጀመሪያ መመሪያዎን ይጀምሩ።';

  @override
  String get quickActions => 'ፈጣን እርምጃዎች';

  @override
  String get monthlyCompletion => 'ወርሃዊ ማጠናቀቅ';

  @override
  String progressSummary(int completed, int inProgress) {
    return '$completed የተጠናቀቁ · $inProgress በሂደት ላይ';
  }

  @override
  String get notifications => 'ማሳወቂያዎች';

  @override
  String get myDownloads => 'የእኔ ውርዶች';

  @override
  String get searchTemplates => 'አብነቶችን ይፈልጉ...';

  @override
  String get noTemplatesFound => 'ምንም አብነቶች አልተገኙም';

  @override
  String get noDownloadsYet => 'እስካሁን ምንም ውርዶች የሉም';

  @override
  String downloadCount(int count) {
    return '$count ውርዶች';
  }

  @override
  String get categories => 'ምድቦች';

  @override
  String get showAll => 'ሁሉንም አሳይ';

  @override
  String get preview => 'ቅድመ እይታ';

  @override
  String get upgrade => 'አሻሽል';

  @override
  String get openInBrowser => 'በአሳሽ ውስጥ ክፈት';

  @override
  String get previewFailed => 'ቅድመ እይታ መክፈት አልተቻለም';

  @override
  String downloadedFile(String filename) {
    return '$filename ተወርዷል';
  }

  @override
  String downloadFailed(String message) {
    return 'ውርድ አልተሳካም: $message';
  }

  @override
  String get proTemplateTitle => 'ፕሮ አብነት';

  @override
  String get proTemplateDescription =>
      'ይህ አብነት በፕሮ ደንበኝነት ይገኛል። ለማውረድ እና ለመመልከት ያሻሽሉ።';

  @override
  String get upgradeToPro => 'ወደ ፕሮ አሻሽል';

  @override
  String get maybeLater => 'ምናልባት በኋላ';

  @override
  String get open => 'ክፈት';

  @override
  String failedToLoadPDF(String error) {
    return 'PDF መጫን አልተቻለም: $error';
  }

  @override
  String get templateDetails => 'የአብነት ዝርዝሮች';

  @override
  String get download => 'አውርድ';

  @override
  String get chooseYourPlan => 'እቅድዎን ይምረጡ';

  @override
  String get freeForever => 'ለዘላለም ነጻ';

  @override
  String get perMonth => '/ወር';

  @override
  String get perYear => '/ዓመት';

  @override
  String get proMonthly => 'ፕሮ ወርሃዊ';

  @override
  String get proYearly => 'ፕሮ ዓመታዊ';

  @override
  String get subscribe => 'ይመዝገቡ';

  @override
  String get currentPlan => 'አሁን ያለው እቅድ';

  @override
  String get mostPopular => 'በጣም ታዋቂ';

  @override
  String get youAreOnPro => 'በፕሮ ላይ ነዎት';

  @override
  String savePercentYearly(int percent) {
    return 'በዓመታዊ ክፍያ $percent% ይቆጥቡ';
  }

  @override
  String get billingDisclaimer => 'ክፍያዎች በ ETB ይከፈላሉ። በማንኛውም ጊዜ መሰረዝ ይችላሉ።';

  @override
  String get planFeatureAllGuides => 'ሁሉንም መመሪያዎች ማግኘት';

  @override
  String get planFeatureCommunity => 'የማህበረሰብ ማንበብ-ብቻ መዳረሻ';

  @override
  String get planFeatureAiQuestions => 'በወር 3 AI ጥያቄዎች';

  @override
  String get planFeatureEverythingBasic => 'ሁሉም በመሰረታዊ ውስጥ';

  @override
  String get planFeatureUnlimitedAi => 'ያልተገደበ AI ጥያቄዎች';

  @override
  String get planFeatureTemplates => 'የአብነት ውርዶች';

  @override
  String get planFeatureSupport => 'ቅድሚያ የማህበረሰብ ድጋፍ';

  @override
  String get planFeatureAdvancedProfile => 'የላቀ የንግድ መገለጫ';

  @override
  String get openingSecurePayment => 'ደህንነቱ የተጠበቀ ክፍያ በመክፈት ላይ...';

  @override
  String get paymentCancelled => 'ክፍያ ተሰርዟል';

  @override
  String get verifyingPayment => 'ክፍያዎን በማረጋገጥ ላይ...';

  @override
  String get noVerificationResult => 'ምንም የማረጋገጫ ውጤት የለም';

  @override
  String get paymentSuccessful => 'ክፍያ ተሳክቷል';

  @override
  String get proPlanActive => 'የፕሮ እቅድዎ አሁን ንቁ ነው።';

  @override
  String get paymentProcessing => 'ክፍያ በሂደት ላይ';

  @override
  String get paymentBeingProcessed => 'ክፍያዎ በባንክዎ እየተሰራ ነው። ትንሽ ጊዜ ሊወስድ ይችላል።';

  @override
  String get paymentFailed => 'ክፍያ አልተሳካም';

  @override
  String get couldNotCompletePayment => 'ክፍያዎ ሊጠናቀቅ አልቻለም።';

  @override
  String get tryAgain => 'እንደገና ሞክር';

  @override
  String get backToHome => 'ወደ መነሻ ተመለስ';

  @override
  String failedToLoadPlans(String error) {
    return 'እቅዶችን መጫን አልተቻለም: $error';
  }

  @override
  String get failedToLoadFilters => 'ማጣሪያዎችን መጫን አልተቻለም';

  @override
  String get guideSearchHint => 'መመሪያዎችን ይፈልጉ...';

  @override
  String get guideFiltered => 'ተጣርቷል';

  @override
  String get guideClearAll => 'ሁሉንም አጽዳ';

  @override
  String get guideBookmarked => 'ዕልባት ተሰጥቶታል';

  @override
  String get guideNoGuidesFound => 'ምንም መመሪያዎች አልተገኙም';

  @override
  String get guideNoBookmarks => 'እስካሁን ምንም ዕልባቶች የሉም';

  @override
  String get guideRecentlyViewed => 'በቅርብ የታዩ';

  @override
  String get guideRecent => 'የቅርብ';

  @override
  String guideProgressOf(int completed, int total) {
    return '$completed ከ $total የተጠናቀቁ';
  }

  @override
  String guideProgressPercent(int percent) {
    return '$percent%';
  }

  @override
  String guideSectorCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ዘርፎች',
      one: '1 ዘርፍ',
    );
    return '$_temp0';
  }

  @override
  String guideTagCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count መለያዎች',
      one: '1 መለያ',
    );
    return '$_temp0';
  }

  @override
  String stepEstimatedTime(String minutes) {
    return '~$minutes ደቂቃ';
  }

  @override
  String get stepNoContent => 'ለዚህ ደረጃ ምንም ይዘት የለም';

  @override
  String get stepRequiredDocuments => 'የሚያስፈልጉ ሰነዶች';

  @override
  String get stepChecklist => 'የምርመራ ዝርዝር';

  @override
  String get stepProTip => 'የግል ምክር';

  @override
  String get stepStatusCompleted => 'ተጠናቋል';

  @override
  String get stepStatusInProgress => 'በሂደት ላይ';

  @override
  String get stepStatusSkipped => 'ተዝሏል';

  @override
  String get stepStatusLocked => 'ተቆልፏል';

  @override
  String get stepStart => 'ደረጃ ጀምር';

  @override
  String get stepComplete => 'ደረጃ አጠናቅቅ';

  @override
  String get stepSkip => 'ዝለል';

  @override
  String get stepMarkIncomplete => 'ያልተጠናቀቀ ምልክት አድርግ';

  @override
  String get stepAddBookmark => 'ዕልባት አክል';

  @override
  String get stepRemoveBookmark => 'ዕልባት አስወግድ';

  @override
  String get communityForYou => 'ለእርስዎ';

  @override
  String get communityAll => 'ሁሉም';

  @override
  String get searchThreads => 'ክሮችን ይፈልጉ...';

  @override
  String noThreadsFound(String query) {
    return '\"$query\" የሚል ክሮች አልተገኙም';
  }

  @override
  String get noThreadsAvailable => 'እስካሁን ምንም ክሮች የሉም';

  @override
  String get noPersonalizedThreads => 'እስካሁን ምንም የግል የተደረጉ ክሮች የሉም';

  @override
  String threadReplies(int count) {
    return '$count ምላሾች';
  }

  @override
  String threadViews(int count) {
    return '$count እይታዎች';
  }

  @override
  String get owned => 'የባለቤትነት';

  @override
  String get solved => 'ተፈቷል';

  @override
  String get followed => 'የተከተሉ';

  @override
  String get moreFilters => 'ተጨማሪ ማጣሪያዎች';

  @override
  String get filters => 'ማጣሪያዎች';

  @override
  String get reset => 'ዳግም አስጀምር';

  @override
  String get searchSectorsTags => 'ዘርፎችን እና መለያዎችን ይፈልጉ...';

  @override
  String get sectors => 'ዘርፎች';

  @override
  String get tags => 'መለያዎች';

  @override
  String get followedOnly => 'የተከተሉት ብቻ';

  @override
  String get showFollowedOnly => 'የሚከተሏቸውን ክሮች ብቻ አሳይ';

  @override
  String get noItemsMatchSearch => 'ከፍለጋዎ ጋር የሚዛመድ ምንም ነገር የለም';

  @override
  String errorLoadingThreads(String error) {
    return 'ክሮችን በመጫን ላይ ስህተት: $error';
  }

  @override
  String get createThread => 'ክር ይፍጠሩ';

  @override
  String get post => 'ለጥፍ';

  @override
  String get title => 'ርዕስ';

  @override
  String get titleRequired => 'ርዕስ ያስፈልጋል';

  @override
  String minChars(int count) {
    return 'ቢያንስ $count ቁምፊዎች';
  }

  @override
  String get initialPost => 'የመጀመሪያ ልጥፍ';

  @override
  String get postRequired => 'ልጥፍ ያስፈልጋል';

  @override
  String get addImages => 'ምስሎችን አክል';

  @override
  String get addFiles => 'ፋይሎችን አክል';

  @override
  String get sectorsOptional => 'ዘርፎች (አማራጭ)';

  @override
  String get tagsOptional => 'መለያዎች (አማራጭ)';

  @override
  String get deletePost => 'ልጥፍ ሰርዝ';

  @override
  String get confirmDeletePost => 'እርግጠኛ ነዎት ይህን ልጥፍ መሰረዝ ይፈልጋሉ?';

  @override
  String get postDeleted => 'ልጥፍ በተሳካ ሁኔታ ተሰርዟል';

  @override
  String get markAsSolution => 'እንደ መፍትሄ ምልክት አድርግ';

  @override
  String get confirmMarkSolution => 'ይህን ልጥፍ እንደ ተቀባይነት ያለው መፍትሄ ምልክት አድርግ?';

  @override
  String get mark => 'ምልክት አድርግ';

  @override
  String get markedAsSolution => 'እንደ መፍትሄ ምልክት ተደርጓል';

  @override
  String get deleteThread => 'ክር ሰርዝ';

  @override
  String get confirmDeleteThread =>
      'እርግጠኛ ነዎት ይህን ክር መሰረዝ ይፈልጋሉ? ይህ ተግባር መቀልበስ አይቻልም።';

  @override
  String get threadDeleted => 'ክር በተሳካ ሁኔታ ተሰርዟል';

  @override
  String get followThread => 'ክር ተከተል';

  @override
  String get unfollowThread => 'ክር መከታተል አቁም';

  @override
  String get followingThread => 'ክር እየተከተሉ ነው';

  @override
  String get unfollowedThread => 'ክር መከታተል አቁመዋል';

  @override
  String get editThread => 'ክር አስተካክል';

  @override
  String get reportThread => 'ክር ሪፖርት አድርግ';

  @override
  String get noRepliesYet => 'እስካሁን ምላሽ የለም። የመጀመሪያ ይሁኑ!';

  @override
  String get reply => 'ምላሽ';

  @override
  String get saveToGallery => 'ወደ ማዕከለ-ስዕላት አስቀምጥ';

  @override
  String get imageSaved => 'ምስል ወደ ማዕከለ-ስዕላት ተቀምጧል!';

  @override
  String get report => 'ሪፖርት';

  @override
  String get selectReason => 'ምክንያት ይምረጡ:';

  @override
  String get reasonLabel => 'ምክንያት';

  @override
  String get reasonRequired => 'እባክዎን ምክንያት ያስገቡ';

  @override
  String get reasonSpam => 'አይፈለጌ መልዕክት';

  @override
  String get reasonHarassment => 'ትንኮሳ';

  @override
  String get reasonInappropriate => 'አግባብ ያልሆነ ይዘት';

  @override
  String get reasonMisinformation => 'የተሳሳተ መረጃ';

  @override
  String get reasonOther => 'ሌላ';

  @override
  String get submitReport => 'ሪፖርት አስገባ';

  @override
  String reportedSuccessfully(String type) {
    return '$type በተሳካ ሁኔታ ሪፖርት ተደርጓል';
  }

  @override
  String get reasonHint => 'ለምን ይህን እንደሚያሪፖርቱ ይግለጹ...';

  @override
  String get editingPost => 'ልጥፍ በማስተካከል ላይ';

  @override
  String replyingTo(String name) {
    return 'ለ$name ምላሽ በመስጠት ላይ';
  }

  @override
  String get newPost => 'አዲስ ልጥፍ';

  @override
  String get updateYourPost => 'ልጥፍዎን ያዘምኑ...';

  @override
  String get writeYourReply => 'ምላሽዎን ይፃፉ...';

  @override
  String get writeAPost => 'ልጥፍ ይፃፉ...';

  @override
  String newAttachments(int count) {
    return 'አዲስ አባሪዎች ($count):';
  }

  @override
  String existingAttachments(int count) {
    return 'ነባር አባሪዎች ($count):';
  }

  @override
  String get removeAll => 'ሁሉንም አስወግድ';

  @override
  String get attachmentsRemovedOnUpdate => 'አባሪዎች ሲዘምን ይወገዳሉ';

  @override
  String get undoRemove => 'መወገድን ቀልብስ';

  @override
  String get removeThisAttachment => 'ይህን አባሪ አስወግድ';

  @override
  String get postUpdated => 'ልጥፍ በተሳካ ሁኔታ ተዘምኗል';

  @override
  String get imageSavedToGallery => 'ምስል ወደ ጋለሪ ተቀምጧል!';

  @override
  String get failedToLoadImage => 'ምስል መጫን አልተቻለም';

  @override
  String failedToDeletePost(String error) {
    return 'ማጥፋት አልተቻለም: $error';
  }

  @override
  String failedToMarkSolution(String error) {
    return 'መፍትሄ ምልክት ማድረግ አልተቻለም: $error';
  }

  @override
  String failedWithError(String error) {
    return 'አልተሳካም: $error';
  }

  @override
  String get oAuthCompletionTitle => 'ምዝገባዎን ያጠናቅቁ';

  @override
  String oAuthCompletionSubtitle(String provider) {
    return 'በ$provider ለመግባት ኢሜይል ያክሉ።';
  }

  @override
  String oAuthCompletionSignedInAs(String name) {
    return 'እንደ $name ገብተዋል';
  }

  @override
  String oAuthCompletionProviderSubject(String subject) {
    return 'የአቅራቢ ርዕሰ ጉዳይ: $subject';
  }

  @override
  String get oAuthFinishingSignIn => 'ምዝገባን በማጠናቀቅ ላይ...';

  @override
  String get oAuthNoCompletionRequest => 'ምንም የOAuth ኢሜይል ማጠናቀቂያ ጥያቄ አልተገኘም።';

  @override
  String get oAuthBackToLogin => 'ወደ መግቢያ ተመለስ';

  @override
  String get completeYourBusinessProfile => 'የንግድ መገለጫዎን ያጠናቅቁ';

  @override
  String get unlockPersonalizedGuidance => 'ለግል የተበጀ መመሪያ እና የተሻለ ምክረ ሀሳብ ያግኙ።';

  @override
  String get noInternetConnection => 'የበይነመረብ ግንኙነት የለም';

  @override
  String get filterNoResults => 'ከፍለጋዎ ጋር የሚዛመድ ምንም ነገር የለም';

  @override
  String get attachments => 'አባሪዎች';

  @override
  String get removeThis => 'ይህን አስወግድ';

  @override
  String get inboxTab => 'ገቢ መልዕክት';

  @override
  String get scheduledTab => 'የተቀጠሩ';

  @override
  String get compliance => 'ህግና ደንብ';

  @override
  String get inboxEmpty => 'የገቢ መልዕክት ሳጥንዎ ባዶ ነው';

  @override
  String get complianceAutoTracked => 'በራስ-ሰር የሚከታተሉ';

  @override
  String get complianceManual => 'በእጅ የሚገቡ';

  @override
  String get complianceNoEntries => 'እስካሁን ምንም የህግና ደንብ መረጃ አልገባም';

  @override
  String get complianceAutoTrackedDesc =>
      'የንግድ መገለጫዎ ላይ የግብር ከፋይ መለያ ቁጥር (TIN)፣ ፈቃድ ወይም የምዝገባ ቁጥሮችን ሲያክሉ በራስ-ሰር የሚከታተሉ መረጃዎች እዚህ ይታያሉ።';

  @override
  String get businessProfileRequired => 'የንግድ መገለጫ ያስፈልጋል';

  @override
  String get complianceCreateProfileDesc =>
      'የህግና ደንብ ማጠናቀቂያ ቀናትን ለመከታተል መጀመሪያ የንግድ መገለጫዎን ይፍጠሩ።';

  @override
  String get createBusinessProfile => 'የንግድ መገለጫ ፍጠር';

  @override
  String get expires => 'የሚያበቃው፦ ';

  @override
  String get autoGenerated => 'በራስ-ሰር የተፈጠረ';

  @override
  String get addComplianceEntry => 'የህግና ደንብ መረጃ አክል';

  @override
  String get referenceNumber => 'የማጣቀሻ ቁጥር';

  @override
  String get enterReferenceNumber => 'የማጣቀሻ ቁጥር ያስገቡ';

  @override
  String get expiryDate => 'የማበቂያ ቀን';

  @override
  String get remindBeforeDays => 'ከስንት ቀን በፊት ያስታውስዎት (በቀናት)';

  @override
  String get complianceEntry => 'የህግና ደንብ መረጃ';

  @override
  String get entryNotFound => 'መረጃው አልተገኘም';

  @override
  String get autoGeneratedFromProfile => 'ከንግድ መገለጫዎ በራስ-ሰር የተፈጠረ';

  @override
  String get complianceType => 'የህግና ደንብ ዓይነት';

  @override
  String get notSet => 'አልተመረጠም';

  @override
  String get noUpcomingDeadlines => 'የሚመጡ ማጠናቀቂያ ቀናት የሉም';

  @override
  String get complianceAddEntriesDesc => 'ከንግድ መገለጫዎ ላይ የህግና ደንብ መረጃዎችን ያክሉ';

  @override
  String get manageCompliance => 'ህግና ደንብን ያስተዳድሩ';

  @override
  String get upcoming => 'የሚመጡ';

  @override
  String get manage => 'ያስተዳድሩ';

  @override
  String get currentPassword => 'አሁን ያለ ይለፍ ቃል';

  @override
  String get newPassword => 'አዲስ ይለፍ ቃል';

  @override
  String get changePassword => 'ይለፍ ቃል ይቀይሩ';

  @override
  String get passwordUpdated => 'ይለፍ ቃል በተሳካ ሁኔታ ተቀይሯል';

  @override
  String get errorPasswordChangeFailed => 'ይለፍ ቃል መቀየር አልተሳካም';

  @override
  String get scheduledAlerts => 'የተቀጠሩ ማሳሰቢያዎች';

  @override
  String get remaining => 'የቀረው';

  @override
  String get complianceCalendar => 'የህግና ደንብ የቀን መቁጠሪያ';

  @override
  String get seeAll => 'ሁሉንም ይዩ';

  @override
  String get upgradeToProDesc =>
      'የተቀጠሩ ማሳሰቢያዎች ገደብ (3) ላይ ደርሰዋል። ያልተገደቡ ማሳሰቢያዎችን ለማግኘት ወደ ፕሮ ያሳድጉ።';

  @override
  String get viewPlans => 'እቅዶችን ይመልከቱ';

  @override
  String get newScheduledAlert => 'አዲስ የተቀጠረ ማሳሰቢያ';

  @override
  String get template => 'አብነት (Template)';

  @override
  String get noneCustom => 'የለም (ብጁ)';

  @override
  String get bodyField => 'ዝርዝር መግለጫ';

  @override
  String get bodyRequired => 'ዝርዝር መግለጫ ማስገባት ግዴታ ነው';

  @override
  String get channels => 'ማሳወቂያ መንገዶች';

  @override
  String get inAppChannel => 'በመተግበሪያው ውስጥ';

  @override
  String get pushChannel => 'በስልክ ማሳወቂያ (Push)';

  @override
  String freeUserAlertCount(int count) {
    return 'ለነፃ ተጠቃሚዎች፦ ከ3ቱ ውስጥ $count ጥቅም ላይ ውሏል';
  }

  @override
  String get noScheduledAlerts => 'እስካሁን ምንም የተቀጠሩ ማሳሰቢያዎች የሉም';

  @override
  String get tapToCreate => 'አንድ ለመፍጠር + ምልክቱን ይጫኑ';

  @override
  String get pending => 'በጥበቃ ላይ';

  @override
  String get sent => 'ተልኳል';

  @override
  String get cancelledStatus => 'ተሰርዟል';

  @override
  String get reschedule => 'ቀጠሮ ቀይር';

  @override
  String get overdue => 'ቀን ያለፈበት';

  @override
  String get tomorrow => 'ነገ';

  @override
  String get complianceCreated => 'የህግና ደንብ መረጃው ተፈጥሯል';

  @override
  String get complianceUpdated => 'የህግና ደንብ መረጃው ተሻሽሏል';

  @override
  String get complianceDeleted => 'የህግና ደንብ መረጃው ተሰርዟል';

  @override
  String get complianceUnableToCreate => 'የህግና ደንብ መረጃውን መፍጠር አልተቻለም';

  @override
  String get complianceUnableToUpdate => 'የህግና ደንብ መረጃውን ማሻሻል አልተቻለም';

  @override
  String get complianceUnableToDelete => 'የህግና ደንብ መረጃውን መሰረዝ አልተቻለም';

  @override
  String get complianceNotFound => 'የህግና ደንብ መረጃው አልተገኘም';

  @override
  String get unableToCreateAlert => 'ማሳሰቢያውን መፍጠር አልተቻለም';

  @override
  String get unableToCancelAlert => 'ማሳሰቢያውን መሰረዝ አልተቻለም';

  @override
  String get unableToRescheduleAlert => 'የማሳሰቢያውን ቀጠሮ መቀየር አልተቻለም';

  @override
  String get maxLimitReached => 'ከ3 በላይ የተቀጠሩ ማሳሰቢያዎችን ለመፍጠር ወደ ፕሮ (Pro) ያሳድጉ';

  @override
  String get scheduledAlertNotFound => 'የተቀጠረው ማሳሰቢያ አልተገኘም';

  @override
  String get notificationPreferences => 'የማሳወቂያ ምርጫዎች';

  @override
  String get emailNotifications => 'የኢሜይል ማሳወቂያዎች';

  @override
  String get pushNotifications => 'የግፋ ማሳወቂያዎች';

  @override
  String get inAppAlwaysOn => 'ሁልጊዜ ነቅቷል';

  @override
  String get businessProfile => 'የንግድ መገለጫ';

  @override
  String get manageBusinessDetails => 'የንግድ ዝርዝሮችዎን ያስተዳድሩ';

  @override
  String get companyName => 'የኩባንያ ስም';

  @override
  String get companyEmail => 'የኩባንያ ኢሜይል';

  @override
  String get companyPhone => 'የኩባንያ ስልክ';

  @override
  String get physicalAddress => 'አካላዊ አድራሻ';

  @override
  String get businessDescription => 'መግለጫ';

  @override
  String get complianceInfo => 'የተገዢነት መረጃ';

  @override
  String get registrationNumber => 'የምዝገባ ቁጥር';

  @override
  String get taxIdentificationNumber => 'የግብር መታወቂያ ቁጥር';

  @override
  String get tradeLicenseNumber => 'የንግድ ፍቃድ ቁጥር';

  @override
  String get businessProfileUpdated => 'የንግድ መገለጫ ተዘምኗል';

  @override
  String get logo => 'አርማ';

  @override
  String get banner => 'ባነር';

  @override
  String get changeLogo => 'አርማ ቀይር';

  @override
  String get changeBanner => 'ባነር ቀይር';
}
