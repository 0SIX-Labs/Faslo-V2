// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Faslo';

  @override
  String get tagline => 'Fast with intention.';

  @override
  String get welcomeTo => 'Welcome to';

  @override
  String get clarity => 'Faslo.';

  @override
  String get welcomeSubtitle =>
      'Your journey towards mindful fasting begins here.';

  @override
  String get howShallWeCallYou => 'HOW SHALL WE CALL YOU?';

  @override
  String get enterYourName => 'Enter your name';

  @override
  String get preferredLanguage => 'PREFERRED LANGUAGE';

  @override
  String get chooseYourPath => 'CHOOSE YOUR PATH';

  @override
  String get continueJourney => 'Continue Journey';

  @override
  String get startJourney => 'Start Journey';

  @override
  String get chooseYourStyle => 'CHOOSE YOUR STYLE';

  @override
  String get chooseGoals => 'What are your goals?';

  @override
  String get selectFastingPlan => 'Select Fasting Plan';

  @override
  String get medicalDisclaimer =>
      'This app does not provide medical advice. I confirm I have consulted a doctor before fasting. We are not responsible for health outcomes.';

  @override
  String get pleaseEnterName => 'Please enter your name to continue';

  @override
  String get pleaseSelectPlan => 'Please select a fasting plan to continue';

  @override
  String get goalWeightLoss => 'Weight Loss';

  @override
  String get goalMetabolic => 'Metabolic Health';

  @override
  String get goalClarity => 'Mental Clarity';

  @override
  String get goalLongevity => 'Longevity';

  @override
  String get yourExperience => 'Your experience?';

  @override
  String get expBeginner => 'Beginner';

  @override
  String get expIntermediate => 'Intermediate';

  @override
  String get expAdvanced => 'Advanced';

  @override
  String get recommendedPlan => 'Recommended Plan';

  @override
  String get selectPlan => 'Select this Plan';

  @override
  String get skip => 'Skip';

  @override
  String get fastingTime => 'FASTING TIME';

  @override
  String get timeRemaining => 'REMAINING';

  @override
  String get elapsedDuration => 'ELAPSED FASTING DURATION';

  @override
  String get startFasting => 'Start Fasting';

  @override
  String get stopFasting => 'Stop Fasting';

  @override
  String get history => 'History';

  @override
  String get totalFasts => 'Total Fasts';

  @override
  String get longestFast => 'LONGEST FAST';

  @override
  String get consistency => 'Consistency';

  @override
  String get recentFasts => 'Recent Fasts';

  @override
  String get noFastsRecorded =>
      'No fasts recorded yet.\nStart your first fast!';

  @override
  String get editFast => 'Edit Fast';

  @override
  String get dailyGoal => 'Daily Goal';

  @override
  String get fastingPhases => 'Fasting Phases';

  @override
  String get active => 'ACTIVE';

  @override
  String get completed => 'Completed';

  @override
  String get locked => 'Locked';

  @override
  String get home => 'Home';

  @override
  String get timer => 'Timer';

  @override
  String get plans => 'Plans';

  @override
  String get settings => 'Settings';

  @override
  String get wellness => 'Wellness';

  @override
  String get avgDuration => 'AVG. DURATION';

  @override
  String get last7days => 'Last 7 days performance';

  @override
  String activeStreak(int n) {
    return 'ACTIVE STREAK: $n';
  }

  @override
  String get goalMet => 'GOAL MET';

  @override
  String get exceeded => 'EXCEEDED';

  @override
  String get earlyBreak => 'EARLY BREAK';

  @override
  String get chooseYourRhythm => 'Choose your rhythm';

  @override
  String get popularProtocols => 'Popular Protocols';

  @override
  String get viewAll => 'View all';

  @override
  String get customizePlan => 'Customize Your Plan';

  @override
  String get appearance => 'Appearance';

  @override
  String get language => 'Language';

  @override
  String get units => 'Units';

  @override
  String get clockFormat => 'Clock Format';

  @override
  String get metric => 'Metric (kg)';

  @override
  String get imperial => 'Imperial (lbs)';

  @override
  String get hour24 => '24-hour';

  @override
  String get hour12 => '12-hour';

  @override
  String get notifications => 'Notifications';

  @override
  String get notifFastEnd => 'Fast complete alert';

  @override
  String get notifHalfway => 'Halfway milestone';

  @override
  String get notifKetosis => 'Ketosis milestone (12h)';

  @override
  String get notifWater => 'Water reminders';

  @override
  String get dataManagement => 'Data Management';

  @override
  String get exportCSV => 'Export as CSV';

  @override
  String get resetData => 'Reset All Data';

  @override
  String get resetConfirm =>
      'This will delete all your fasting history. Are you sure?';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get privacyNote =>
      'All your data stays on this device.\nNo accounts. No tracking. No ads.';

  @override
  String get water => 'Water';

  @override
  String glassesLogged(int n, int goal) {
    return '$n of $goal glasses';
  }

  @override
  String get addGlass => '+ Add Glass';

  @override
  String get logWeight => 'Log Weight';

  @override
  String get logMood => 'How are you feeling?';

  @override
  String get moodTerrible => 'Terrible';

  @override
  String get moodBad => 'Bad';

  @override
  String get moodOkay => 'Okay';

  @override
  String get moodGood => 'Good';

  @override
  String get moodGreat => 'Great';

  @override
  String streakDays(int n) {
    return '$n day streak 🔥';
  }

  @override
  String get phaseFedState => 'Fed State';

  @override
  String get phaseFedStateDesc => 'Nourishing your body. The journey awaits.';

  @override
  String get phaseCatabolic => 'Awakening';

  @override
  String get phaseCatabolicDesc =>
      'Your body begins to let go. Fat stores stir.';

  @override
  String get phaseFatBurning => 'Burning';

  @override
  String get phaseFatBurningDesc =>
      'Fueling from within. You\'re becoming lighter.';

  @override
  String get phaseKetosis => 'Clarity';

  @override
  String get phaseKetosisDesc => 'Mind sharpens. Energy flows freely.';

  @override
  String get phaseDeepKetosis => 'Deep Flow';

  @override
  String get phaseDeepKetosisDesc =>
      'Profound stillness. Your body knows the way.';

  @override
  String get phaseAutophagy => 'Renewal';

  @override
  String get phaseAutophagyDesc =>
      'Old cells make way for new. You\'re transforming.';

  @override
  String get phaseImmuneReset => 'Reset';

  @override
  String get phaseImmuneResetDesc =>
      'Deep restoration. Your body rebuilds itself.';

  @override
  String get planCircadian => 'Circadian Rhythm';

  @override
  String get planGentle => 'Gentle Start';

  @override
  String get planLeangains => 'Leangains';

  @override
  String get planFatBurner => 'Fat Burner';

  @override
  String get planWarrior => 'Warrior Diet';

  @override
  String get planOMAD => 'OMAD';

  @override
  String get planCustom => 'Custom';

  @override
  String get diffBeginner => 'BEGINNER';

  @override
  String get diffBalanced => 'BALANCED';

  @override
  String get diffModerate => 'MODERATE';

  @override
  String get diffIntense => 'INTENSE';

  @override
  String get diffAdvanced => 'ADVANCED';

  @override
  String get diffCustom => 'CUSTOM';

  @override
  String get benefitCircadian => 'Aligns with your body clock';

  @override
  String get benefitGentle => 'Easy entry into fat burning';

  @override
  String get benefitLeangains => 'Gold standard — fat oxidation & focus';

  @override
  String get benefitFatBurner => 'Deeper ketosis states';

  @override
  String get benefitWarrior => 'Mimics ancestral eating';

  @override
  String get benefitOMAD => 'Maximum autophagy & mental clarity';

  @override
  String get benefitCustom => 'Set your own fasting parameters';

  @override
  String get fastCompletedTitle => 'Fast Complete! 🎉';

  @override
  String fastCompletedBody(int h) {
    return 'Your ${h}h fast is done. Amazing work.';
  }

  @override
  String get halfwayTitle => 'Halfway There 🔥';

  @override
  String get halfwayBody => 'You are halfway through your fast. Keep going!';

  @override
  String get ketosisTitle => 'Ketosis Reached 💫';

  @override
  String get ketosisBody =>
      'Your body has entered ketosis. Fat burning is in full effect.';

  @override
  String get waterReminderTitle => 'Stay Hydrated 💧';

  @override
  String get waterReminderBody => 'Time to drink a glass of water.';

  @override
  String get themeSageMint => 'Sage Mint';

  @override
  String get themeObsidian => 'Kinetic Obsidian';

  @override
  String get themeZenPaper => 'Zen Paper';

  @override
  String get themeMinimal => 'Minimal OLED';

  @override
  String get themeMinimalHint => 'Long-press the timer to toggle';

  @override
  String get chooseTheme => 'Choose Theme';

  @override
  String get aboutVersion => 'Version 1.0.0';

  @override
  String get aboutTitle => 'About Faslo';

  @override
  String get shareTitle => 'Share Your Achievement';

  @override
  String get shareButton => 'Share';

  @override
  String get shareDone => 'Done';

  @override
  String shareStreak(int n) {
    return '$n day streak 🔥';
  }

  @override
  String get shareMessage => 'Stay consistent.\nYour body thanks you.';

  @override
  String get shareBranding => 'FASLO';

  @override
  String get shareCompleted => 'FAST COMPLETED';

  @override
  String get greetingMorning => 'Good morning';

  @override
  String get greetingAfternoon => 'Good afternoon';

  @override
  String get greetingEvening => 'Good evening';

  @override
  String get encourageKeepGoing => 'Keep going';

  @override
  String get encourageDoingGreat => 'You\'re doing great';

  @override
  String get encourageStayStrong => 'Stay strong';
}
