// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appName => 'Faslo';

  @override
  String get tagline => 'इरादे के साथ उपवास करें।';

  @override
  String get welcomeTo => 'स्वागत है';

  @override
  String get clarity => 'Faslo.';

  @override
  String get welcomeSubtitle =>
      'सचेत उपवास की आपकी यात्रा यहाँ से शुरू होती है।';

  @override
  String get howShallWeCallYou => 'आपका नाम क्या है?';

  @override
  String get enterYourName => 'नाम दर्ज करें';

  @override
  String get preferredLanguage => 'भाषा';

  @override
  String get chooseYourPath => 'योजना चुनें';

  @override
  String get continueJourney => 'जारी रखें';

  @override
  String get chooseGoals => 'आपके लक्ष्य क्या हैं?';

  @override
  String get goalWeightLoss => 'वजन घटाना';

  @override
  String get goalMetabolic => 'चयापचय स्वास्थ्य';

  @override
  String get goalClarity => 'मानसिक स्पष्टता';

  @override
  String get goalLongevity => 'दीर्घायु';

  @override
  String get yourExperience => 'आपका अनुभव?';

  @override
  String get expBeginner => 'शुरुआती';

  @override
  String get expIntermediate => 'मध्यम';

  @override
  String get expAdvanced => 'उन्नत';

  @override
  String get recommendedPlan => 'अनुशंसित योजना';

  @override
  String get selectPlan => 'यह योजना चुनें';

  @override
  String get skip => 'छोड़ें';

  @override
  String get fastingTime => 'उपवास समय';

  @override
  String get timeRemaining => 'शेष समय';

  @override
  String get elapsedDuration => 'बीता हुआ उपवास समय';

  @override
  String get startFasting => 'उपवास शुरू करें';

  @override
  String get stopFasting => 'उपवास समाप्त करें';

  @override
  String get editFast => 'उपवास संपादित करें';

  @override
  String get dailyGoal => 'दैनिक लक्ष्य';

  @override
  String get fastingPhases => 'उपवास चरण';

  @override
  String get active => 'सक्रिय';

  @override
  String get completed => 'पूर्ण';

  @override
  String get locked => 'लॉक';

  @override
  String get home => 'होम';

  @override
  String get timer => 'टाइमर';

  @override
  String get history => 'इतिहास';

  @override
  String get plans => 'योजनाएं';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get wellness => 'स्वास्थ्य';

  @override
  String get totalFasts => 'कुल उपवास';

  @override
  String get avgDuration => 'औसत अवधि';

  @override
  String get longestFast => 'सबसे लंबा उपवास';

  @override
  String get consistency => 'निरंतरता';

  @override
  String get last7days => 'पिछले 7 दिनों का प्रदर्शन';

  @override
  String activeStreak(int n) {
    return 'सक्रिय श्रृंखला: $n दिन';
  }

  @override
  String get recentFasts => 'हाल के उपवास';

  @override
  String get goalMet => 'लक्ष्य प्राप्त';

  @override
  String get exceeded => 'अधिक';

  @override
  String get earlyBreak => 'जल्दी समाप्त';

  @override
  String get chooseYourRhythm => 'अपनी लय चुनें';

  @override
  String get popularProtocols => 'लोकप्रिय प्रोटोकॉल';

  @override
  String get viewAll => 'सभी देखें';

  @override
  String get customizePlan => 'योजना अनुकूलित करें';

  @override
  String get appearance => 'दिखावट';

  @override
  String get language => 'भाषा';

  @override
  String get units => 'इकाइयां';

  @override
  String get clockFormat => 'घड़ी प्रारूप';

  @override
  String get metric => 'मीट्रिक (kg)';

  @override
  String get imperial => 'इम्पीरियल (lbs)';

  @override
  String get hour24 => '24-घंटे';

  @override
  String get hour12 => '12-घंटे';

  @override
  String get notifications => 'सूचनाएं';

  @override
  String get notifFastEnd => 'उपवास पूर्ण अलर्ट';

  @override
  String get notifHalfway => 'आधा रास्ता मील का पत्थर';

  @override
  String get notifKetosis => 'कीटोसिस मील का पत्थर (12h)';

  @override
  String get notifWater => 'पानी रिमाइंडर';

  @override
  String get dataManagement => 'डेटा प्रबंधन';

  @override
  String get exportCSV => 'CSV के रूप में निर्यात करें';

  @override
  String get resetData => 'सभी डेटा रीसेट करें';

  @override
  String get resetConfirm =>
      'यह आपके सभी उपवास इतिहास को हटा देगा। क्या आप सुनिश्चित हैं?';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get confirm => 'पुष्टि करें';

  @override
  String get privacyNote =>
      'आपका सारा डेटा इस डिवाइस पर रहता है।\nकोई खाता नहीं। कोई ट्रैकिंग नहीं। कोई विज्ञापन नहीं।';

  @override
  String get water => 'पानी';

  @override
  String glassesLogged(int n, int goal) {
    return '$goal में से $n गिलास दर्ज';
  }

  @override
  String get addGlass => '+ पानी जोड़ें';

  @override
  String get logWeight => 'वजन दर्ज करें';

  @override
  String get logMood => 'आप कैसा महसूस कर रहे हैं?';

  @override
  String get moodTerrible => 'बहुत बुरा';

  @override
  String get moodBad => 'बुरा';

  @override
  String get moodOkay => 'ठीक';

  @override
  String get moodGood => 'अच्छा';

  @override
  String get moodGreat => 'बहुत अच्छा';

  @override
  String streakDays(int n) {
    return '$n दिन की श्रृंखला 🔥';
  }

  @override
  String get phaseFedState => 'खाने के बाद';

  @override
  String get phaseFedStateDesc =>
      'आपका शरीर आपके अंतिम भोजन को संसाधित कर रहा है।';

  @override
  String get phaseCatabolic => 'अपचय';

  @override
  String get phaseCatabolicDesc =>
      'इंसुलिन का स्तर गिरता है। वसा भंडार सक्रिय होने लगते हैं।';

  @override
  String get phaseFatBurning => 'वसा दहन';

  @override
  String get phaseFatBurningDesc => 'आपका शरीर ईंधन के लिए वसा जलाने लगता है।';

  @override
  String get phaseKetosis => 'कीटोसिस';

  @override
  String get phaseKetosisDesc =>
      'वसा दहन चरम पर होता है। मानसिक स्पष्टता अक्सर मिलती है।';

  @override
  String get phaseDeepKetosis => 'गहरी कीटोसिस';

  @override
  String get phaseDeepKetosisDesc => 'कीटोन उत्पादन अधिक है। ऊर्जा स्थिर है।';

  @override
  String get phaseAutophagy => 'ऑटोफैजी';

  @override
  String get phaseAutophagyDesc =>
      'कोशिका सफाई शुरू होती है। आपकी कोशिकाएं नवीनीकृत हो रही हैं।';

  @override
  String get phaseImmuneReset => 'प्रतिरक्षा रीसेट';

  @override
  String get phaseImmuneResetDesc =>
      'विस्तारित उपवास गहरी प्रतिरक्षा पुनर्जनन को ट्रिगर करता है।';

  @override
  String get planCircadian => 'सर्कैडियन लय';

  @override
  String get planGentle => 'सौम्य शुरुआत';

  @override
  String get planLeangains => 'लीनगेन्स';

  @override
  String get planFatBurner => 'वसा बर्नर';

  @override
  String get planWarrior => 'योद्धा आहार';

  @override
  String get planOMAD => 'OMAD';

  @override
  String get planCustom => 'कस्टम';

  @override
  String get diffBeginner => 'शुरुआती';

  @override
  String get diffBalanced => 'संतुलित';

  @override
  String get diffModerate => 'मध्यम';

  @override
  String get diffIntense => 'तीव्र';

  @override
  String get diffAdvanced => 'उन्नत';

  @override
  String get diffCustom => 'कस्टम';

  @override
  String get benefitCircadian => 'आपकी आंतरिक घड़ी से मेल खाता है';

  @override
  String get benefitGentle => 'वसा दहन में आसान प्रवेश';

  @override
  String get benefitLeangains => 'गोल्ड स्टैंडर्ड — वसा ऑक्सीकरण और फोकस';

  @override
  String get benefitFatBurner => 'गहरी कीटोसिस स्थितियां';

  @override
  String get benefitWarrior => 'पूर्वजों के खाने की नकल';

  @override
  String get benefitOMAD => 'अधिकतम ऑटोफैजी और मानसिक स्पष्टता';

  @override
  String get benefitCustom => 'अपने स्वयं के उपवास पैरामीटर सेट करें';

  @override
  String get fastCompletedTitle => 'उपवास पूर्ण! 🎉';

  @override
  String fastCompletedBody(int h) {
    return 'आपका ${h}h उपवास पूरा हो गया। शानदार काम।';
  }

  @override
  String get halfwayTitle => 'आधा रास्ता 🔥';

  @override
  String get halfwayBody => 'आप अपने उपवास के आधे रास्ते पर हैं। जारी रखें!';

  @override
  String get ketosisTitle => 'कीटोसिस पहुंच गया 💫';

  @override
  String get ketosisBody =>
      'आपका शरीर कीटोसिस में प्रवेश कर गया है। वसा दहन पूरे प्रभाव में है।';

  @override
  String get waterReminderTitle => 'हाइड्रेटेड रहें 💧';

  @override
  String get waterReminderBody => 'पानी पीने का समय है।';

  @override
  String get themeSageMint => 'सेज मिंट';

  @override
  String get themeObsidian => 'काइनेटिक ऑब्सीडियन';

  @override
  String get themeZenPaper => 'ज़ेन पेपर';

  @override
  String get themeMinimal => 'मिनिमल OLED';

  @override
  String get themeMinimalHint => 'टॉगल करने के लिए टाइमर को लंबे समय तक दबाएं';

  @override
  String get chooseTheme => 'थीम चुनें';

  @override
  String get aboutVersion => 'संस्करण 1.0.0';

  @override
  String get aboutTitle => 'Faslo के बारे में';

  @override
  String get shareTitle => 'अपनी उपलब्धि साझा करें';

  @override
  String get shareButton => 'साझा करें';

  @override
  String get shareDone => 'हो गया';

  @override
  String shareStreak(int n) {
    return '$n दिन की श्रृंखला 🔥';
  }

  @override
  String get shareMessage => 'निरंतर बने रहें।\nआपका शरीर धन्यवाद कर रहा है।';

  @override
  String get shareBranding => 'FASLO';

  @override
  String get shareCompleted => 'उपवास पूर्ण';
}
