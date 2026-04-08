// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appName => 'Faslo';

  @override
  String get tagline => '意志を持って断食を。';

  @override
  String get welcomeTo => 'ようこそ';

  @override
  String get clarity => 'Faslo.';

  @override
  String get welcomeSubtitle => 'マインドフルな断食への旅がここから始まります。';

  @override
  String get howShallWeCallYou => 'お名前を教えてください';

  @override
  String get enterYourName => '名前を入力';

  @override
  String get preferredLanguage => '言語';

  @override
  String get chooseYourPath => 'プランを選択';

  @override
  String get continueJourney => '続ける';

  @override
  String get startJourney => '旅を始める';

  @override
  String get chooseYourStyle => 'デザインを選択';

  @override
  String get chooseGoals => '目標は何ですか？';

  @override
  String get selectFastingPlan => '断食プランを選択';

  @override
  String get medicalDisclaimer =>
      'このアプリは医学的助言を提供しません。断食を開始する前に医師に相談したことを確認してください。健康上の結果について当社は責任を負いません。';

  @override
  String get pleaseEnterName => '続行するには名前を入力してください';

  @override
  String get pleaseSelectPlan => '続行するには断食プランを選択してください';

  @override
  String get goalWeightLoss => '減量';

  @override
  String get goalMetabolic => '代謝健康';

  @override
  String get goalClarity => '精神的明晰さ';

  @override
  String get goalLongevity => '長寿';

  @override
  String get yourExperience => '経験レベルは？';

  @override
  String get expBeginner => '初心者';

  @override
  String get expIntermediate => '中級者';

  @override
  String get expAdvanced => '上級者';

  @override
  String get recommendedPlan => 'おすすめプラン';

  @override
  String get selectPlan => 'このプランを選択';

  @override
  String get skip => 'スキップ';

  @override
  String get fastingTime => '断食時間';

  @override
  String get timeRemaining => '残り時間';

  @override
  String get elapsedDuration => '経過した断食時間';

  @override
  String get startFasting => '断食を開始';

  @override
  String get stopFasting => '断食を終了';

  @override
  String get history => '履歴';

  @override
  String get totalFasts => '合計断食回数';

  @override
  String get longestFast => '最長断食';

  @override
  String get consistency => '一貫性';

  @override
  String get recentFasts => '最近の断食';

  @override
  String get noFastsRecorded =>
      'No fasts recorded yet.\nStart your first fast!';

  @override
  String get editFast => '断食を編集';

  @override
  String get dailyGoal => '毎日の目標';

  @override
  String get fastingPhases => '断食フェーズ';

  @override
  String get active => 'アクティブ';

  @override
  String get completed => '完了';

  @override
  String get locked => 'ロック中';

  @override
  String get home => 'ホーム';

  @override
  String get timer => 'タイマー';

  @override
  String get plans => 'プラン';

  @override
  String get settings => '設定';

  @override
  String get wellness => 'ウェルネス';

  @override
  String get avgDuration => '平均時間';

  @override
  String get last7days => '過去7日間のパフォーマンス';

  @override
  String activeStreak(int n) {
    return '連続記録: $n日';
  }

  @override
  String get goalMet => '目標達成';

  @override
  String get exceeded => '超過';

  @override
  String get earlyBreak => '早期終了';

  @override
  String get chooseYourRhythm => 'リズムを選択';

  @override
  String get popularProtocols => '人気のプロトコル';

  @override
  String get viewAll => 'すべて表示';

  @override
  String get customizePlan => 'プランをカスタマイズ';

  @override
  String get appearance => '外観';

  @override
  String get language => '言語';

  @override
  String get units => '単位';

  @override
  String get clockFormat => '時計形式';

  @override
  String get metric => 'メートル法 (kg)';

  @override
  String get imperial => 'ヤード・ポンド法 (lbs)';

  @override
  String get hour24 => '24時間';

  @override
  String get hour12 => '12時間';

  @override
  String get notifications => '通知';

  @override
  String get notifFastEnd => '断食完了アラート';

  @override
  String get notifHalfway => '中間マイルストーン';

  @override
  String get notifKetosis => 'ケトーシスマイルストーン (12h)';

  @override
  String get notifWater => '水分補給リマインダー';

  @override
  String get dataManagement => 'データ管理';

  @override
  String get exportCSV => 'CSVとしてエクスポート';

  @override
  String get resetData => 'すべてのデータをリセット';

  @override
  String get resetConfirm => 'これにより、すべての断食履歴が削除されます。よろしいですか？';

  @override
  String get cancel => 'キャンセル';

  @override
  String get confirm => '確認';

  @override
  String get privacyNote => 'すべてのデータはこのデバイスに保存されます。\nアカウントなし。追跡なし。広告なし。';

  @override
  String get water => '水分';

  @override
  String glassesLogged(int n, int goal) {
    return '$goal杯中$n杯記録';
  }

  @override
  String get addGlass => '+ 水を追加';

  @override
  String get logWeight => '体重を記録';

  @override
  String get logMood => '気分はいかがですか？';

  @override
  String get moodTerrible => '最悪';

  @override
  String get moodBad => '悪い';

  @override
  String get moodOkay => '普通';

  @override
  String get moodGood => '良い';

  @override
  String get moodGreat => '最高';

  @override
  String streakDays(int n) {
    return '$n日連続 🔥';
  }

  @override
  String get phaseFedState => '食後';

  @override
  String get phaseFedStateDesc => '体が最後の食事を処理しています。';

  @override
  String get phaseCatabolic => '異化';

  @override
  String get phaseCatabolicDesc => 'インスリンレベルが低下。脂肪蓄積が活性化し始めます。';

  @override
  String get phaseFatBurning => '脂肪燃焼';

  @override
  String get phaseFatBurningDesc => '体が脂肪を燃料として燃焼し始めます。';

  @override
  String get phaseKetosis => 'ケトーシス';

  @override
  String get phaseKetosisDesc => '脂肪燃焼がピークに達します。精神的明晰さが得られることが多いです。';

  @override
  String get phaseDeepKetosis => 'ディープケトーシス';

  @override
  String get phaseDeepKetosisDesc => 'ケトン生産が高まっています。エネルギーが安定しています。';

  @override
  String get phaseAutophagy => 'オートファジー';

  @override
  String get phaseAutophagyDesc => '細胞のクリーンアップが始まります。細胞が再生しています。';

  @override
  String get phaseImmuneReset => '免疫リセット';

  @override
  String get phaseImmuneResetDesc => '長時間の断食が深い免疫再生を引き起こします。';

  @override
  String get planCircadian => '概日リズム';

  @override
  String get planGentle => 'やさしいスタート';

  @override
  String get planLeangains => 'リーンゲインズ';

  @override
  String get planFatBurner => '脂肪燃焼';

  @override
  String get planWarrior => 'ウォリアーダイエット';

  @override
  String get planOMAD => 'OMAD';

  @override
  String get planCustom => 'カスタム';

  @override
  String get diffBeginner => '初心者';

  @override
  String get diffBalanced => 'バランス';

  @override
  String get diffModerate => '中程度';

  @override
  String get diffIntense => '激しい';

  @override
  String get diffAdvanced => '上級';

  @override
  String get diffCustom => 'カスタム';

  @override
  String get benefitCircadian => '体内時計に合っています';

  @override
  String get benefitGentle => '脂肪燃焼への簡単な入り口';

  @override
  String get benefitLeangains => 'ゴールドスタンダード — 脂肪酸化と集中力';

  @override
  String get benefitFatBurner => 'より深いケトーシス状態';

  @override
  String get benefitWarrior => '祖先の食事パターンを模倣';

  @override
  String get benefitOMAD => '最大のオートファジーと精神的明晰さ';

  @override
  String get benefitCustom => '独自の断食パラメータを設定';

  @override
  String get fastCompletedTitle => '断食完了！🎉';

  @override
  String fastCompletedBody(int h) {
    return '$h時間の断食が完了しました。素晴らしい成果です。';
  }

  @override
  String get halfwayTitle => '中間地点 🔥';

  @override
  String get halfwayBody => '断食の中間地点に到達しました。その調子で！';

  @override
  String get ketosisTitle => 'ケトーシス到達 💫';

  @override
  String get ketosisBody => '体がケトーシスに入りました。脂肪燃焼が活発です。';

  @override
  String get waterReminderTitle => '水分補給を忘れずに 💧';

  @override
  String get waterReminderBody => '水を飲む時間です。';

  @override
  String get themeSageMint => 'セージミント';

  @override
  String get themeObsidian => 'キネティックオブシディアン';

  @override
  String get themeZenPaper => '禅ペーパー';

  @override
  String get themeMinimal => 'ミニマルOLED';

  @override
  String get themeMinimalHint => 'タイマーを長押しして切り替え';

  @override
  String get chooseTheme => 'テーマを選択';

  @override
  String get aboutVersion => 'バージョン 1.0.0';

  @override
  String get aboutTitle => 'Fasloについて';

  @override
  String get shareTitle => '成果をシェア';

  @override
  String get shareButton => 'シェア';

  @override
  String get shareDone => '完了';

  @override
  String shareStreak(int n) {
    return '$n日連続 🔥';
  }

  @override
  String get shareMessage => '継続は力なり。\n体が応援しています。';

  @override
  String get shareBranding => 'FASLO';

  @override
  String get shareCompleted => '断食完了';
}
