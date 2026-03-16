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
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count days ago', one: '1 day ago');
    return '$_temp0';
  }

  @override
  String hoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count hours ago', one: '1 hour ago');
    return '$_temp0';
  }

  @override
  String minutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(count, locale: localeName, other: '$count minutes ago', one: '1 minute ago');
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
}
