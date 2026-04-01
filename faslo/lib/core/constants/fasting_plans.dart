class FastingPlan {
  final String ratio;
  final String nameKey;
  final int fastHours;
  final int eatHours;
  final String difficultyKey;
  final String benefitKey;
  final bool isCustom;

  const FastingPlan({
    required this.ratio,
    required this.nameKey,
    required this.fastHours,
    required this.eatHours,
    required this.difficultyKey,
    required this.benefitKey,
    this.isCustom = false,
  });
}

const List<FastingPlan> fastingPlans = [
  FastingPlan(
    ratio: '12:12',
    nameKey: 'planCircadian',
    fastHours: 12,
    eatHours: 12,
    difficultyKey: 'diffBeginner',
    benefitKey: 'benefitCircadian',
  ),
  FastingPlan(
    ratio: '14:10',
    nameKey: 'planGentle',
    fastHours: 14,
    eatHours: 10,
    difficultyKey: 'diffBeginner',
    benefitKey: 'benefitGentle',
  ),
  FastingPlan(
    ratio: '16:8',
    nameKey: 'planLeangains',
    fastHours: 16,
    eatHours: 8,
    difficultyKey: 'diffBalanced',
    benefitKey: 'benefitLeangains',
  ),
  FastingPlan(
    ratio: '18:6',
    nameKey: 'planFatBurner',
    fastHours: 18,
    eatHours: 6,
    difficultyKey: 'diffModerate',
    benefitKey: 'benefitFatBurner',
  ),
  FastingPlan(
    ratio: '20:4',
    nameKey: 'planWarrior',
    fastHours: 20,
    eatHours: 4,
    difficultyKey: 'diffIntense',
    benefitKey: 'benefitWarrior',
  ),
  FastingPlan(
    ratio: '23:1',
    nameKey: 'planOMAD',
    fastHours: 23,
    eatHours: 1,
    difficultyKey: 'diffAdvanced',
    benefitKey: 'benefitOMAD',
  ),
  FastingPlan(
    ratio: 'Custom',
    nameKey: 'planCustom',
    fastHours: 0,
    eatHours: 0,
    difficultyKey: 'diffCustom',
    benefitKey: 'benefitCustom',
    isCustom: true,
  ),
];
