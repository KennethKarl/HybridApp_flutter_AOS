import 'package:flutter/material.dart';
import '../models/step_data.dart';
import '../models/banner_item.dart';
import '../models/menu_item.dart';
import '../models/quiz.dart';
import '../models/user_profile.dart';

class MockData {
  // 걸음수
  static final stepData = StepData(
    stepCount: 6847,
    leafPoint: 32,
    weeklySteps: [4200, 7800, 5100, 8300, 6200, 3900, 6847],
    currentDayIndex: DateTime.now().weekday % 7,
  );

  // 배너
  static const banners = [
    BannerItem(
      title: '검진결과 10년 치,\n한눈에 볼 수 있다면?',
      subtitle: 'AI 검진리포트',
      linkUrl: '/checkup',
      bgColor: Color(0xFFE8F5E9),
    ),
    BannerItem(
      title: '웰니스 프로그램\n시작하기',
      subtitle: '건강증진',
      linkUrl: '/care',
      bgColor: Color(0xFFE3F2FD),
    ),
    BannerItem(
      title: '스트레스 관리,\n지금 시작하세요',
      subtitle: '마음건강',
      linkUrl: '/disease-check',
      bgColor: Color(0xFFFCE4EC),
    ),
    BannerItem(
      title: '내 근처 약국\n빠르게 찾기',
      subtitle: '편의서비스',
      linkUrl: '/menu',
      bgColor: Color(0xFFFFF3E0),
    ),
    BannerItem(
      title: '건강검진 예약,\n온라인으로 간편하게',
      subtitle: '건강검진',
      linkUrl: '/checkup',
      bgColor: Color(0xFFE0F2F1),
    ),
    BannerItem(
      title: '오늘의 건강퀴즈\n도전해보세요!',
      subtitle: '건강상식',
      linkUrl: '/main',
      bgColor: Color(0xFFF3E5F5),
    ),
    BannerItem(
      title: '수면 패턴 분석으로\n숙면 찾기',
      subtitle: '수면관리',
      linkUrl: '/disease-check',
      bgColor: Color(0xFFE8EAF6),
    ),
    BannerItem(
      title: '걸음수 챌린지\n리프포인트 적립!',
      subtitle: '리워드',
      linkUrl: '/main',
      bgColor: Color(0xFFE0F7FA),
    ),
  ];

  // 홈 - 상단 메뉴카드
  static const homeMenuTop = [
    AppMenuItem(
      icon: '🏥',
      iconBg: Color(0xFFE8F5E9),
      title: '건강검진 알아보기',
      subtitle: '올해는 좀 좋아졌을까?',
    ),
    AppMenuItem(
      icon: '🤖',
      iconBg: Color(0xFFE3F2FD),
      title: 'AI 검진리포트',
      subtitle: '세상에 없던 검진결과',
      isNew: true,
    ),
    AppMenuItem(
      icon: '💡',
      iconBg: Color(0xFFFFF3E0),
      title: '건강인사이트',
      subtitle: '나만을 위한 건강 정보',
      isNew: true,
    ),
  ];

  // 홈 - 하단 메뉴카드
  static const homeMenuBottom = [
    AppMenuItem(
      icon: '💊',
      iconBg: Color(0xFFFCE4EC),
      title: '약국 찾기',
      subtitle: '내 근처 약국 검색',
    ),
    AppMenuItem(
      icon: '🏪',
      iconBg: Color(0xFFE0F2F1),
      title: '병원 찾기',
      subtitle: '내 근처 병원 검색',
    ),
  ];

  // 건강검진
  static const checkupItems = [
    AppMenuItem(
      icon: '🏥',
      iconBg: Color(0xFFE8F5E9),
      title: '건강검진 알아보기',
      subtitle: '올해는 좀 좋아졌을까?',
    ),
    AppMenuItem(
      icon: '🤖',
      iconBg: Color(0xFFE3F2FD),
      title: 'AI 검진리포트',
      subtitle: '세상에 없던 검진결과',
      isNew: true,
    ),
    AppMenuItem(
      icon: '📊',
      iconBg: Color(0xFFFFF3E0),
      title: '검진결과 조회',
      subtitle: '과거 검진결과를 한눈에',
    ),
    AppMenuItem(
      icon: '📅',
      iconBg: Color(0xFFE0F7FA),
      title: '검진 예약',
      subtitle: '간편한 온라인 예약',
    ),
    AppMenuItem(
      icon: '📋',
      iconBg: Color(0xFFF3E5F5),
      title: '검진 가이드',
      subtitle: '검진 전 주의사항',
    ),
  ];

