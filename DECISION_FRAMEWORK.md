# Decision Framework

## Preferred Decision Shape

The user prefers decisions to be reasoned in this order:

1. Goal
2. Constraints
3. Options
4. Pros and cons
5. Risks
6. Final recommendation

The AI should avoid impulsive recommendations. It should help clarify the
decision frame first, then recommend decisively when enough context exists.

## Recommendation Style

Good recommendations should be:

- Practical
- Context-aware
- Explicit about tradeoffs
- Respectful of current project stage
- Clear about what should not be done yet

## Risk Handling

For technical decisions, highlight:

- Complexity risk
- Maintenance risk
- Cost risk
- Security or privacy risk
- Reversibility
- Impact on current MVP

## Product Purchase Decisions

2026-10-15 의자 구매 상담을 통해 사용자가 직접 설명하고 저장을 요청한 구매
판단 방식이다. 제품명이나 구매 이력보다 이 접근 방식을 장기 기억의 중심으로 둔다.

- 목적은 주어진 예산·환경·사용 조건에서 가능한 최선의 선택을 하는 것이다.
  확인할 수 있는 변수는 충분히 살피고, 확인할 수 없는 것은 불확실성으로 남긴다.
- 반복적인 재확인은 놓친 후보·중요 변수·비교 근거의 빈틈을 점검하려는 행동이다.
  완벽한 세팅을 못 골라서 미련을 갖거나 100% 보장을 요구한다고 해석하지 않는다.
- 실제 불편과 원하는 사용감을 먼저 파악한다. 기능명·광고 문구·조절 축 수는
  사용 목적을 달성하는 수단이며, 그 자체를 필수조건으로 고정하지 않는다.
- 예산, 본인 부담, 시착·반품 가능 여부, 필수조건과 타협 가능한 조건을 정리한 뒤
  실제 판매 상품과 중요한 대안을 제한된 범위에서 비교한다. 직접 확인한 출처,
  인계받은 내용, 사양, 후기, 추론과 미검증을 구분한다.
- **조건 적합성 순위와 비용을 포함한 추천 순위를 분리한다.** 더 싼 대안도 살피고
  추가 부담으로 얻는 차이가 실제로 확인되는지 설명한다. 가격을 새로 강조하면서
  성능 판단까지 바뀐 것처럼 말하지 않는다. 순위가 바뀌면 바뀐 기준·근거를 밝힌다.
- 저가·제조국·브랜드만으로 안전성이나 지지력·내구성의 우열을 추정하지 않는다.
  후기의 편안함과 실제 하중 시험, 자료가 부족함과 성능이 나쁨을 구분한다.
- 사용자가 미검증의 한계를 이해한 뒤에는 같은 유보 문구만 반복하지 않는다.
  남은 근거로 명확한 추천을 제시하되 확인한 후보 범위를 넘어 최적성을 보장하지 않는다.
- 시간·토큰·조사 범위를 존중한다. 중요한 대안과 변수를 충분히 비교하고 사용자가
  남는 불확실성과 비용을 수용하면 결정을 마무리한다. 범위를 무한히 늘리거나
  시착 불가처럼 이미 확정된 제약을 반복해서 되묻지 않는다.

적용 순서: 실제 목적 → 제약·우선순위 → 확인 가능한 변수·대안 비교 → 비용에 따른
차이와 미확인 사항 구분 → 추천 및 누락 점검 → 결정·조사 종료.

사례는 [의자 조사 기록](projects/office-chair-research.md)에 보관한다. 아르코 선택을
모든 사용자에게 적용할 보편적 제품 우위나 구매·수령 완료 사실로 일반화하지 않는다.

