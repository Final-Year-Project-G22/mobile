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
}
