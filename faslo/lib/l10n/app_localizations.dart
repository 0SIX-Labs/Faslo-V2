import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
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
    Locale('de'),
    Locale('en'),
    Locale('hi'),
    Locale('ja'),
    Locale('ko')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Faslo'**
  String get appName;

  /// No description provided for @tagline.
  ///
  /// In en, this message translates to:
  /// **'Fast with intention.'**
  String get tagline;

  /// No description provided for @welcomeTo.
  ///
  /// In en, this message translates to:
  /// **'Welcome to'**
  String get welcomeTo;

  /// No description provided for @clarity.
  ///
  /// In en, this message translates to:
  /// **'Faslo.'**
  String get clarity;

  /// No description provided for @welcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your journey towards mindful fasting begins here.'**
  String get welcomeSubtitle;

  /// No description provided for @howShallWeCallYou.
  ///
  /// In en, this message translates to:
  /// **'HOW SHALL WE CALL YOU?'**
  String get howShallWeCallYou;

  /// No description provided for @enterYourName.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get enterYourName;

  /// No description provided for @preferredLanguage.
  ///
  /// In en, this message translates to:
  /// **'PREFERRED LANGUAGE'**
  String get preferredLanguage;

  /// No description provided for @chooseYourPath.
  ///
  /// In en, this message translates to:
  /// **'CHOOSE YOUR PATH'**
  String get chooseYourPath;

  /// No description provided for @continueJourney.
  ///
  /// In en, this message translates to:
  /// **'Continue Journey'**
  String get continueJourney;

  /// No description provided for @startJourney.
  ///
  /// In en, this message translates to:
  /// **'Start Journey'**
  String get startJourney;

  /// No description provided for @chooseYourStyle.
  ///
  /// In en, this message translates to:
  /// **'CHOOSE YOUR STYLE'**
  String get chooseYourStyle;

  /// No description provided for @chooseGoals.
  ///
  /// In en, this message translates to:
  /// **'What are your goals?'**
  String get chooseGoals;

  /// No description provided for @selectFastingPlan.
  ///
  /// In en, this message translates to:
  /// **'Select Fasting Plan'**
  String get selectFastingPlan;

  /// No description provided for @medicalDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'This app does not provide medical advice. I confirm I have consulted a doctor before fasting. We are not responsible for health outcomes.'**
  String get medicalDisclaimer;

  /// No description provided for @pleaseEnterName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name to continue'**
  String get pleaseEnterName;

  /// No description provided for @pleaseSelectPlan.
  ///
  /// In en, this message translates to:
  /// **'Please select a fasting plan to continue'**
  String get pleaseSelectPlan;

  /// No description provided for @goalWeightLoss.
  ///
  /// In en, this message translates to:
  /// **'Weight Loss'**
  String get goalWeightLoss;

  /// No description provided for @goalMetabolic.
  ///
  /// In en, this message translates to:
  /// **'Metabolic Health'**
  String get goalMetabolic;

  /// No description provided for @goalClarity.
  ///
  /// In en, this message translates to:
  /// **'Mental Clarity'**
  String get goalClarity;

  /// No description provided for @goalLongevity.
  ///
  /// In en, this message translates to:
  /// **'Longevity'**
  String get goalLongevity;

  /// No description provided for @yourExperience.
  ///
  /// In en, this message translates to:
  /// **'Your experience?'**
  String get yourExperience;

  /// No description provided for @expBeginner.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get expBeginner;

  /// No description provided for @expIntermediate.
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get expIntermediate;

  /// No description provided for @expAdvanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get expAdvanced;

  /// No description provided for @recommendedPlan.
  ///
  /// In en, this message translates to:
  /// **'Recommended Plan'**
  String get recommendedPlan;

  /// No description provided for @selectPlan.
  ///
  /// In en, this message translates to:
  /// **'Select this Plan'**
  String get selectPlan;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @fastingTime.
  ///
  /// In en, this message translates to:
  /// **'FASTING TIME'**
  String get fastingTime;

  /// No description provided for @timeRemaining.
  ///
  /// In en, this message translates to:
  /// **'REMAINING'**
  String get timeRemaining;

  /// No description provided for @elapsedDuration.
  ///
  /// In en, this message translates to:
  /// **'ELAPSED FASTING DURATION'**
  String get elapsedDuration;

  /// No description provided for @startFasting.
  ///
  /// In en, this message translates to:
  /// **'Start Fasting'**
  String get startFasting;

  /// No description provided for @stopFasting.
  ///
  /// In en, this message translates to:
  /// **'Stop Fasting'**
  String get stopFasting;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @totalFasts.
  ///
  /// In en, this message translates to:
  /// **'Total Fasts'**
  String get totalFasts;

  /// No description provided for @longestFast.
  ///
  /// In en, this message translates to:
  /// **'LONGEST FAST'**
  String get longestFast;

  /// No description provided for @consistency.
  ///
  /// In en, this message translates to:
  /// **'Consistency'**
  String get consistency;

  /// No description provided for @recentFasts.
  ///
  /// In en, this message translates to:
  /// **'Recent Fasts'**
  String get recentFasts;

  /// No description provided for @noFastsRecorded.
  ///
  /// In en, this message translates to:
  /// **'No fasts recorded yet.\nStart your first fast!'**
  String get noFastsRecorded;

  /// No description provided for @editFast.
  ///
  /// In en, this message translates to:
  /// **'Edit Fast'**
  String get editFast;

  /// No description provided for @dailyGoal.
  ///
  /// In en, this message translates to:
  /// **'Daily Goal'**
  String get dailyGoal;

  /// No description provided for @fastingPhases.
  ///
  /// In en, this message translates to:
  /// **'Fasting Phases'**
  String get fastingPhases;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE'**
  String get active;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @locked.
  ///
  /// In en, this message translates to:
  /// **'Locked'**
  String get locked;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @timer.
  ///
  /// In en, this message translates to:
  /// **'Timer'**
  String get timer;

  /// No description provided for @plans.
  ///
  /// In en, this message translates to:
  /// **'Plans'**
  String get plans;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @wellness.
  ///
  /// In en, this message translates to:
  /// **'Wellness'**
  String get wellness;

  /// No description provided for @avgDuration.
  ///
  /// In en, this message translates to:
  /// **'AVG. DURATION'**
  String get avgDuration;

  /// No description provided for @last7days.
  ///
  /// In en, this message translates to:
  /// **'Last 7 days performance'**
  String get last7days;

  /// No description provided for @activeStreak.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE STREAK: {n}'**
  String activeStreak(int n);

  /// No description provided for @goalMet.
  ///
  /// In en, this message translates to:
  /// **'GOAL MET'**
  String get goalMet;

  /// No description provided for @exceeded.
  ///
  /// In en, this message translates to:
  /// **'EXCEEDED'**
  String get exceeded;

  /// No description provided for @earlyBreak.
  ///
  /// In en, this message translates to:
  /// **'EARLY BREAK'**
  String get earlyBreak;

  /// No description provided for @chooseYourRhythm.
  ///
  /// In en, this message translates to:
  /// **'Choose your rhythm'**
  String get chooseYourRhythm;

  /// No description provided for @popularProtocols.
  ///
  /// In en, this message translates to:
  /// **'Popular Protocols'**
  String get popularProtocols;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAll;

  /// No description provided for @customizePlan.
  ///
  /// In en, this message translates to:
  /// **'Customize Your Plan'**
  String get customizePlan;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @units.
  ///
  /// In en, this message translates to:
  /// **'Units'**
  String get units;

  /// No description provided for @clockFormat.
  ///
  /// In en, this message translates to:
  /// **'Clock Format'**
  String get clockFormat;

  /// No description provided for @metric.
  ///
  /// In en, this message translates to:
  /// **'Metric (kg)'**
  String get metric;

  /// No description provided for @imperial.
  ///
  /// In en, this message translates to:
  /// **'Imperial (lbs)'**
  String get imperial;

  /// No description provided for @hour24.
  ///
  /// In en, this message translates to:
  /// **'24-hour'**
  String get hour24;

  /// No description provided for @hour12.
  ///
  /// In en, this message translates to:
  /// **'12-hour'**
  String get hour12;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @notifFastEnd.
  ///
  /// In en, this message translates to:
  /// **'Fast complete alert'**
  String get notifFastEnd;

  /// No description provided for @notifHalfway.
  ///
  /// In en, this message translates to:
  /// **'Halfway milestone'**
  String get notifHalfway;

  /// No description provided for @notifKetosis.
  ///
  /// In en, this message translates to:
  /// **'Ketosis milestone (12h)'**
  String get notifKetosis;

  /// No description provided for @notifWater.
  ///
  /// In en, this message translates to:
  /// **'Water reminders'**
  String get notifWater;

  /// No description provided for @dataManagement.
  ///
  /// In en, this message translates to:
  /// **'Data Management'**
  String get dataManagement;

  /// No description provided for @exportCSV.
  ///
  /// In en, this message translates to:
  /// **'Export as CSV'**
  String get exportCSV;

  /// No description provided for @resetData.
  ///
  /// In en, this message translates to:
  /// **'Reset All Data'**
  String get resetData;

  /// No description provided for @resetConfirm.
  ///
  /// In en, this message translates to:
  /// **'This will delete all your fasting history. Are you sure?'**
  String get resetConfirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @privacyNote.
  ///
  /// In en, this message translates to:
  /// **'All your data stays on this device.\nNo accounts. No tracking. No ads.'**
  String get privacyNote;

  /// No description provided for @water.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get water;

  /// No description provided for @glassesLogged.
  ///
  /// In en, this message translates to:
  /// **'{n} of {goal} glasses'**
  String glassesLogged(int n, int goal);

  /// No description provided for @addGlass.
  ///
  /// In en, this message translates to:
  /// **'+ Add Glass'**
  String get addGlass;

  /// No description provided for @logWeight.
  ///
  /// In en, this message translates to:
  /// **'Log Weight'**
  String get logWeight;

  /// No description provided for @logMood.
  ///
  /// In en, this message translates to:
  /// **'How are you feeling?'**
  String get logMood;

  /// No description provided for @moodTerrible.
  ///
  /// In en, this message translates to:
  /// **'Terrible'**
  String get moodTerrible;

  /// No description provided for @moodBad.
  ///
  /// In en, this message translates to:
  /// **'Bad'**
  String get moodBad;

  /// No description provided for @moodOkay.
  ///
  /// In en, this message translates to:
  /// **'Okay'**
  String get moodOkay;

  /// No description provided for @moodGood.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get moodGood;

  /// No description provided for @moodGreat.
  ///
  /// In en, this message translates to:
  /// **'Great'**
  String get moodGreat;

  /// No description provided for @streakDays.
  ///
  /// In en, this message translates to:
  /// **'{n} day streak 🔥'**
  String streakDays(int n);

  /// No description provided for @phaseFedState.
  ///
  /// In en, this message translates to:
  /// **'Fed State'**
  String get phaseFedState;

  /// No description provided for @phaseFedStateDesc.
  ///
  /// In en, this message translates to:
  /// **'Nourishing your body. The journey awaits.'**
  String get phaseFedStateDesc;

  /// No description provided for @phaseCatabolic.
  ///
  /// In en, this message translates to:
  /// **'Awakening'**
  String get phaseCatabolic;

  /// No description provided for @phaseCatabolicDesc.
  ///
  /// In en, this message translates to:
  /// **'Your body begins to let go. Fat stores stir.'**
  String get phaseCatabolicDesc;

  /// No description provided for @phaseFatBurning.
  ///
  /// In en, this message translates to:
  /// **'Burning'**
  String get phaseFatBurning;

  /// No description provided for @phaseFatBurningDesc.
  ///
  /// In en, this message translates to:
  /// **'Fueling from within. You\'re becoming lighter.'**
  String get phaseFatBurningDesc;

  /// No description provided for @phaseKetosis.
  ///
  /// In en, this message translates to:
  /// **'Clarity'**
  String get phaseKetosis;

  /// No description provided for @phaseKetosisDesc.
  ///
  /// In en, this message translates to:
  /// **'Mind sharpens. Energy flows freely.'**
  String get phaseKetosisDesc;

  /// No description provided for @phaseDeepKetosis.
  ///
  /// In en, this message translates to:
  /// **'Deep Flow'**
  String get phaseDeepKetosis;

  /// No description provided for @phaseDeepKetosisDesc.
  ///
  /// In en, this message translates to:
  /// **'Profound stillness. Your body knows the way.'**
  String get phaseDeepKetosisDesc;

  /// No description provided for @phaseAutophagy.
  ///
  /// In en, this message translates to:
  /// **'Renewal'**
  String get phaseAutophagy;

  /// No description provided for @phaseAutophagyDesc.
  ///
  /// In en, this message translates to:
  /// **'Old cells make way for new. You\'re transforming.'**
  String get phaseAutophagyDesc;

  /// No description provided for @phaseImmuneReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get phaseImmuneReset;

  /// No description provided for @phaseImmuneResetDesc.
  ///
  /// In en, this message translates to:
  /// **'Deep restoration. Your body rebuilds itself.'**
  String get phaseImmuneResetDesc;

  /// No description provided for @planCircadian.
  ///
  /// In en, this message translates to:
  /// **'Circadian Rhythm'**
  String get planCircadian;

  /// No description provided for @planGentle.
  ///
  /// In en, this message translates to:
  /// **'Gentle Start'**
  String get planGentle;

  /// No description provided for @planLeangains.
  ///
  /// In en, this message translates to:
  /// **'Leangains'**
  String get planLeangains;

  /// No description provided for @planFatBurner.
  ///
  /// In en, this message translates to:
  /// **'Fat Burner'**
  String get planFatBurner;

  /// No description provided for @planWarrior.
  ///
  /// In en, this message translates to:
  /// **'Warrior Diet'**
  String get planWarrior;

  /// No description provided for @planOMAD.
  ///
  /// In en, this message translates to:
  /// **'OMAD'**
  String get planOMAD;

  /// No description provided for @planCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get planCustom;

  /// No description provided for @diffBeginner.
  ///
  /// In en, this message translates to:
  /// **'BEGINNER'**
  String get diffBeginner;

  /// No description provided for @diffBalanced.
  ///
  /// In en, this message translates to:
  /// **'BALANCED'**
  String get diffBalanced;

  /// No description provided for @diffModerate.
  ///
  /// In en, this message translates to:
  /// **'MODERATE'**
  String get diffModerate;

  /// No description provided for @diffIntense.
  ///
  /// In en, this message translates to:
  /// **'INTENSE'**
  String get diffIntense;

  /// No description provided for @diffAdvanced.
  ///
  /// In en, this message translates to:
  /// **'ADVANCED'**
  String get diffAdvanced;

  /// No description provided for @diffCustom.
  ///
  /// In en, this message translates to:
  /// **'CUSTOM'**
  String get diffCustom;

  /// No description provided for @benefitCircadian.
  ///
  /// In en, this message translates to:
  /// **'Aligns with your body clock'**
  String get benefitCircadian;

  /// No description provided for @benefitGentle.
  ///
  /// In en, this message translates to:
  /// **'Easy entry into fat burning'**
  String get benefitGentle;

  /// No description provided for @benefitLeangains.
  ///
  /// In en, this message translates to:
  /// **'Gold standard — fat oxidation & focus'**
  String get benefitLeangains;

  /// No description provided for @benefitFatBurner.
  ///
  /// In en, this message translates to:
  /// **'Deeper ketosis states'**
  String get benefitFatBurner;

  /// No description provided for @benefitWarrior.
  ///
  /// In en, this message translates to:
  /// **'Mimics ancestral eating'**
  String get benefitWarrior;

  /// No description provided for @benefitOMAD.
  ///
  /// In en, this message translates to:
  /// **'Maximum autophagy & mental clarity'**
  String get benefitOMAD;

  /// No description provided for @benefitCustom.
  ///
  /// In en, this message translates to:
  /// **'Set your own fasting parameters'**
  String get benefitCustom;

  /// No description provided for @fastCompletedTitle.
  ///
  /// In en, this message translates to:
  /// **'Fast Complete! 🎉'**
  String get fastCompletedTitle;

  /// No description provided for @fastCompletedBody.
  ///
  /// In en, this message translates to:
  /// **'Your {h}h fast is done. Amazing work.'**
  String fastCompletedBody(int h);

  /// No description provided for @halfwayTitle.
  ///
  /// In en, this message translates to:
  /// **'Halfway There 🔥'**
  String get halfwayTitle;

  /// No description provided for @halfwayBody.
  ///
  /// In en, this message translates to:
  /// **'You are halfway through your fast. Keep going!'**
  String get halfwayBody;

  /// No description provided for @ketosisTitle.
  ///
  /// In en, this message translates to:
  /// **'Ketosis Reached 💫'**
  String get ketosisTitle;

  /// No description provided for @ketosisBody.
  ///
  /// In en, this message translates to:
  /// **'Your body has entered ketosis. Fat burning is in full effect.'**
  String get ketosisBody;

  /// No description provided for @waterReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Stay Hydrated 💧'**
  String get waterReminderTitle;

  /// No description provided for @waterReminderBody.
  ///
  /// In en, this message translates to:
  /// **'Time to drink a glass of water.'**
  String get waterReminderBody;

  /// No description provided for @themeSageMint.
  ///
  /// In en, this message translates to:
  /// **'Sage Mint'**
  String get themeSageMint;

  /// No description provided for @themeObsidian.
  ///
  /// In en, this message translates to:
  /// **'Kinetic Obsidian'**
  String get themeObsidian;

  /// No description provided for @themeZenPaper.
  ///
  /// In en, this message translates to:
  /// **'Zen Paper'**
  String get themeZenPaper;

  /// No description provided for @themeMinimal.
  ///
  /// In en, this message translates to:
  /// **'Minimal OLED'**
  String get themeMinimal;

  /// No description provided for @themeMinimalHint.
  ///
  /// In en, this message translates to:
  /// **'Long-press the timer to toggle'**
  String get themeMinimalHint;

  /// No description provided for @chooseTheme.
  ///
  /// In en, this message translates to:
  /// **'Choose Theme'**
  String get chooseTheme;

  /// No description provided for @aboutVersion.
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.0'**
  String get aboutVersion;

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About Faslo'**
  String get aboutTitle;

  /// No description provided for @shareTitle.
  ///
  /// In en, this message translates to:
  /// **'Share Your Achievement'**
  String get shareTitle;

  /// No description provided for @shareButton.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get shareButton;

  /// No description provided for @shareDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get shareDone;

  /// No description provided for @shareStreak.
  ///
  /// In en, this message translates to:
  /// **'{n} day streak 🔥'**
  String shareStreak(int n);

  /// No description provided for @shareMessage.
  ///
  /// In en, this message translates to:
  /// **'Stay consistent.\nYour body thanks you.'**
  String get shareMessage;

  /// No description provided for @shareBranding.
  ///
  /// In en, this message translates to:
  /// **'FASLO'**
  String get shareBranding;

  /// No description provided for @shareCompleted.
  ///
  /// In en, this message translates to:
  /// **'FAST COMPLETED'**
  String get shareCompleted;
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
      <String>['de', 'en', 'hi', 'ja', 'ko'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
