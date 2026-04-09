// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appName => 'Faslo';

  @override
  String get tagline => 'Fasten mit Intention.';

  @override
  String get welcomeTo => 'Willkommen bei';

  @override
  String get clarity => 'Faslo.';

  @override
  String get welcomeSubtitle =>
      'Deine Reise zum bewussten Fasten beginnt hier.';

  @override
  String get howShallWeCallYou => 'WIE SOLLEN WIR DICH NENNEN?';

  @override
  String get enterYourName => 'Namen eingeben';

  @override
  String get preferredLanguage => 'BEVORZUGTE SPRACHE';

  @override
  String get chooseYourPath => 'WÄHLE DEINEN WEG';

  @override
  String get continueJourney => 'Weiter';

  @override
  String get startJourney => 'Reise beginnen';

  @override
  String get chooseYourStyle => 'WÄHLE DEIN DESIGN';

  @override
  String get chooseGoals => 'Was sind deine Ziele?';

  @override
  String get selectFastingPlan => 'Fastenplan auswählen';

  @override
  String get medicalDisclaimer =>
      'Diese App bietet keine medizinische Beratung. Ich bestätige, dass ich vor dem Fasten einen Arzt konsultiert habe. Wir sind nicht verantwortlich für Gesundheitsergebnisse.';

  @override
  String get pleaseEnterName => 'Bitte gib deinen Namen ein, um fortzufahren';

  @override
  String get pleaseSelectPlan =>
      'Bitte wähle einen Fastenplan aus, um fortzufahren';

  @override
  String get goalWeightLoss => 'Gewichtsverlust';

  @override
  String get goalMetabolic => 'Stoffwechselgesundheit';

  @override
  String get goalClarity => 'Mentale Klarheit';

  @override
  String get goalLongevity => 'Langlebigkeit';

  @override
  String get yourExperience => 'Deine Erfahrung?';

  @override
  String get expBeginner => 'Anfänger';

  @override
  String get expIntermediate => 'Fortgeschritten';

  @override
  String get expAdvanced => 'Experte';

  @override
  String get recommendedPlan => 'Empfohlener Plan';

  @override
  String get selectPlan => 'Diesen Plan wählen';

  @override
  String get skip => 'Überspringen';

  @override
  String get fastingTime => 'FASTENZEIT';

  @override
  String get timeRemaining => 'VERBLEIBEND';

  @override
  String get elapsedDuration => 'VERSTRICHENE FASTENDAUER';

  @override
  String get startFasting => 'Fasten starten';

  @override
  String get stopFasting => 'Fasten beenden';

  @override
  String get history => 'Verlauf';

  @override
  String get totalFasts => 'Fastentage gesamt';

  @override
  String get longestFast => 'LÄNGSTES FASTEN';

  @override
  String get consistency => 'Konsequenz';

  @override
  String get recentFasts => 'Letzte Fastenzeiten';

  @override
  String get noFastsRecorded =>
      'No fasts recorded yet.\nStart your first fast!';

  @override
  String get editFast => 'Fasten bearbeiten';

  @override
  String get dailyGoal => 'Tagesziel';

  @override
  String get fastingPhases => 'Fastenphasen';

  @override
  String get active => 'AKTIV';

  @override
  String get completed => 'Abgeschlossen';

  @override
  String get locked => 'Gesperrt';

  @override
  String get home => 'Start';

  @override
  String get timer => 'Timer';

  @override
  String get plans => 'Pläne';

  @override
  String get settings => 'Einstellungen';

  @override
  String get wellness => 'Wohlbefinden';

  @override
  String get avgDuration => 'DURSCHN. DAUER';

  @override
  String get last7days => 'Leistung der letzten 7 Tage';

  @override
  String activeStreak(int n) {
    return 'AKTIVE SERIE: $n';
  }

  @override
  String get goalMet => 'ZIEL ERREICHT';

  @override
  String get exceeded => 'ÜBERTROFFEN';

  @override
  String get earlyBreak => 'FRÜHER ABBRUCH';

  @override
  String get chooseYourRhythm => 'Wähle deinen Rhythmus';

  @override
  String get popularProtocols => 'Beliebte Protokolle';

  @override
  String get viewAll => 'Alle anzeigen';

  @override
  String get customizePlan => 'Plan anpassen';

  @override
  String get appearance => 'Erscheinung';

  @override
  String get language => 'Sprache';

  @override
  String get units => 'Einheiten';

  @override
  String get clockFormat => 'Uhrformat';

  @override
  String get metric => 'Metrisch (kg)';

  @override
  String get imperial => 'Imperial (lbs)';

  @override
  String get hour24 => '24-Stunden';

  @override
  String get hour12 => '12-Stunden';

  @override
  String get notifications => 'Benachrichtigungen';

  @override
  String get notifFastEnd => 'Fasten abgeschlossen';

  @override
  String get notifHalfway => 'Halbzeit-Meilenstein';

  @override
  String get notifKetosis => 'Ketose-Meilenstein (12h)';

  @override
  String get notifWater => 'Erinnerungen trinken';

  @override
  String get dataManagement => 'Datenverwaltung';

  @override
  String get exportCSV => 'Als CSV exportieren';

  @override
  String get resetData => 'Alle Daten zurücksetzen';

  @override
  String get resetConfirm =>
      'Dies wird deinen gesamten Fastenverlauf löschen. Bist du sicher?';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get confirm => 'Bestätigen';

  @override
  String get privacyNote =>
      'Alle Daten bleiben auf diesem Gerät.\nKeine Konten. Kein Tracking. Keine Werbung.';

  @override
  String get water => 'Wasser';

  @override
  String glassesLogged(int n, int goal) {
    return '$n von $goal Gläsern';
  }

  @override
  String get addGlass => '+ Glas hinzufügen';

  @override
  String get logWeight => 'Gewicht eintragen';

  @override
  String get logMood => 'Wie fühlst du dich?';

  @override
  String get moodTerrible => 'Schrecklich';

  @override
  String get moodBad => 'Schlecht';

  @override
  String get moodOkay => 'Okay';

  @override
  String get moodGood => 'Gut';

  @override
  String get moodGreat => 'Großartig';

  @override
  String streakDays(int n) {
    return '$n Tage Serie 🔥';
  }

  @override
  String get phaseFedState => 'Genährt';

  @override
  String get phaseFedStateDesc =>
      'Dein Körper verarbeitet deine letzte Mahlzeit.';

  @override
  String get phaseCatabolic => 'Katabol';

  @override
  String get phaseCatabolicDesc =>
      'Insulinspiegel sinkt. Fettreserven werden aktiviert.';

  @override
  String get phaseFatBurning => 'Fettverbrennung';

  @override
  String get phaseFatBurningDesc => 'Dein Körper wechselt zur Fettverbrennung.';

  @override
  String get phaseKetosis => 'Ketose';

  @override
  String get phaseKetosisDesc =>
      'Fettverbrennung erreicht ihren Höhepunkt. Mentale Klarheit folgt oft.';

  @override
  String get phaseDeepKetosis => 'Tiefe Ketose';

  @override
  String get phaseDeepKetosisDesc =>
      'Ketonproduktion ist hoch. Energie ist stabil.';

  @override
  String get phaseAutophagy => 'Autophagie';

  @override
  String get phaseAutophagyDesc =>
      'Zellreinigung beginnt. Deine Zellen erneuern sich.';

  @override
  String get phaseImmuneReset => 'Immun-Reset';

  @override
  String get phaseImmuneResetDesc =>
      'Längeres Fasten löst tiefe Immunregeneration aus.';

  @override
  String get planCircadian => 'Zirkadianer Rhythmus';

  @override
  String get planGentle => 'Sanfter Start';

  @override
  String get planLeangains => 'Leangains';

  @override
  String get planFatBurner => 'Fettverbrenner';

  @override
  String get planWarrior => 'Warrior Diet';

  @override
  String get planOMAD => 'OMAD';

  @override
  String get planCustom => 'Benutzerdefiniert';

  @override
  String get diffBeginner => 'ANFÄNGER';

  @override
  String get diffBalanced => 'AUSGEWOGEN';

  @override
  String get diffModerate => 'MODERAT';

  @override
  String get diffIntense => 'INTENSIV';

  @override
  String get diffAdvanced => 'FORTGESCHRITTEN';

  @override
  String get diffCustom => 'BENUTZERDEFINIERT';

  @override
  String get benefitCircadian => 'Passt zu deiner inneren Uhr';

  @override
  String get benefitGentle => 'Einfacher Einstieg in die Fettverbrennung';

  @override
  String get benefitLeangains => 'Goldstandard — Fettverbrennung & Fokus';

  @override
  String get benefitFatBurner => 'Tiefere Ketose-Zustände';

  @override
  String get benefitWarrior => 'Ahmt ursprüngliches Essen nach';

  @override
  String get benefitOMAD => 'Maximale Autophagie & mentale Klarheit';

  @override
  String get benefitCustom => 'Eigene Fastenparameter festlegen';

  @override
  String get fastCompletedTitle => 'Fasten abgeschlossen! 🎉';

  @override
  String fastCompletedBody(int h) {
    return 'Dein ${h}h Fasten ist vorbei. Großartige Arbeit.';
  }

  @override
  String get halfwayTitle => 'Halbzeit erreicht 🔥';

  @override
  String get halfwayBody =>
      'Du bist auf halbem Weg durch dein Fasten. Weiter so!';

  @override
  String get ketosisTitle => 'Ketose erreicht 💫';

  @override
  String get ketosisBody =>
      'Dein Körper ist in die Ketose eingetreten. Fettverbrennung ist aktiv.';

  @override
  String get waterReminderTitle => 'Bleib hydriert 💧';

  @override
  String get waterReminderBody => 'Zeit, ein Glas Wasser zu trinken.';

  @override
  String get themeSageMint => 'Sage Mint';

  @override
  String get themeObsidian => 'Kinetic Obsidian';

  @override
  String get themeZenPaper => 'Zen Paper';

  @override
  String get themeMinimal => 'Minimal OLED';

  @override
  String get themeMinimalHint => 'Lange auf den Timer drücken zum Umschalten';

  @override
  String get chooseTheme => 'Theme wählen';

  @override
  String get aboutVersion => 'Version 1.0.0';

  @override
  String get aboutTitle => 'Über Faslo';

  @override
  String get shareTitle => 'Teile deinen Erfolg';

  @override
  String get shareButton => 'Teilen';

  @override
  String get shareDone => 'Fertig';

  @override
  String shareStreak(int n) {
    return '$n Tage Serie 🔥';
  }

  @override
  String get shareMessage => 'Bleib konsequent.\nDein Körper dankt es dir.';

  @override
  String get shareBranding => 'FASLO';

  @override
  String get shareCompleted => 'FASTEN ABGESCHLOSSEN';

  @override
  String get greetingMorning => 'Guten Morgen';

  @override
  String get greetingAfternoon => 'Guten Nachmittag';

  @override
  String get greetingEvening => 'Guten Abend';

  @override
  String get encourageKeepGoing => 'Mach weiter so';

  @override
  String get encourageDoingGreat => 'Du machst das großartig';

  @override
  String get encourageStayStrong => 'Bleib stark';
}
