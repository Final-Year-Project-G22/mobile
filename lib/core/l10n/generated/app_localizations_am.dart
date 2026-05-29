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
  String get register => 'ተመዝገብ';

  @override
  String get email => 'ኢሜይል';

  @override
  String get password => 'ይለፍ ቃል';

  @override
  String get confirmPassword => 'ይለፍ ቃል ያረጋግጡ';

  @override
  String get firstName => 'ስም';

  @override
  String get lastName => 'የአባት ስም';

  @override
  String get phone => 'ስልክ ቁጥር';

  @override
  String get forgotPassword => 'ይለፍ ቃልዎን ረሱ?';

  @override
  String get dontHaveAccount => 'አዲስ ነዎት? መለያ ይፍጠሩ';

  @override
  String get alreadyHaveAccount => 'ቀድሞውኑ አባል ነዎት? ይግቡ';

  @override
  String get signUp => 'ይመዝገቡ';

  @override
  String get signIn => 'ይግቡ';

  @override
  String get profile => 'መገለጫ';

  @override
  String get settings => 'ቅንብሮች';

  @override
  String get home => 'መነሻ';

  @override
  String get search => 'ፈልግ';

  @override
  String get searchHint => 'ይፈልጉ...';

  @override
  String get cancel => 'ተው';

  @override
  String get save => 'አስቀምጥ';

  @override
  String get delete => 'አስወግድ';

  @override
  String get edit => 'አስተካክል';

  @override
  String get done => 'ተጠናቋል';

  @override
  String get next => 'ቀጣይ';

  @override
  String get back => 'ተመለስ';

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
  String get no => 'አይደለም';

  @override
  String get ok => 'እሺ';

  @override
  String get loading => 'በመጫን ላይ...';

  @override
  String get pleaseWait => 'እባክዎ ይጠብቁ...';

  @override
  String get error => 'ስህተት';

  @override
  String get success => 'ተሳክቷል';

  @override
  String get warning => 'ማስጠንቀቂያ';

  @override
  String get info => 'መረጃ';

  @override
  String get errorNetwork => 'ከበይነመረብ ውጪ ነዎት። ግንኙነትዎን ፈትሸው እንደገና ይሞክሩ።';

  @override
  String get errorServer =>
      'በእኛ በኩል የተፈጠረ ችግር አለ። እየገነባነው ስለሆነ በቅርቡ እንደገና ይሞክሩ።';

  @override
  String get errorUnknown => 'ያልተጠበቀ ስህተት አጋጥሟል። እባክዎ እንደገና ይሞክሩ።';

  @override
  String get errorTimeout => 'ጥያቄው ብዙ ጊዜ ወስዷል። ግንኙነትዎን ፈትሸው እንደገና ይሞክሩ።';

  @override
  String get errorUnauthorized => 'የቆይታ ጊዜዎ አልቋል። እባክዎ እንደገና ይግቡ።';

  @override
  String get errorValidation => 'የሆነ ስህተት አለ። እባክዎ ያስገቡትን መረጃ ይፈትሹ።';

  @override
  String get confirmDelete => 'ይህን ማጥፋት ይፈልጋሉ? ድርጊቱን መመለስ አይቻልም።';

  @override
  String get confirmLogout => 'ለመውጣት እርግጠኛ ነዎት? በማንኛውም ጊዜ መመለስ ይችላሉ።';

  @override
  String get confirm => 'አረጋግጥ';

  @override
  String get noData => 'ምንም መረጃ የለም';

  @override
  String get noResults => 'ምንም ውጤት አልተገኘም';

  @override
  String get pullToRefresh => 'ለማደስ ወደ ታች ይጎትቱ';

  @override
  String get loadingMore => 'ተጨማሪ በመጫን ላይ...';

  @override
  String get all => 'ሁሉም';

  @override
  String get none => 'ምንም';

  @override
  String get select => 'ምረጥ';

  @override
  String get selected => 'ተመርጧል';

  @override
  String get required => 'ይህ መስክ መሞላት አለበት';

  @override
  String get invalidEmail => 'ትክክለኛ ኢሜይል ያስገቡ';

  @override
  String get invalidPhone => 'ትክክለኛ ስልክ ቁጥር ያስገቡ';

  @override
  String get passwordTooShort => 'ይለፍ ቃል ቢያንስ 8 ቁምፊዎች መሆን አለበት';

  @override
  String get passwordMismatch => 'ይለፍ ቃላቱ አይዛመዱም';

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
  String get thisWeek => 'በዚህ ሳምንት';

  @override
  String get language => 'ቋንቋ';

  @override
  String get theme => 'ገጽታ';

  @override
  String get darkMode => 'ጨለማ ሁነታ';

  @override
  String get lightMode => 'ብርሃን ሁነታ';

  @override
  String get systemDefault => 'የስርዓቱ ነባሪ';

  @override
  String get about => 'ስለ መተግበሪያው';

  @override
  String get version => 'ስሪት';

  @override
  String get privacyPolicy => 'የግላዊነት ፖሊሲ';

  @override
  String get termsOfService => 'የአገልግሎት ውሎች';

  @override
  String get contactSupport => 'ድጋፍ ያግኙ';

  @override
  String get rateApp => 'መተግበሪያውን ደረጃ ይስጡ';

  @override
  String get shareApp => 'መተግበሪያውን ያጋሩ';

  @override
  String get finish => 'ጨርስ';

  @override
  String get onboardingTitle => 'የመገለጫ ማዋቀር';

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
  String get onboardingDemoOptional => 'ይህ ምርጫ ነው — ካልፈለጉ መዝለል ይችላሉ።';

  @override
  String get aiGuideTitle => 'አዲሱ ዴጀንት';

  @override
  String get aiGuideConversations => 'ውይይቶች';

  @override
  String get aiGuideNoConversations => 'ውይይት ይጀምሩ — ስለ ቢዝነስዎ የሚፈልጉትን ይጠይቁ!';

  @override
  String get aiGuideConversationsError => 'ውይይቶችን መጫን አልተቻለም';

  @override
  String get aiGuideInputHint => 'ስለ ምዝገባ፣ ታክስ፣ ፍቃዶች ይጠይቁ...';

  @override
  String get voiceInput => 'የድምጽ ማስገቢያ';

  @override
  String get stopListening => 'ማዳመጥ አቁም';

  @override
  String get listening => 'እየሰማeni ነው...';

  @override
  String get speechNotAvailable => 'የድምጽ ማስተናገጅ በዚህ መሣሪያ ላይ አይገኝም';

  @override
  String get aiGuideGreeting =>
      'ሰላም! እኔ የቢዝነስ ረዳትዎ ነኝ። ስለ ንግድ ድርጅትዎ ህጋዊ ምዝገባ ማንኛውንም ነገር ይጠይቁኝ።';

  @override
  String get aiGuideNewChat => 'አዲስ ውይይት';

  @override
  String get aiGuideStreamError => 'የመስመር ግንኙነት ተቋርጧል። እንደገና ለመሞከር ይንኩ።';

  @override
  String get loginSubtitle => 'እንኳን ደህና መጡ! ለመቀጠል ይግቡ።';

  @override
  String get emailOrUsername => 'ኢሜይል ወይም የተጠቃሚ ስም';

  @override
  String get emailOrUsernameHint => 'ኢሜይልዎን ወይም የተጠቃሚ ስምዎን ያስገቡ';

  @override
  String get passwordHint => 'ይለፍ ቃልዎን ያስገቡ';

  @override
  String get errorInvalidCredentials =>
      'የተሳሳተ ኢሜይል ወይም ይለፍ ቃል አቅርበዋል። እባክዎ እንደገና ይሞክሩ።';

  @override
  String get errorEmailInUse => 'ይህ ኢሜይል ቀድሞ ጥቅም ላይ ውሏል';

  @override
  String get errorGeneric => 'ስህተት ተከስቷል';

  @override
  String get errorOAuthFailed => 'በማህበራዊ ድረ-ገጽ መግባት አልተሳካም';

  @override
  String get errorOAuthUnavailable => 'የማህበራዊ ድረ-ገጽ መግቢያ አገልግሎት አሁን አይገኝም';

  @override
  String get errorOAuthCallbackInvalid => 'ልክ ያልሆነ የማረጋገጫ ጥሪ';

  @override
  String get errorOAuthExpired => 'የክፍለ ጊዜው ጊዜ አልፏል፣ እባክዎ እንደገና ይሞክሩ';

  @override
  String get errorOAuthUnsupported => 'ይህ የማህበራዊ ድረ-ገጽ መግቢያ አይደገፍም';

  @override
  String get errorOAuthCancelled => 'የማህበራዊ ድረ-ገጽ መግቢያው ተሰርዟል';

  @override
  String get createAccount => 'የአባልነት መለያ ይፍጠሩ';

  @override
  String get registerSubtitle => 'ከአዲሱ ጋር ይቀላቀሉና የንግድ ጉዞዎን ይጀምሩ';

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
  String get registrationSuccessful => 'ምዝገባው ተሳክቷል';

  @override
  String get verifyEmail => 'ኢሜይልዎን እናረጋግጥ';

  @override
  String get otpSubtitle => 'ወደ ኢሜይልዎ የ6-አሃዝ ኮድ ልከናል';

  @override
  String get otpCodeHint => 'እባክዎ ባለ 6-አሃዝ ኮዱን ያስገቡ';

  @override
  String get verify => 'አረጋግጥ';

  @override
  String get didNotReceiveCode => 'ኮዱ አልደረሰዎትም?';

  @override
  String get resend => 'እንደገና ላክ';

  @override
  String resendIn(int seconds) {
    return 'በ $seconds ሰከንድ ውስጥ እንደገና ይላኩ';
  }

  @override
  String get errorInvalidOtp => 'ልክ ያልሆነ የኦቲፒ (OTP) ኮድ';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageAmharic => 'አማርኛ';

  @override
  String get completeBusinessProfile => 'የንግድ መገለጫዎን ያጠናቅቁ';

  @override
  String get continueOnboardingAnytime => 'የማስተዋወቂያ መመሪያውን በማንኛውም ጊዜ መቀጠል ይችላሉ';

  @override
  String get plan => 'እቅድ';

  @override
  String get freePlan => 'ነጻ እቅድ';

  @override
  String activeUntil(String date) {
    return 'እስከ $date ድረስ ንቁ';
  }

  @override
  String get pro => 'ፕሮ (Pro)';

  @override
  String get basic => 'መሰረታዊ';

  @override
  String get skipForNow => 'ለአሁን ዝለል';

  @override
  String get saving => 'በማስቀመጥ ላይ...';

  @override
  String get errorSaveFailed => 'መገለጫዎን ማስቀመጥ አልተቻለም። እባክዎ እንደገና ይሞክሩ።';

  @override
  String get unableToDisplayProfile => 'የመገለጫ መረጃን ማሳየት አልተቻለም';

  @override
  String get pleaseTryLoadingAgain => 'እባክዎ መገለጫዎን እንደገና ለመጫን ይሞክሩ';

  @override
  String get editAvatar => 'ምስል ይቀይሩ';

  @override
  String get profileDetails => 'የመገለጫ ዝርዝሮች';

  @override
  String get noBioYet => 'እስካሁን ምንም መግለጫ አልተጻፈም';

  @override
  String get editProfile => 'መገለጫ ያስተካክሉ';

  @override
  String get bio => 'ስለ እርስዎ';

  @override
  String get inbox => 'የገቢ መልዕክት';

  @override
  String get markAllRead => 'ሁሉንም እንደተነበበ ምልክት አድርግ';

  @override
  String get noNotifications => 'ሁሉንም አይተው ጨርሰዋል!';

  @override
  String get timeNow => 'አሁን';

  @override
  String timeMinutesShort(int minutes) {
    return '$minutesደቂቃ';
  }

  @override
  String timeHoursShort(int hours) {
    return '$hoursሰዓት';
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
      'ይህን ውይይት ወደ ማህደር ማስቀመጥ ይፈልጋሉ? ከታሪክዎ ውስጥ አይታይም።';

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
  String get guidePlaceholderSubtitle => 'የተመሩ የትምህርት መንገዶችን እና ምክሮችን ያስሱ።';

  @override
  String get templatesPlaceholderSubtitle =>
      'ስራዎችን በፍጥነት ለማጠናቀቅ ዝግጁ የሆኑ አብነቶችን ይጠቀሙ።';

  @override
  String get continueWhereYouLeftOff => 'ከቆሙበት ቦታ ይቀጥሉ';

  @override
  String get dashboardEmptyMessage =>
      'እንኳን ደህና መጡ! ቢዝነስዎን በትክክለኛው መስመር ላይ ለማስጀመር የመጀመሪያ መመሪያዎን እዚህ ይጀምሩ።';

  @override
  String get quickActions => 'ፈጣን እርምጃዎች';

  @override
  String get monthlyCompletion => 'የዚህ ወር ሂደት';

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
  String get noTemplatesFound => 'ከፍለጋዎ ጋር የሚዛመድ ምንም አብነት አልተገኘም';

  @override
  String get noDownloadsYet => 'የሚያወርዷቸው አብነቶች እዚህ ይታያሉ። ለመጀመር ማውጫውን ይጎብኙ።';

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
  String get previewFailed => 'ቅድመ እይታውን መክፈት አልተቻለም። በምትኩ አውርደው ይሞክሩ።';

  @override
  String downloadedFile(String filename) {
    return '$filename ተወርዷል';
  }

  @override
  String downloadFailed(String message) {
    return 'ውርዱ አልተሳካም: $message';
  }

  @override
  String get proTemplateTitle => 'የፕሮ (Pro) አብነት';

  @override
  String get proTemplateDescription =>
      'ይህ አብነት በፕሮ ደንበኝነት ምዝገባ ብቻ የሚገኝ ነው። ለማውረድ እና ለመመልከት እቅድዎን ያሻሽሉ።';

  @override
  String get upgradeToPro => 'ወደ ፕሮ ያሳድጉ';

  @override
  String get maybeLater => 'ምናልባት ቆይቶ';

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
  String get youAreOnPro => 'የፕሮ ተጠቃሚ ነዎት';

  @override
  String savePercentYearly(int percent) {
    return 'በዓመታዊ ክፍያ $percent% ይቆጥቡ';
  }

  @override
  String get billingDisclaimer => 'ክፍያዎች በ ETB ይፈጸማሉ። በማንኛውም ጊዜ መሰረዝ ይችላሉ።';

  @override
  String get planFeatureAllGuides => 'ሁሉንም መመሪያዎች ማግኘት';

  @override
  String get planFeatureCommunity => 'የማህበረሰብ ማንበብ-ብቻ መዳረሻ';

  @override
  String get planFeatureAiQuestions => 'በወር 3 AI ጥያቄዎች';

  @override
  String get planFeatureEverythingBasic => 'ሁሉም በመሰረታዊ ውስጥ ያሉ';

  @override
  String get planFeatureUnlimitedAi => 'ያልተገደበ የAI ጥያቄዎች';

  @override
  String get planFeatureTemplates => 'ሁሉንም አብነቶች ማውረድ';

  @override
  String get planFeatureSupport => 'ቅድሚያ የሚሰጠው የድጋፍ አገልግሎት';

  @override
  String get planFeatureAdvancedProfile => 'የላቀ የንግድ መገለጫ ማስተዳደሪያ';

  @override
  String get openingSecurePayment => 'ደህንነቱ የተጠበቀ ክፍያ በመክፈት ላይ...';

  @override
  String get paymentCancelled => 'ክፍያው ተሰርዟል';

  @override
  String get verifyingPayment => 'ክፍያዎን በማረጋገጥ ላይ...';

  @override
  String get noVerificationResult => 'ምንም የማረጋገጫ ውጤት አልተገኘም';

  @override
  String get paymentSuccessful => 'ሁሉንም ነገር አዘናግተዋል! ክፍያው ተሳክቷል።';

  @override
  String get proPlanActive =>
      'የፕሮ (Pro) እቅድዎ አሁን ንቁ ሆኗል። ያልተገደበ አገልግሎት ማግኘት ይችላሉ!';

  @override
  String get paymentProcessing => 'ክፍያ በሂደት ላይ ነው';

  @override
  String get paymentBeingProcessed => 'ክፍያዎ በባንክዎ እየተሰራ ነው። ጥቂት ጊዜ ሊወስድ ይችላል።';

  @override
  String get paymentFailed => 'ክፍያው ሊጠናቀቅ አልቻለም';

  @override
  String get couldNotCompletePayment =>
      'በክፍያዎ ላይ የሆነ ችግር ተፈጥሯል። እባክዎ እንደገና ይሞክሩ።';

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
  String get guideFiltered => 'የተጣራ';

  @override
  String get guideClearAll => 'ሁሉንም አጽዳ';

  @override
  String get guideBookmarked => 'ዕልባት ተደርጓል';

  @override
  String get guideTabForYou => 'ለእርስዎ';

  @override
  String get guideTabAll => 'ሁሉም';

  @override
  String get guideNoGuidesFound =>
      'ከፍለጋዎ ጋር የሚዛመድ ምንም መመሪያ አልተገኘም። ሌሎች ቃላትን ይሞክሩ።';

  @override
  String get guideNoBookmarks =>
      'በኋላ ላይ ለማንበብ የሚፈልጓቸውን መመሪያዎች እዚህ ዕልባት አድርገው ያስቀምጡ።';

  @override
  String get guideRecentlyViewed => 'በቅርብ ጊዜ የታዩ';

  @override
  String get guideRecent => 'የቅርብ ጊዜ';

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
  String get stepProTip => 'ጠቃሚ ምክር';

  @override
  String get stepStatusCompleted => 'ተጠናቋል';

  @override
  String get stepStatusInProgress => 'በሂደት ላይ';

  @override
  String get stepStatusSkipped => 'የታለፈ';

  @override
  String get stepStatusLocked => 'የተቆለፈ';

  @override
  String get stepStart => 'ደረጃውን ጀምር';

  @override
  String get stepComplete => 'ደረጃውን አጠናቅቅ';

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
  String get searchThreads => 'ውይይቶችን ይፈልጉ...';

  @override
  String noThreadsFound(String query) {
    return 'ከ \"$query\" ጋር የሚዛመዱ የውይይት ርዕሶች አልተገኘም';
  }

  @override
  String get noThreadsAvailable =>
      'እስካሁን ምንም ውይይት የለም። የመጀመሪያውን ውይይት እርስዎ ይጀምሩ!';

  @override
  String get noPersonalizedThreads => 'እስካሁን ለእርስዎ የተበጁ ውይይቶች የሉም';

  @override
  String threadReplies(int count) {
    return '$count ምላሾች';
  }

  @override
  String threadViews(int count) {
    return '$count እይታዎች';
  }

  @override
  String get owned => 'የእኔ ውይይቶች';

  @override
  String get solved => 'የተፈቱ';

  @override
  String get followed => 'የምከተላቸው';

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
  String get followedOnly => 'የምከተላቸው ብቻ';

  @override
  String get showFollowedOnly => 'የምከተላቸውን ውይይቶች ብቻ አሳይ';

  @override
  String get noItemsMatchSearch => 'ከፍለጋዎ ጋር የሚዛመድ ምንም ነገር የለም';

  @override
  String errorLoadingThreads(String error) {
    return 'ውይይቶችን በመጫን ላይ ስህተት አጋጥሟል: $error';
  }

  @override
  String get createThread => 'አዲስ የውይይት ርዕስ ፍጠር';

  @override
  String get post => 'ለጥፍ';

  @override
  String get title => 'ርዕስ';

  @override
  String get titleRequired => 'ርዕስ ማስገባት ግዴታ ነው';

  @override
  String minChars(int count) {
    return 'ቢያንስ $count ቁምፊዎች መሆን አለበት';
  }

  @override
  String get initialPost => 'የመጀመሪያ ጽሑፍ';

  @override
  String get postRequired => 'የጽሑፍ ይዘት ያስፈልጋል';

  @override
  String get addImages => 'ምስሎች አክል';

  @override
  String get addFiles => 'ፋይሎች አክል';

  @override
  String get sectorsOptional => 'ዘርፎች (አማራጭ)';

  @override
  String get tagsOptional => 'መለያዎች (አማራጭ)';

  @override
  String get deletePost => 'ጽሑፉን አጥፋ';

  @override
  String get confirmDeletePost => 'እርግጠኛ ነዎት ይህንን ጽሑፍ መሰረዝ ይፈልጋሉ?';

  @override
  String get postDeleted => 'ጽሑፉ በተሳካ ሁኔታ ተሰርዟል';

  @override
  String get markAsSolution => 'እንደ ትክክለኛ መፍትሄ ምልክት አድርግ';

  @override
  String get confirmMarkSolution => 'ይህን ልጥፍ እንደ ተቀባይነት ያለው መፍትሄ ምልክት አድርግ?';

  @override
  String get mark => 'ምልክት አድርግ';

  @override
  String get markedAsSolution => 'መፍትሄ ሆኖ ተመርጧል';

  @override
  String get deleteThread => 'ውይይቱን አጥፋ';

  @override
  String get confirmDeleteThread =>
      'ይህን የውይይት ርዕስ መሰረዝ ይፈልጋሉ? ድርጊቱን መመለስ አይቻልም።';

  @override
  String get threadDeleted => 'የውይይት ርዕሱ በተሳካ ሁኔታ ተሰርዟል';

  @override
  String get followThread => 'ውይይቱን ተከታተል';

  @override
  String get unfollowThread => 'መከታተል አቁም';

  @override
  String get followingThread => 'ውይይቱን እየተከተሉ ነው';

  @override
  String get unfollowedThread => 'ውይይቱን መከታተል አቁመዋል';

  @override
  String get editThread => 'ውይይቱን አስተካክል';

  @override
  String get reportThread => 'ውይይቱን ሪፖርት አድርግ';

  @override
  String get noRepliesYet => 'እስካሁን ምንም ምላሽ የለም። የመጀመሪያው ምላሽ ሰጪ ይሁኑ!';

  @override
  String get reply => 'ምላሽ ስጥ';

  @override
  String get saveToGallery => 'ወደ ማዕከለ-ስዕላት አስቀምጥ';

  @override
  String get imageSaved => 'ምስሉ ወደ ማዕከለ-ስዕላት ተቀምጧል!';

  @override
  String get report => 'ሪፖርት';

  @override
  String get selectReason => 'ምክንያት ይምረጡ:';

  @override
  String get reasonLabel => 'ምክንያት';

  @override
  String get reasonRequired => 'እባክዎን ምክንያት ያስገቡ';

  @override
  String get reasonSpam => 'አይፈለጌ መልዕክት (Spam)';

  @override
  String get reasonHarassment => 'ትንኮሳ';

  @override
  String get reasonInappropriate => 'አግባብ ያልሆነ ይዘት';

  @override
  String get reasonMisinformation => 'የተሳሳተ መረጃ';

  @override
  String get reasonOther => 'ሌላ ምክንያት';

  @override
  String get submitReport => 'ሪፖርት አስገባ';

  @override
  String reportedSuccessfully(String type) {
    return '$type በተሳካ ሁኔታ ሪፖርት ተደርጓል';
  }

  @override
  String get reasonHint => 'ለምን ሪፖርት እንደሚያደርጉ እባክዎ ያብራሩ...';

  @override
  String get editingPost => 'ጽሑፉን በማስተካከል ላይ';

  @override
  String replyingTo(String name) {
    return 'ለ$name ምላሽ በመስጠት ላይ';
  }

  @override
  String get newPost => 'አዲስ ጽሑፍ';

  @override
  String get updateYourPost => 'ጽሑፍዎን ያዘምኑ...';

  @override
  String get writeYourReply => 'ምላሽዎን እዚህ ይጻፉ...';

  @override
  String get writeAPost => 'አንድ ነገር ይጻፉ...';

  @override
  String newAttachments(int count) {
    return 'አዲስ አባሪዎች ($count):';
  }

  @override
  String existingAttachments(int count) {
    return 'የነበሩ አባሪዎች ($count):';
  }

  @override
  String get removeAll => 'ሁሉንም አስወግድ';

  @override
  String get attachmentsRemovedOnUpdate => 'አባሪዎች ሲዘምኑ ይወገዳሉ';

  @override
  String get undoRemove => 'መወገድን ቀልብስ';

  @override
  String get removeThisAttachment => 'ይህን አባሪ አስወግድ';

  @override
  String get postUpdated => 'ጽሑፉ በተሳካ ሁኔታ ተዘምኗል';

  @override
  String get imageSavedToGallery => 'ምስሉ ወደ ማዕከለ-ስዕላት ተቀምጧል!';

  @override
  String get failedToLoadImage => 'ምስሉን መጫን አልተቻለም';

  @override
  String failedToDeletePost(String error) {
    return 'ማጥፋት አልተቻለም: $error';
  }

  @override
  String failedToMarkSolution(String error) {
    return 'መፍትሄ መሆኑን ምልክት ማድረግ አልተቻለም: $error';
  }

  @override
  String failedWithError(String error) {
    return 'አልተሳካም: $error';
  }

  @override
  String get oAuthCompletionTitle => 'ምዝገባዎን ያጠናቅቁ';

  @override
  String oAuthCompletionSubtitle(String provider) {
    return 'በ$provider ለመግባት እባክዎ ኢሜይልዎን ያክሉ።';
  }

  @override
  String oAuthCompletionSignedInAs(String name) {
    return 'እንደ $name ሆነው ገብተዋል';
  }

  @override
  String oAuthCompletionProviderSubject(String subject) {
    return 'የአቅራቢ መለያ: $subject';
  }

  @override
  String get oAuthFinishingSignIn => 'ምዝገባን በማጠናቀቅ ላይ...';

  @override
  String get oAuthNoCompletionRequest =>
      'ምንም የማህበራዊ ገጽ መግቢያ ማጠናቀቂያ ጥያቄ አልተገኘም።';

  @override
  String get oAuthBackToLogin => 'ወደ መግቢያ ተመለስ';

  @override
  String get completeYourBusinessProfile => 'የንግድ መገለጫዎን ያጠናቅቁ';

  @override
  String get unlockPersonalizedGuidance =>
      'ለግል የተበጀ መመሪያ እና የተሻሉ የንግድ ምክሮችን ያግኙ።';

  @override
  String get noInternetConnection => 'የበይነመረብ ግንኙነት የለም';

  @override
  String get filterNoResults => 'ከፍለጋዎ ጋር የሚዛመድ ምንም ነገር የለም';

  @override
  String get attachments => 'አባሪዎች';

  @override
  String get removeThis => 'ይህን አስወግድ';

  @override
  String get inboxTab => 'የገቢ መልዕክት';

  @override
  String get scheduledTab => 'የተቀጠሩ ቀናት';

  @override
  String get compliance => 'ህግና ደንብ';

  @override
  String get inboxEmpty => 'ሁሉም ነገር ንጹህ ነው! አዲስ መልዕክት የለም።';

  @override
  String get complianceAutoTracked => 'በራስ-ሰር የሚከታተሉ';

  @override
  String get complianceManual => 'በእጅ የሚገቡ';

  @override
  String get complianceNoEntries =>
      'እስካሁን የክትትል ቀናት አልተመዘገቡም። ለመጀመር የመጀመሪያ ተገዢነትዎን ያክሉ።';

  @override
  String get complianceAutoTrackedDesc =>
      'በንግድ መገለጫዎ ላይ የግብር ከፋይ መለያ ቁጥር (TIN) ወይም የምዝገባ ቁጥሮችን ሲያክሉ የሚከታተሉ መረጃዎች እዚህ ይታያሉ።';

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
  String get addComplianceEntry => 'የተገዢነት መረጃ አክል';

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
  String get complianceType => 'የተገዢነት ዓይነት';

  @override
  String get notSet => 'አልተመረጠም';

  @override
  String get noUpcomingDeadlines => 'በቅርብ የሚመጡ ማጠናቀቂያ ቀናት የሉም';

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
  String get complianceCalendar => 'የተገዢነት የቀን መቁጠሪያ';

  @override
  String get seeAll => 'ሁሉንም ይመልከቱ';

  @override
  String get upgradeToProDesc =>
      'የተቀጠሩ ማሳሰቢያዎች ገደብ (3) ላይ ደርሰዋል። ያልተገደቡ ማሳሰቢያዎችን ለማግኘት ወደ ፕሮ ያሳድጉ።';

  @override
  String get viewPlans => 'እቅዶችን ይመልከቱ';

  @override
  String get newScheduledAlert => 'አዲስ የተቀጠረ ማሳሰቢያ';

  @override
  String get template => 'አብነት';

  @override
  String get noneCustom => 'ብጁ ማሳሰቢያ';

  @override
  String get bodyField => 'ዝርዝር መግለጫ';

  @override
  String get bodyRequired => 'ዝርዝር መግለጫ ማስገባት ግዴታ ነው';

  @override
  String get channels => 'የማሳወቂያ መንገዶች';

  @override
  String get inAppChannel => 'በመተግበሪያው ውስጥ';

  @override
  String get pushChannel => 'የስልክ ላይ ማሳወቂያ (Push)';

  @override
  String freeUserAlertCount(int count) {
    return 'ከ3 ነፃ ማሳሰቢያዎች፦ $count ጥቅም ላይ ውሏል';
  }

  @override
  String get noScheduledAlerts =>
      'እስካሁን የተቀጠሩ ማሳሰቢያዎች የሉም። ቀነ-ገደቦችን እንዳያመልጥዎት ማሳሰቢያ ይቅጠሩ!';

  @override
  String get tapToCreate => 'አዲስ ለመፍጠር የ + ምልክቱን ይጫኑ';

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
  String get complianceCreated => 'የተገዢነት መረጃው ተፈጥሯል';

  @override
  String get complianceUpdated => 'የተገዢነት መረጃው ተሻሽሏል';

  @override
  String get complianceDeleted => 'የተገዢነት መረጃው ተሰርዟል';

  @override
  String get complianceUnableToCreate => 'መረጃውን መፍጠር አልተቻለም';

  @override
  String get complianceUnableToUpdate => 'መረጃውን ማሻሻል አልተቻለም';

  @override
  String get complianceUnableToDelete => 'መረጃውን መሰረዝ አልተቻለም';

  @override
  String get complianceNotFound => 'የተገዢነት መረጃው አልተገኘም';

  @override
  String get unableToCreateAlert => 'ማሳሰቢያውን መፍጠር አልተቻለም';

  @override
  String get unableToCancelAlert => 'ማሳሰቢያውን መሰረዝ አልተቻለም';

  @override
  String get unableToRescheduleAlert => 'የማሳሰቢያውን ቀጠሮ መቀየር አልተቻለም';

  @override
  String get maxLimitReached => 'ከ3 በላይ ማሳሰቢያዎችን ለመፍጠር እባክዎ ወደ ፕሮ (Pro) ያሳድጉ';

  @override
  String get scheduledAlertNotFound => 'የተቀጠረው ማሳሰቢያ አልተገኘም';

  @override
  String get notificationPreferences => 'የማሳወቂያ ምርጫዎች';

  @override
  String get emailNotifications => 'የኢሜይል ማሳወቂያዎች';

  @override
  String get pushNotifications => 'የስልክ ላይ (Push) ማሳወቂያዎች';

  @override
  String get inAppAlwaysOn => 'ሁልጊዜ የነቃ';

  @override
  String get businessProfile => 'የንግድ መገለጫ';

  @override
  String get manageBusinessDetails => 'የንግድ ዝርዝሮችዎን ያስተዳድሩ';

  @override
  String get companyName => 'የድርጅቱ ስም';

  @override
  String get companyEmail => 'የድርጅቱ ኢሜይል';

  @override
  String get companyPhone => 'የድርጅቱ ስልክ ቁጥር';

  @override
  String get physicalAddress => 'አድራሻ (ቦታ)';

  @override
  String get businessDescription => 'ስለ ድርጅቱ ማብራሪያ';

  @override
  String get complianceInfo => 'የተገዢነት መረጃ';

  @override
  String get sectorAndTags => 'የስектор እና ታጋሮች';

  @override
  String get selectSector => 'የንግድ ስектор ይምረጡ';

  @override
  String get selectTags => 'ተዛማጅ ታጋሮችን ይምረጡ';

  @override
  String get registrationNumber => 'የምዝገባ ቁጥር';

  @override
  String get taxIdentificationNumber => 'የግብር ከፋይ መለያ ቁጥር (TIN)';

  @override
  String get tradeLicenseNumber => 'የንግድ ፍቃድ ቁጥር';

  @override
  String get businessProfileUpdated => 'የንግድ መገለጫው ተዘምኗል';

  @override
  String get logo => 'አርማ (Logo)';

  @override
  String get banner => 'ባነር (Banner)';

  @override
  String get changeLogo => 'አርማ ቀይር';

  @override
  String get changeBanner => 'ባነር ቀይር';
}
