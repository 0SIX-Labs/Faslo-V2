// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appName => 'Faslo';

  @override
  String get tagline => '의도를 가지고 단식하세요.';

  @override
  String get welcomeTo => '환영합니다';

  @override
  String get clarity => 'Faslo.';

  @override
  String get welcomeSubtitle => '마음챙김 단식을 향한 여정이 시작됩니다.';

  @override
  String get howShallWeCallYou => '이름이 무엇인가요?';

  @override
  String get enterYourName => '이름 입력';

  @override
  String get preferredLanguage => '언어';

  @override
  String get chooseYourPath => '플랜 선택';

  @override
  String get continueJourney => '계속하기';

  @override
  String get startJourney => '여정 시작';

  @override
  String get chooseYourStyle => '테마 선택';

  @override
  String get chooseGoals => '목표는 무엇인가요?';

  @override
  String get selectFastingPlan => '단식 플랜 선택';

  @override
  String get medicalDisclaimer =>
      '이 앱은 의학적 조언을 제공하지 않습니다. 단식을 시작하기 전에 의사와 상담했음을 확인합니다. 건강 결과에 대해 당사는 책임을 지지 않습니다.';

  @override
  String get pleaseEnterName => '계속하려면 이름을 입력하세요';

  @override
  String get pleaseSelectPlan => '계속하려면 단식 플랜을 선택하세요';

  @override
  String get goalWeightLoss => '체중 감량';

  @override
  String get goalMetabolic => '대사 건강';

  @override
  String get goalClarity => '정신적 명료함';

  @override
  String get goalLongevity => '장수';

  @override
  String get yourExperience => '경험 수준은?';

  @override
  String get expBeginner => '초보자';

  @override
  String get expIntermediate => '중급자';

  @override
  String get expAdvanced => '고급자';

  @override
  String get recommendedPlan => '추천 플랜';

  @override
  String get selectPlan => '이 플랜 선택';

  @override
  String get skip => '건너뛰기';

  @override
  String get fastingTime => '단식 시간';

  @override
  String get timeRemaining => '남은 시간';

  @override
  String get elapsedDuration => '경과된 단식 시간';

  @override
  String get startFasting => '단식 시작';

  @override
  String get stopFasting => '단식 종료';

  @override
  String get history => '기록';

  @override
  String get totalFasts => '총 단식 횟수';

  @override
  String get longestFast => '최장 단식';

  @override
  String get consistency => '일관성';

  @override
  String get recentFasts => '최근 단식';

  @override
  String get noFastsRecorded =>
      'No fasts recorded yet.\nStart your first fast!';

  @override
  String get editFast => '단식 편집';

  @override
  String get dailyGoal => '일일 목표';

  @override
  String get fastingPhases => '단식 단계';

  @override
  String get active => '활성';

  @override
  String get completed => '완료';

  @override
  String get locked => '잠김';

  @override
  String get home => '홈';

  @override
  String get timer => '타이머';

  @override
  String get plans => '플랜';

  @override
  String get settings => '설정';

  @override
  String get wellness => '웰니스';

  @override
  String get avgDuration => '평균 시간';

  @override
  String get last7days => '지난 7일 성과';

  @override
  String activeStreak(int n) {
    return '연속 기록: $n일';
  }

  @override
  String get goalMet => '목표 달성';

  @override
  String get exceeded => '초과';

  @override
  String get earlyBreak => '조기 종료';

  @override
  String get chooseYourRhythm => '리듬 선택';

  @override
  String get popularProtocols => '인기 프로토콜';

  @override
  String get viewAll => '모두 보기';

  @override
  String get customizePlan => '플랜 맞춤 설정';

  @override
  String get appearance => '외관';

  @override
  String get language => '언어';

  @override
  String get units => '단위';

  @override
  String get clockFormat => '시계 형식';

  @override
  String get metric => '미터법 (kg)';

  @override
  String get imperial => '야드파운드법 (lbs)';

  @override
  String get hour24 => '24시간';

  @override
  String get hour12 => '12시간';

  @override
  String get notifications => '알림';

  @override
  String get notifFastEnd => '단식 완료 알림';

  @override
  String get notifHalfway => '중간 마일스톤';

  @override
  String get notifKetosis => '케토시스 마일스톤 (12h)';

  @override
  String get notifWater => '수분 섭취 리마인더';

  @override
  String get dataManagement => '데이터 관리';

  @override
  String get exportCSV => 'CSV로 내보내기';

  @override
  String get resetData => '모든 데이터 초기화';

  @override
  String get resetConfirm => '모든 단식 기록이 삭제됩니다. 계속하시겠습니까?';

  @override
  String get cancel => '취소';

  @override
  String get confirm => '확인';

  @override
  String get privacyNote => '모든 데이터는 이 기기에 저장됩니다.\n계정 없음. 추적 없음. 광고 없음.';

  @override
  String get water => '수분';

  @override
  String glassesLogged(int n, int goal) {
    return '$goal잔 중 $n잔 기록';
  }

  @override
  String get addGlass => '+ 물 추가';

  @override
  String get logWeight => '체중 기록';

  @override
  String get logMood => '기분이 어떠신가요?';

  @override
  String get moodTerrible => '최악';

  @override
  String get moodBad => '나쁨';

  @override
  String get moodOkay => '보통';

  @override
  String get moodGood => '좋음';

  @override
  String get moodGreat => '최고';

  @override
  String streakDays(int n) {
    return '$n일 연속 🔥';
  }

  @override
  String get phaseFedState => '식후';

  @override
  String get phaseFedStateDesc => '몸이 마지막 식사를 처리하고 있습니다.';

  @override
  String get phaseCatabolic => '이화';

  @override
  String get phaseCatabolicDesc => '인슐린 수치가 하락합니다. 지방 저장이 활성화되기 시작합니다.';

  @override
  String get phaseFatBurning => '지방 연소';

  @override
  String get phaseFatBurningDesc => '몸이 연료로 지방을 연소하기 시작합니다.';

  @override
  String get phaseKetosis => '케토시스';

  @override
  String get phaseKetosisDesc => '지방 연소가 최고조에 달합니다. 정신적 명료함이 따라오는 경우가 많습니다.';

  @override
  String get phaseDeepKetosis => '깊은 케토시스';

  @override
  String get phaseDeepKetosisDesc => '케톤 생산이 높습니다. 에너지가 안정적입니다.';

  @override
  String get phaseAutophagy => '자가포식';

  @override
  String get phaseAutophagyDesc => '세포 청소가 시작됩니다. 세포가 재생되고 있습니다.';

  @override
  String get phaseImmuneReset => '면역 재설정';

  @override
  String get phaseImmuneResetDesc => '장시간 단식이 깊은 면역 재생을 유발합니다.';

  @override
  String get planCircadian => '일주기 리듬';

  @override
  String get planGentle => '부드러운 시작';

  @override
  String get planLeangains => '린게인즈';

  @override
  String get planFatBurner => '지방 연소';

  @override
  String get planWarrior => '워리어 다이어트';

  @override
  String get planOMAD => 'OMAD';

  @override
  String get planCustom => '맞춤';

  @override
  String get diffBeginner => '초보자';

  @override
  String get diffBalanced => '균형';

  @override
  String get diffModerate => '보통';

  @override
  String get diffIntense => '강렬함';

  @override
  String get diffAdvanced => '고급';

  @override
  String get diffCustom => '맞춤';

  @override
  String get benefitCircadian => '체내 시계에 맞습니다';

  @override
  String get benefitGentle => '지방 연소로의 쉬운 시작';

  @override
  String get benefitLeangains => '골드 스탠다드 — 지방 산화와 집중력';

  @override
  String get benefitFatBurner => '더 깊은 케토시스 상태';

  @override
  String get benefitWarrior => '선조의 식사 패턴 모방';

  @override
  String get benefitOMAD => '최대 자가포식과 정신적 명료함';

  @override
  String get benefitCustom => '자신만의 단식 매개변수 설정';

  @override
  String get fastCompletedTitle => '단식 완료! 🎉';

  @override
  String fastCompletedBody(int h) {
    return '$h시간 단식이 완료되었습니다. 훌륭한 성과입니다.';
  }

  @override
  String get halfwayTitle => '중간 지점 🔥';

  @override
  String get halfwayBody => '단식 중간 지점에 도달했습니다. 계속하세요!';

  @override
  String get ketosisTitle => '케토시스 도달 💫';

  @override
  String get ketosisBody => '몸이 케토시스에 진입했습니다. 지방 연소가 활발합니다.';

  @override
  String get waterReminderTitle => '수분 보충을 잊지 마세요 💧';

  @override
  String get waterReminderBody => '물을 마실 시간입니다.';

  @override
  String get themeSageMint => '세이지 민트';

  @override
  String get themeObsidian => '키네틱 옵시디언';

  @override
  String get themeZenPaper => '젠 페이퍼';

  @override
  String get themeMinimal => '미니멀 OLED';

  @override
  String get themeMinimalHint => '타이머를 길게 눌러 전환';

  @override
  String get chooseTheme => '테마 선택';

  @override
  String get aboutVersion => '버전 1.0.0';

  @override
  String get aboutTitle => 'Faslo 정보';

  @override
  String get shareTitle => '성과 공유하기';

  @override
  String get shareButton => '공유';

  @override
  String get shareDone => '완료';

  @override
  String shareStreak(int n) {
    return '$n일 연속 🔥';
  }

  @override
  String get shareMessage => '꾸준히 계속하세요.\n몸이 감사하고 있습니다.';

  @override
  String get shareBranding => 'FASLO';

  @override
  String get shareCompleted => '단식 완료';
}
