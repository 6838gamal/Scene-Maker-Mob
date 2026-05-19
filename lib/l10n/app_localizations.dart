import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const _LocalizationsDelegate delegate = _LocalizationsDelegate();

  bool get isArabic => locale.languageCode == 'ar';

  static final Map<String, Map<String, String>> _strings = {
    'en': {
      // General
      'appName': 'Scene Maker',
      'tagline': 'Edit reality inside your videos',
      'cancel': 'Cancel',
      'save': 'Save',
      'done': 'Done',
      'close': 'Close',
      'submit': 'Submit',
      'loading': 'Processing...',
      'freePlan': 'Free',
      'premiumPlan': 'Premium',
      'upgradeToPremium': 'Upgrade to Premium',
      'unlockPremium': 'Unlock Premium Features',

      // Home
      'newProject': 'New Project',
      'recentProjects': 'Recent Projects',
      'aiTemplates': 'AI Templates',
      'trendingStyles': 'Trending Styles',
      'noProjects': 'No projects yet',
      'noProjectsDesc': 'Tap New Project to start your first AI-powered edit.',
      'importVideo': 'Import Video',
      'tapToImport': 'Tap to import a video',
      'goodMorning': 'Good morning',
      'goodAfternoon': 'Good afternoon',
      'goodEvening': 'Good evening',
      'readyToEdit': 'Ready to create something amazing?',
      'viewAll': 'View all',
      'seeAll': 'See all',

      // Editor
      'editor': 'Editor',
      'objects': 'Objects',
      'text': 'Text',
      'audio': 'Audio',
      'style': 'Style',
      'export': 'Export',
      'tapObject': 'Tap any object to edit it',
      'aiProcessing': 'AI is processing your edit...',
      'editApplied': 'Edit applied successfully!',

      // AI Actions
      'remove': 'Remove',
      'replace': 'Replace',
      'recolor': 'Recolor',
      'animate': 'Animate',
      'relight': 'Relight',
      'aiActions': 'AI Actions',
      'selectAction': 'Select an action',
      'removeDesc': 'Remove this object from the scene',
      'replaceDesc': 'Replace with another object',
      'recolorDesc': 'Change the color',
      'animateDesc': 'Modify movement',
      'relightDesc': 'Change scene lighting',

      // Styles
      'cinematic': 'Cinematic',
      'luxury': 'Luxury',
      'horror': 'Horror',
      'tech': 'Tech',
      'vintage': 'Vintage',
      'motivational': 'Motivational',
      'darkAesthetic': 'Dark Aesthetic',

      // Export
      'exportVideo': 'Export Video',
      'exportPlatform': 'Platform',
      'exportQuality': 'Quality',
      'tiktok': 'TikTok',
      'instagramReels': 'Instagram Reels',
      'youtubeShorts': 'YouTube Shorts',
      'resolution1080': '1080p — Full HD',
      'resolution4K': '4K — Ultra HD',
      'startExport': 'Start Export',
      'exportSuccess': 'Video exported successfully!',
      'premiumRequired': 'Premium required for 4K',

      // Drawer
      'home': 'Home',
      'myProjects': 'My Projects',
      'contactDeveloper': 'Contact Developer',
      'leaveFeedback': 'Leave Feedback',
      'versionDetails': 'Version Details',
      'settings': 'Settings',

      // Contact
      'email': 'Email',
      'telegram': 'Telegram',
      'whatsapp': 'WhatsApp',
      'website': 'Website',
      'contactUs': 'Contact Us',
      'reachOut': 'Reach out via any platform',

      // Feedback
      'feedbackTitle': 'Leave Feedback',
      'feedbackDesc': 'Help us improve Scene Maker',
      'feedbackType': 'Feedback Type',
      'bugReport': 'Bug Report',
      'featureRequest': 'Feature Request',
      'generalFeedback': 'General Feedback',
      'yourFeedback': 'Your Feedback',
      'feedbackHint': 'Tell us what you think...',
      'rating': 'Rating',
      'rateApp': 'Rate your experience',
      'submitFeedback': 'Submit Feedback',
      'thankYou': 'Thank you!',
      'feedbackReceived': 'Your feedback has been received.',

      // Version
      'currentVersion': 'Current Version',
      'buildNumber': 'Build Number',
      'releaseNotes': 'Release Notes',
      'whatsNew': "What's New",
      'version': 'Version',

      // Settings
      'language': 'Language',
      'theme': 'Theme',
      'darkMode': 'Dark Mode',
      'lightMode': 'Light Mode',
      'systemDefault': 'System Default',
      'exportQualitySet': 'Export Quality',
      'notifications': 'Notifications',
      'autoSave': 'Auto Save',
      'english': 'English',
      'arabic': 'Arabic',
      'enabled': 'Enabled',
      'disabled': 'Disabled',

      // Projects
      'allProjects': 'All Projects',
      'sortBy': 'Sort by',
      'newest': 'Newest',
      'oldest': 'Oldest',
      'duration': 'Duration',
      'deleteProject': 'Delete Project',
      'deleteConfirm': 'Are you sure you want to delete this project?',
      'delete': 'Delete',
    },
    'ar': {
      // General
      'appName': 'صانع المشاهد',
      'tagline': 'عدّل الواقع داخل مقاطع الفيديو',
      'cancel': 'إلغاء',
      'save': 'حفظ',
      'done': 'تم',
      'close': 'إغلاق',
      'submit': 'إرسال',
      'loading': 'جارٍ المعالجة...',
      'freePlan': 'مجاني',
      'premiumPlan': 'مميز',
      'upgradeToPremium': 'ترقية للنسخة المميزة',
      'unlockPremium': 'افتح الميزات المميزة',

      // Home
      'newProject': 'مشروع جديد',
      'recentProjects': 'المشاريع الأخيرة',
      'aiTemplates': 'قوالب الذكاء الاصطناعي',
      'trendingStyles': 'الأساليب الرائجة',
      'noProjects': 'لا توجد مشاريع بعد',
      'noProjectsDesc': 'اضغط على مشروع جديد لبدء أول تعديل بالذكاء الاصطناعي.',
      'importVideo': 'استيراد فيديو',
      'tapToImport': 'اضغط لاستيراد فيديو',
      'goodMorning': 'صباح الخير',
      'goodAfternoon': 'مساء الخير',
      'goodEvening': 'مساء النور',
      'readyToEdit': 'هل أنت مستعد لإنشاء شيء مذهل؟',
      'viewAll': 'عرض الكل',
      'seeAll': 'عرض الكل',

      // Editor
      'editor': 'المحرر',
      'objects': 'الكائنات',
      'text': 'النص',
      'audio': 'الصوت',
      'style': 'الأسلوب',
      'export': 'تصدير',
      'tapObject': 'اضغط على أي كائن لتعديله',
      'aiProcessing': 'الذكاء الاصطناعي يعالج التعديل...',
      'editApplied': 'تم تطبيق التعديل بنجاح!',

      // AI Actions
      'remove': 'إزالة',
      'replace': 'استبدال',
      'recolor': 'تغيير اللون',
      'animate': 'تحريك',
      'relight': 'إضاءة',
      'aiActions': 'إجراءات الذكاء الاصطناعي',
      'selectAction': 'اختر إجراءً',
      'removeDesc': 'إزالة هذا الكائن من المشهد',
      'replaceDesc': 'استبداله بكائن آخر',
      'recolorDesc': 'تغيير اللون',
      'animateDesc': 'تعديل الحركة',
      'relightDesc': 'تغيير إضاءة المشهد',

      // Styles
      'cinematic': 'سينمائي',
      'luxury': 'فاخر',
      'horror': 'رعب',
      'tech': 'تقني',
      'vintage': 'كلاسيكي',
      'motivational': 'تحفيزي',
      'darkAesthetic': 'جماليات داكنة',

      // Export
      'exportVideo': 'تصدير الفيديو',
      'exportPlatform': 'المنصة',
      'exportQuality': 'الجودة',
      'tiktok': 'تيك توك',
      'instagramReels': 'انستغرام ريلز',
      'youtubeShorts': 'يوتيوب شورتس',
      'resolution1080': '1080p — فائق الوضوح',
      'resolution4K': '4K — دقة خارقة',
      'startExport': 'بدء التصدير',
      'exportSuccess': 'تم تصدير الفيديو بنجاح!',
      'premiumRequired': 'النسخة المميزة مطلوبة لـ 4K',

      // Drawer
      'home': 'الرئيسية',
      'myProjects': 'مشاريعي',
      'contactDeveloper': 'تواصل مع المطور',
      'leaveFeedback': 'إرسال ملاحظات',
      'versionDetails': 'تفاصيل الإصدار',
      'settings': 'الإعدادات',

      // Contact
      'email': 'البريد الإلكتروني',
      'telegram': 'تيليغرام',
      'whatsapp': 'واتساب',
      'website': 'الموقع الإلكتروني',
      'contactUs': 'تواصل معنا',
      'reachOut': 'تواصل عبر أي منصة',

      // Feedback
      'feedbackTitle': 'إرسال ملاحظات',
      'feedbackDesc': 'ساعدنا في تحسين صانع المشاهد',
      'feedbackType': 'نوع الملاحظة',
      'bugReport': 'الإبلاغ عن خطأ',
      'featureRequest': 'طلب ميزة',
      'generalFeedback': 'ملاحظة عامة',
      'yourFeedback': 'ملاحظتك',
      'feedbackHint': 'أخبرنا بما تفكر...',
      'rating': 'التقييم',
      'rateApp': 'قيّم تجربتك',
      'submitFeedback': 'إرسال الملاحظة',
      'thankYou': 'شكراً لك!',
      'feedbackReceived': 'تم استلام ملاحظتك.',

      // Version
      'currentVersion': 'الإصدار الحالي',
      'buildNumber': 'رقم البناء',
      'releaseNotes': 'ملاحظات الإصدار',
      'whatsNew': 'الجديد',
      'version': 'الإصدار',

      // Settings
      'language': 'اللغة',
      'theme': 'المظهر',
      'darkMode': 'الوضع الداكن',
      'lightMode': 'الوضع الفاتح',
      'systemDefault': 'افتراضي النظام',
      'exportQualitySet': 'جودة التصدير',
      'notifications': 'الإشعارات',
      'autoSave': 'الحفظ التلقائي',
      'english': 'الإنجليزية',
      'arabic': 'العربية',
      'enabled': 'مفعّل',
      'disabled': 'معطّل',

      // Projects
      'allProjects': 'جميع المشاريع',
      'sortBy': 'ترتيب حسب',
      'newest': 'الأحدث',
      'oldest': 'الأقدم',
      'duration': 'المدة',
      'deleteProject': 'حذف المشروع',
      'deleteConfirm': 'هل أنت متأكد من حذف هذا المشروع؟',
      'delete': 'حذف',
    },
  };

  String get(String key) {
    final lang = locale.languageCode;
    return _strings[lang]?[key] ?? _strings['en']?[key] ?? key;
  }

  String get appName => get('appName');
  String get tagline => get('tagline');
  String get cancel => get('cancel');
  String get save => get('save');
  String get done => get('done');
  String get close => get('close');
  String get submit => get('submit');
  String get loading => get('loading');
  String get freePlan => get('freePlan');
  String get premiumPlan => get('premiumPlan');
  String get upgradeToPremium => get('upgradeToPremium');
  String get unlockPremium => get('unlockPremium');
  String get newProject => get('newProject');
  String get recentProjects => get('recentProjects');
  String get aiTemplates => get('aiTemplates');
  String get trendingStyles => get('trendingStyles');
  String get noProjects => get('noProjects');
  String get noProjectsDesc => get('noProjectsDesc');
  String get importVideo => get('importVideo');
  String get tapToImport => get('tapToImport');
  String get readyToEdit => get('readyToEdit');
  String get viewAll => get('viewAll');
  String get seeAll => get('seeAll');
  String get editor => get('editor');
  String get objects => get('objects');
  String get text => get('text');
  String get audio => get('audio');
  String get style => get('style');
  String get export => get('export');
  String get tapObject => get('tapObject');
  String get aiProcessing => get('aiProcessing');
  String get editApplied => get('editApplied');
  String get remove => get('remove');
  String get replace => get('replace');
  String get recolor => get('recolor');
  String get animate => get('animate');
  String get relight => get('relight');
  String get aiActions => get('aiActions');
  String get exportVideo => get('exportVideo');
  String get exportPlatform => get('exportPlatform');
  String get exportQuality => get('exportQuality');
  String get tiktok => get('tiktok');
  String get instagramReels => get('instagramReels');
  String get youtubeShorts => get('youtubeShorts');
  String get resolution1080 => get('resolution1080');
  String get resolution4K => get('resolution4K');
  String get startExport => get('startExport');
  String get premiumRequired => get('premiumRequired');
  String get home => get('home');
  String get myProjects => get('myProjects');
  String get contactDeveloper => get('contactDeveloper');
  String get leaveFeedback => get('leaveFeedback');
  String get versionDetails => get('versionDetails');
  String get settings => get('settings');
  String get email => get('email');
  String get telegram => get('telegram');
  String get whatsapp => get('whatsapp');
  String get website => get('website');
  String get contactUs => get('contactUs');
  String get reachOut => get('reachOut');
  String get feedbackTitle => get('feedbackTitle');
  String get feedbackDesc => get('feedbackDesc');
  String get feedbackType => get('feedbackType');
  String get bugReport => get('bugReport');
  String get featureRequest => get('featureRequest');
  String get generalFeedback => get('generalFeedback');
  String get yourFeedback => get('yourFeedback');
  String get feedbackHint => get('feedbackHint');
  String get rating => get('rating');
  String get rateApp => get('rateApp');
  String get submitFeedback => get('submitFeedback');
  String get thankYou => get('thankYou');
  String get feedbackReceived => get('feedbackReceived');
  String get currentVersion => get('currentVersion');
  String get buildNumber => get('buildNumber');
  String get releaseNotes => get('releaseNotes');
  String get whatsNew => get('whatsNew');
  String get version => get('version');
  String get language => get('language');
  String get theme => get('theme');
  String get darkMode => get('darkMode');
  String get lightMode => get('lightMode');
  String get systemDefault => get('systemDefault');
  String get exportQualitySet => get('exportQualitySet');
  String get notifications => get('notifications');
  String get autoSave => get('autoSave');
  String get english => get('english');
  String get arabic => get('arabic');
  String get allProjects => get('allProjects');
  String get deleteProject => get('deleteProject');
  String get deleteConfirm => get('deleteConfirm');
  String get delete => get('delete');

  String goodTimeOfDay() {
    final hour = DateTime.now().hour;
    if (hour < 12) return get('goodMorning');
    if (hour < 17) return get('goodAfternoon');
    return get('goodEvening');
  }
}

class _LocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _LocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_LocalizationsDelegate old) => false;
}