  // 건강증진
  static const careItems = [
    AppMenuItem(
      icon: '🏃',
      iconBg: Color(0xFFE8F5E9),
      title: '운동 프로그램',
      subtitle: '나에게 맞는 운동 찾기',
    ),
    AppMenuItem(
      icon: '🥗',
      iconBg: Color(0xFFFFF3E0),
      title: '영양 관리',
      subtitle: '균형잡힌 식단 가이드',
    ),
    AppMenuItem(
      icon: '🧘',
      iconBg: Color(0xFFE3F2FD),
      title: '스트레스 관리',
      subtitle: '마음 챙김 프로그램',
    ),
    AppMenuItem(
      icon: '🚭',
      iconBg: Color(0xFFFCE4EC),
      title: '금연 프로그램',
      subtitle: '단계별 금연 가이드',
    ),
    AppMenuItem(
      icon: '💪',
      iconBg: Color(0xFFE0F2F1),
      title: '체중 관리',
      subtitle: '건강한 체중 유지하기',
    ),
  ];

  // 건강체크
  static const diseaseCheckItems = [
    AppMenuItem(
      icon: '😔',
      iconBg: Color(0xFFE3F2FD),
      title: '우울증',
      subtitle: 'PHQ-9 자가검진',
    ),
    AppMenuItem(
      icon: '😰',
      iconBg: Color(0xFFFCE4EC),
      title: '공황장애',
      subtitle: '공황장애 자가검진',
    ),
    AppMenuItem(
      icon: '🍺',
      iconBg: Color(0xFFFFF3E0),
      title: '알코올',
      subtitle: 'AUDIT-K 음주습관 검사',
    ),
    AppMenuItem(
      icon: '🚬',
      iconBg: Color(0xFFE0F2F1),
      title: '흡연',
      subtitle: '니코틴 의존도 검사',
    ),
    AppMenuItem(
      icon: '😣',
      iconBg: Color(0xFFF3E5F5),
      title: '스트레스',
      subtitle: '스트레스 지수 확인',
    ),
    AppMenuItem(
      icon: '😴',
      iconBg: Color(0xFFE8EAF6),
      title: '수면장애',
      subtitle: '수면 질 자가검진',
    ),
  ];

  // 건강퀴즈
  static const quizzes = [
    Quiz(question: '하루 물 8잔 이상 마시면 건강에 좋다?', answer: true),
    Quiz(question: '커피는 하루 5잔 이상 마셔도 괜찮다?', answer: false),
    Quiz(question: '성인은 하루 30분 이상 운동이 권장된다?', answer: true),
  ];

  // 사용자 프로필
  static const userProfile = UserProfile(
    name: '홍길동',
    company: 'GC헬스케어',
  );

  // 전체 메뉴 그룹
  static const menuGroups = {
    '건강관리': [
      AppMenuItem(icon: '👟', iconBg: Color(0xFFE8F5E9), title: '걸음수'),
      AppMenuItem(icon: '🏥', iconBg: Color(0xFFE3F2FD), title: '건강검진'),
      AppMenuItem(icon: '💪', iconBg: Color(0xFFFFF3E0), title: '건강증진'),
      AppMenuItem(icon: '🩺', iconBg: Color(0xFFFCE4EC), title: '건강체크'),
    ],
    '편의서비스': [
      AppMenuItem(icon: '🏪', iconBg: Color(0xFFE0F2F1), title: '병원찾기'),
      AppMenuItem(icon: '💊', iconBg: Color(0xFFF3E5F5), title: '약국찾기'),
      AppMenuItem(icon: '🔍', iconBg: Color(0xFFE8EAF6), title: '증상검색'),
    ],
    '설정': [
      AppMenuItem(icon: '👤', iconBg: Color(0xFFECEFF1), title: '내정보'),
      AppMenuItem(icon: '🔔', iconBg: Color(0xFFFFF8E1), title: '알림설정'),
      AppMenuItem(icon: '📄', iconBg: Color(0xFFE0F7FA), title: '이용약관'),
      AppMenuItem(icon: 'ℹ️', iconBg: Color(0xFFF5F5F5), title: '버전정보'),
    ],
  };
}
