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
  String get forgotPassword => 'Forgot your password?';

  @override
  String get dontHaveAccount => 'New here? Create an account';

  @override
  String get alreadyHaveAccount => 'Already with us? Sign in';

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
  String get errorNetwork =>
      'You\'re offline. Check your connection and try again.';

  @override
  String get errorServer =>
      'Something\'s wrong on our end. We\'re fixing it — try again soon.';

  @override
  String get errorUnknown =>
      'Oops! Something unexpected happened. Please try again.';

  @override
  String get errorTimeout =>
      'That took too long. Check your connection and try again.';

  @override
  String get errorUnauthorized => 'Your session expired. Please sign in again.';

  @override
  String get errorValidation =>
      'Something doesn\'t look right. Please check your entries.';

  @override
  String get confirmDelete => 'Delete this? This can\'t be undone.';

  @override
  String get confirmLogout => 'Sign out? You can always come back.';

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
  String get onboardingTitle => 'Let\'s set up your profile';

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
  String get onboardingDemoOptional => 'This is optional — skip if you prefer.';

  @override
  String get aiGuideTitle => 'Adisu Agent';

  @override
  String get aiGuideConversations => 'Conversations';

  @override
  String get aiGuideNoConversations =>
      'Start a conversation — ask anything about your business!';

  @override
  String get aiGuideConversationsError => 'Couldn\'t load conversations';

  @override
  String get aiGuideInputHint => 'Ask about registration, taxes, licenses...';

  @override
  String get aiGuideGreeting =>
      'Hi! I\'m your business guide. Ask me anything about formalizing your business.';

  @override
  String get aiGuideNewChat => 'New Chat';

  @override
  String get aiGuideStreamError => 'Lost connection. Tap to try again.';

  @override
  String get loginSubtitle => 'Welcome back! Sign in to continue';

  @override
  String get emailOrUsername => 'Email or username';

  @override
  String get emailOrUsernameHint => 'Enter your email or username';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get errorInvalidCredentials =>
      'That email and password don\'t match. Try again.';

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
  String get createAccount => 'Create Your Account';

  @override
  String get registerSubtitle => 'Join Adisu and start your journey';

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
  String get verifyEmail => 'Let\'s verify your email';

  @override
  String get otpSubtitle => 'We sent a 6-digit code to your email';

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
      'We couldn\'t save your profile. Please try again.';

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

  @override
  String get inbox => 'Inbox';

  @override
  String get markAllRead => 'Mark all read';

  @override
  String get noNotifications => 'You\'re all caught up!';

  @override
  String get timeNow => 'now';

  @override
  String timeMinutesShort(int minutes) {
    return '${minutes}m';
  }

  @override
  String timeHoursShort(int hours) {
    return '${hours}h';
  }

  @override
  String timeDaysShort(int days) {
    return '${days}d';
  }

  @override
  String citationSources(int count) {
    return 'Sources ($count)';
  }

  @override
  String get citationUntitled => 'Untitled source';

  @override
  String citationMatch(String sourceType, int score) {
    return '$sourceType · $score% match';
  }

  @override
  String get archiveConversationTitle => 'Archive conversation';

  @override
  String get archiveConversationContent =>
      'Archive this conversation? You won\'t see it in your history.';

  @override
  String get archiveConversationAction => 'Archive';

  @override
  String get languageLabelEn => 'EN';

  @override
  String get languageLabelAm => 'አማ';

  @override
  String get guide => 'Guide';

  @override
  String get community => 'Community';

  @override
  String get templates => 'Templates';

  @override
  String get continueLastGuide => 'Continue Last Guide';

  @override
  String get continueChat => 'Continue Chat';

  @override
  String get guidePlaceholderSubtitle =>
      'Browse guided learning paths and tips.';

  @override
  String get templatesPlaceholderSubtitle =>
      'Use ready-made templates to move faster.';

  @override
  String get continueWhereYouLeftOff => 'Pick Up Where You Left Off';

  @override
  String get dashboardEmptyMessage =>
      'Welcome! Let\'s get your business on track. Start your first guide.';

  @override
  String get quickActions => 'Quick Actions';

  @override
  String get monthlyCompletion => 'This Month\'s Progress';

  @override
  String progressSummary(int completed, int inProgress) {
    return '$completed completed · $inProgress in progress';
  }

  @override
  String get notifications => 'Notifications';

  @override
  String get myDownloads => 'My Downloads';

  @override
  String get searchTemplates => 'Search templates...';

  @override
  String get noTemplatesFound => 'No templates match your search.';

  @override
  String get noDownloadsYet => 'Templates you download will appear here.';

  @override
  String downloadCount(int count) {
    return '$count downloads';
  }

  @override
  String get categories => 'Categories';

  @override
  String get showAll => 'Show All';

  @override
  String get preview => 'Preview';

  @override
  String get upgrade => 'Upgrade';

  @override
  String get openInBrowser => 'Open in Browser';

  @override
  String get previewFailed =>
      'Couldn\'t open the preview. Try downloading instead.';

  @override
  String downloadedFile(String filename) {
    return 'Downloaded $filename';
  }

  @override
  String downloadFailed(String message) {
    return 'Download failed: $message';
  }

  @override
  String get proTemplateTitle => 'Pro Template';

  @override
  String get proTemplateDescription =>
      'This template is available with a Pro subscription. Upgrade to download and preview.';

  @override
  String get upgradeToPro => 'Upgrade to Pro';

  @override
  String get maybeLater => 'Maybe Later';

  @override
  String get open => 'Open';

  @override
  String failedToLoadPDF(String error) {
    return 'Failed to load PDF: $error';
  }

  @override
  String get templateDetails => 'Template Details';

  @override
  String get download => 'Download';

  @override
  String get chooseYourPlan => 'Choose Your Plan';

  @override
  String get freeForever => 'free forever';

  @override
  String get perMonth => '/month';

  @override
  String get perYear => '/year';

  @override
  String get proMonthly => 'Pro Monthly';

  @override
  String get proYearly => 'Pro Yearly';

  @override
  String get subscribe => 'Subscribe';

  @override
  String get currentPlan => 'Current Plan';

  @override
  String get mostPopular => 'Most Popular';

  @override
  String get youAreOnPro => 'You are on Pro';

  @override
  String savePercentYearly(int percent) {
    return 'Save $percent% with yearly billing';
  }

  @override
  String get billingDisclaimer =>
      'Subscriptions are billed in ETB. You can cancel anytime.';

  @override
  String get planFeatureAllGuides => 'Access to all guides';

  @override
  String get planFeatureCommunity => 'Community read-only access';

  @override
  String get planFeatureAiQuestions => '3 AI questions per month';

  @override
  String get planFeatureEverythingBasic => 'Everything in Basic';

  @override
  String get planFeatureUnlimitedAi => 'Unlimited AI questions';

  @override
  String get planFeatureTemplates => 'Template downloads';

  @override
  String get planFeatureSupport => 'Priority community support';

  @override
  String get planFeatureAdvancedProfile => 'Advanced business profile';

  @override
  String get openingSecurePayment => 'Opening secure payment...';

  @override
  String get paymentCancelled => 'Payment cancelled';

  @override
  String get verifyingPayment => 'Verifying your payment...';

  @override
  String get noVerificationResult => 'No verification result';

  @override
  String get paymentSuccessful => 'You\'re all set!';

  @override
  String get proPlanActive =>
      'Your Pro plan is active. Enjoy unlimited access!';

  @override
  String get paymentProcessing => 'Payment Processing';

  @override
  String get paymentBeingProcessed =>
      'Your payment is being processed by your bank. This may take a moment.';

  @override
  String get paymentFailed => 'Payment couldn\'t be completed';

  @override
  String get couldNotCompletePayment =>
      'Something went wrong with your payment. Please try again.';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get backToHome => 'Back to Home';

  @override
  String failedToLoadPlans(String error) {
    return 'Failed to load plans: $error';
  }

  @override
  String get failedToLoadFilters => 'Failed to load filters';

  @override
  String get guideSearchHint => 'Search guides...';

  @override
  String get guideFiltered => 'Filtered';

  @override
  String get guideClearAll => 'Clear all';

  @override
  String get guideBookmarked => 'Bookmarked';

  @override
  String get guideNoGuidesFound =>
      'No guides match your search. Try different keywords.';

  @override
  String get guideNoBookmarks => 'Save guides for later by bookmarking them.';

  @override
  String get guideRecentlyViewed => 'Recently Viewed';

  @override
  String get guideRecent => 'Recent';

  @override
  String guideProgressOf(int completed, int total) {
    return '$completed of $total completed';
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
      other: '$count sectors',
      one: '1 sector',
    );
    return '$_temp0';
  }

  @override
  String guideTagCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tags',
      one: '1 tag',
    );
    return '$_temp0';
  }

  @override
  String stepEstimatedTime(String minutes) {
    return '~$minutes min';
  }

  @override
  String get stepNoContent => 'No content available for this step.';

  @override
  String get stepRequiredDocuments => 'Required Documents';

  @override
  String get stepChecklist => 'Checklist';

  @override
  String get stepProTip => 'Pro Tip';

  @override
  String get stepStatusCompleted => 'Completed';

  @override
  String get stepStatusInProgress => 'In Progress';

  @override
  String get stepStatusSkipped => 'Skipped';

  @override
  String get stepStatusLocked => 'Locked';

  @override
  String get stepStart => 'Start Step';

  @override
  String get stepComplete => 'Complete Step';

  @override
  String get stepSkip => 'Skip';

  @override
  String get stepMarkIncomplete => 'Mark Incomplete';

  @override
  String get stepAddBookmark => 'Add bookmark';

  @override
  String get stepRemoveBookmark => 'Remove bookmark';

  @override
  String get communityForYou => 'For You';

  @override
  String get communityAll => 'All';

  @override
  String get searchThreads => 'Search threads...';

  @override
  String noThreadsFound(String query) {
    return 'No threads found for $query';
  }

  @override
  String get noThreadsAvailable =>
      'No discussions yet. Be the first to start one!';

  @override
  String get noPersonalizedThreads => 'No personalized threads available yet';

  @override
  String threadReplies(int count) {
    return '$count replies';
  }

  @override
  String threadViews(int count) {
    return '$count views';
  }

  @override
  String get owned => 'Owned';

  @override
  String get solved => 'Solved';

  @override
  String get followed => 'Followed';

  @override
  String get moreFilters => 'More filters';

  @override
  String get filters => 'Filters';

  @override
  String get reset => 'Reset';

  @override
  String get searchSectorsTags => 'Search sectors and tags...';

  @override
  String get sectors => 'Sectors';

  @override
  String get tags => 'Tags';

  @override
  String get followedOnly => 'Followed only';

  @override
  String get showFollowedOnly => 'Show only threads you follow';

  @override
  String get noItemsMatchSearch => 'No items match your search';

  @override
  String errorLoadingThreads(String error) {
    return 'Error loading threads: $error';
  }

  @override
  String get createThread => 'Create Thread';

  @override
  String get post => 'Post';

  @override
  String get title => 'Title';

  @override
  String get titleRequired => 'Title required';

  @override
  String minChars(int count) {
    return 'Min $count chars';
  }

  @override
  String get initialPost => 'Initial Post';

  @override
  String get postRequired => 'Post required';

  @override
  String get addImages => 'Add Images';

  @override
  String get addFiles => 'Add Files';

  @override
  String get sectorsOptional => 'Sectors (optional)';

  @override
  String get tagsOptional => 'Tags (optional)';

  @override
  String get deletePost => 'Delete Post';

  @override
  String get confirmDeletePost => 'Are you sure you want to delete this post?';

  @override
  String get postDeleted => 'Post deleted successfully';

  @override
  String get markAsSolution => 'Mark as Solution';

  @override
  String get confirmMarkSolution => 'Mark this post as the accepted solution?';

  @override
  String get mark => 'Mark';

  @override
  String get markedAsSolution => 'Marked as solution';

  @override
  String get deleteThread => 'Delete Thread';

  @override
  String get confirmDeleteThread =>
      'Delete this thread? This can\'t be undone.';

  @override
  String get threadDeleted => 'Thread deleted successfully';

  @override
  String get followThread => 'Follow thread';

  @override
  String get unfollowThread => 'Unfollow thread';

  @override
  String get followingThread => 'Following thread';

  @override
  String get unfollowedThread => 'Unfollowed thread';

  @override
  String get editThread => 'Edit Thread';

  @override
  String get reportThread => 'Report Thread';

  @override
  String get noRepliesYet => 'No replies yet. Be the first!';

  @override
  String get reply => 'Reply';

  @override
  String get saveToGallery => 'Save to Gallery';

  @override
  String get imageSaved => 'Image saved to gallery!';

  @override
  String get report => 'Report';

  @override
  String get selectReason => 'Select a reason:';

  @override
  String get reasonLabel => 'Reason';

  @override
  String get reasonRequired => 'Please enter a reason';

  @override
  String get reasonSpam => 'Spam';

  @override
  String get reasonHarassment => 'Harassment';

  @override
  String get reasonInappropriate => 'Inappropriate Content';

  @override
  String get reasonMisinformation => 'Misinformation';

  @override
  String get reasonOther => 'Other';

  @override
  String get submitReport => 'Submit Report';

  @override
  String reportedSuccessfully(String type) {
    return '$type reported successfully';
  }

  @override
  String get reasonHint => 'Describe why you are reporting this...';

  @override
  String get editingPost => 'Editing post';

  @override
  String replyingTo(String name) {
    return 'Replying to $name';
  }

  @override
  String get newPost => 'New post';

  @override
  String get updateYourPost => 'Update your post...';

  @override
  String get writeYourReply => 'Write your reply...';

  @override
  String get writeAPost => 'Write a post...';

  @override
  String newAttachments(int count) {
    return 'New attachments ($count):';
  }

  @override
  String existingAttachments(int count) {
    return 'Existing attachments ($count):';
  }

  @override
  String get removeAll => 'Remove all';

  @override
  String get attachmentsRemovedOnUpdate =>
      'Attachments will be removed on update';

  @override
  String get undoRemove => 'Undo remove';

  @override
  String get removeThisAttachment => 'Remove this attachment';

  @override
  String get postUpdated => 'Post updated successfully';

  @override
  String get imageSavedToGallery => 'Image saved to gallery!';

  @override
  String get failedToLoadImage => 'Failed to load image';

  @override
  String failedToDeletePost(String error) {
    return 'Failed to delete: $error';
  }

  @override
  String failedToMarkSolution(String error) {
    return 'Failed to mark solution: $error';
  }

  @override
  String failedWithError(String error) {
    return 'Failed: $error';
  }

  @override
  String get oAuthCompletionTitle => 'Complete your sign in';

  @override
  String oAuthCompletionSubtitle(String provider) {
    return 'Add an email to finish signing in with $provider.';
  }

  @override
  String oAuthCompletionSignedInAs(String name) {
    return 'Signed in as $name';
  }

  @override
  String oAuthCompletionProviderSubject(String subject) {
    return 'Provider subject: $subject';
  }

  @override
  String get oAuthFinishingSignIn => 'Finishing sign in...';

  @override
  String get oAuthNoCompletionRequest =>
      'No OAuth email completion request found.';

  @override
  String get oAuthBackToLogin => 'Back to Login';

  @override
  String get completeYourBusinessProfile => 'Complete your business profile';

  @override
  String get unlockPersonalizedGuidance =>
      'Unlock personalized guidance and better recommendations.';

  @override
  String get noInternetConnection => 'No internet connection';

  @override
  String get filterNoResults => 'No items match your search';

  @override
  String get attachments => 'Attachments';

  @override
  String get removeThis => 'Remove this';

  @override
  String get inboxTab => 'Inbox';

  @override
  String get scheduledTab => 'Scheduled';

  @override
  String get compliance => 'Compliance';

  @override
  String get inboxEmpty => 'All clear! No new messages.';

  @override
  String get complianceAutoTracked => 'Auto-tracked';

  @override
  String get complianceManual => 'Manual';

  @override
  String get complianceNoEntries =>
      'No deadlines tracked yet. Add one to stay compliant.';

  @override
  String get complianceAutoTrackedDesc =>
      'Auto-tracked entries appear when you add TIN, license, or registration numbers to your business profile.';

  @override
  String get businessProfileRequired => 'Business profile required';

  @override
  String get complianceCreateProfileDesc =>
      'Create your business profile first to track compliance deadlines.';

  @override
  String get createBusinessProfile => 'Create Business Profile';

  @override
  String get expires => 'Expires: ';

  @override
  String get autoGenerated => 'Auto-generated';

  @override
  String get addComplianceEntry => 'Add Compliance Entry';

  @override
  String get referenceNumber => 'Reference Number';

  @override
  String get enterReferenceNumber => 'Enter reference number';

  @override
  String get expiryDate => 'Expiry Date';

  @override
  String get remindBeforeDays => 'Remind before (days)';

  @override
  String get complianceEntry => 'Compliance Entry';

  @override
  String get entryNotFound => 'Entry not found';

  @override
  String get autoGeneratedFromProfile =>
      'Auto-generated from your business profile';

  @override
  String get complianceType => 'Compliance Type';

  @override
  String get notSet => 'Not set';

  @override
  String get noUpcomingDeadlines => 'No upcoming deadlines';

  @override
  String get complianceAddEntriesDesc =>
      'Add compliance entries from your business profile';

  @override
  String get manageCompliance => 'Manage Compliance';

  @override
  String get upcoming => 'Upcoming';

  @override
  String get manage => 'Manage';

  @override
  String get currentPassword => 'Current Password';

  @override
  String get newPassword => 'New Password';

  @override
  String get changePassword => 'Change Password';

  @override
  String get passwordUpdated => 'Password updated successfully';

  @override
  String get errorPasswordChangeFailed => 'Failed to change password';

  @override
  String get scheduledAlerts => 'Scheduled Alerts';

  @override
  String get remaining => 'remaining';

  @override
  String get complianceCalendar => 'Compliance Calendar';

  @override
  String get seeAll => 'See All';

  @override
  String get upgradeToProDesc =>
      'You\'ve reached the max of 3 scheduled alerts. Upgrade to Pro for unlimited alerts.';

  @override
  String get viewPlans => 'View Plans';

  @override
  String get newScheduledAlert => 'New Scheduled Alert';

  @override
  String get template => 'Template';

  @override
  String get noneCustom => 'None (Custom)';

  @override
  String get bodyField => 'Body';

  @override
  String get bodyRequired => 'Body is required';

  @override
  String get channels => 'Channels';

  @override
  String get inAppChannel => 'In-App';

  @override
  String get pushChannel => 'Push';

  @override
  String freeUserAlertCount(int count) {
    return 'Free users: $count of 3 used';
  }

  @override
  String get noScheduledAlerts =>
      'No alerts scheduled. Stay on top of deadlines!';

  @override
  String get tapToCreate => 'Tap + to create one';

  @override
  String get pending => 'Pending';

  @override
  String get sent => 'Sent';

  @override
  String get cancelledStatus => 'Cancelled';

  @override
  String get reschedule => 'Reschedule';

  @override
  String get overdue => 'Overdue';

  @override
  String get tomorrow => 'Tomorrow';

  @override
  String get complianceCreated => 'Compliance entry created';

  @override
  String get complianceUpdated => 'Compliance entry updated';

  @override
  String get complianceDeleted => 'Compliance entry deleted';

  @override
  String get complianceUnableToCreate => 'Unable to create compliance entry';

  @override
  String get complianceUnableToUpdate => 'Unable to update compliance entry';

  @override
  String get complianceUnableToDelete => 'Unable to delete compliance entry';

  @override
  String get complianceNotFound => 'Compliance entry not found';

  @override
  String get unableToCreateAlert => 'Unable to create alert';

  @override
  String get unableToCancelAlert => 'Unable to cancel alert';

  @override
  String get unableToRescheduleAlert => 'Unable to reschedule alert';

  @override
  String get maxLimitReached =>
      'Upgrade to Pro to create more than 3 scheduled alerts';

  @override
  String get scheduledAlertNotFound => 'Scheduled alert not found';

  @override
  String get notificationPreferences => 'Notification Preferences';

  @override
  String get emailNotifications => 'Email Notifications';

  @override
  String get pushNotifications => 'Push Notifications';

  @override
  String get inAppAlwaysOn => 'Always enabled';

  @override
  String get businessProfile => 'Business Profile';

  @override
  String get manageBusinessDetails => 'Manage your business details';

  @override
  String get companyName => 'Company Name';

  @override
  String get companyEmail => 'Company Email';

  @override
  String get companyPhone => 'Company Phone';

  @override
  String get physicalAddress => 'Physical Address';

  @override
  String get businessDescription => 'Description';

  @override
  String get complianceInfo => 'Compliance Information';

  @override
  String get sectorAndTags => 'Sector & Tags';

  @override
  String get selectSector => 'Select your business sector';

  @override
  String get selectTags => 'Select relevant tags';

  @override
  String get registrationNumber => 'Registration Number';

  @override
  String get taxIdentificationNumber => 'Tax ID (TIN)';

  @override
  String get tradeLicenseNumber => 'Trade License Number';

  @override
  String get businessProfileUpdated => 'Business profile updated';

  @override
  String get logo => 'Logo';

  @override
  String get banner => 'Banner';

  @override
  String get changeLogo => 'Change Logo';

  @override
  String get changeBanner => 'Change Banner';
}
