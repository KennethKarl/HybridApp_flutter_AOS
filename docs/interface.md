# Interface 명세서

## Provider Interface

### tabIndexProvider

```dart
final tabIndexProvider = StateProvider<int>((ref) => 0);
```

| 속성 | 값 |
|------|-----|
| 타입 | `StateProvider<int>` |
| 초기값 | `0` (홈 탭) |
| 범위 | `0~4` |
| 사용처 | AppLayout, BottomTabBar, MenuPage |

## Widget Interface

### MenuCard

```dart
class MenuCard extends StatelessWidget {
  final List<AppMenuItem> items;
  final void Function(AppMenuItem item)? onItemTap;

  const MenuCard({super.key, required this.items, this.onItemTap});
}
```

| 파라미터 | 타입 | 필수 | 설명 |
|----------|------|------|------|
| items | `List<AppMenuItem>` | O | 메뉴 아이템 목록 |
| onItemTap | `void Function(AppMenuItem)?` | X | 아이템 탭 콜백 |

### DetailModal

```dart
class DetailModal {
  static void show(BuildContext context, AppMenuItem item);
}
```

| 파라미터 | 타입 | 설명 |
|----------|------|------|
| context | `BuildContext` | 모달을 표시할 컨텍스트 |
| item | `AppMenuItem` | 모달에 표시할 메뉴 아이템 |

### BannerSwiper

```dart
class BannerSwiper extends StatefulWidget {
  final List<BannerItem> banners;
  const BannerSwiper({super.key, required this.banners});
}
```

| 파라미터 | 타입 | 필수 | 설명 |
|----------|------|------|------|
| banners | `List<BannerItem>` | O | 배너 아이템 목록 |

### StepCounter

```dart
class StepCounter extends StatelessWidget {
  final StepData data;
  const StepCounter({super.key, required this.data});
}
```

### HealthQuiz

```dart
class HealthQuiz extends StatefulWidget {
  final Quiz quiz;
  const HealthQuiz({super.key, required this.quiz});
}
```

## Model Interface

### StepData

```dart
class StepData {
  final int stepCount;
  final int leafPoint;
  final List<int> weeklySteps;  // 7개 (일~토)
  final int currentDayIndex;    // 0~6
}
```

### BannerItem

```dart
class BannerItem {
  final String title;
  final String subtitle;    // default: ''
  final String linkUrl;     // default: ''
  final Color bgColor;      // default: Color(0xFFE8F5E9)
}
```

### AppMenuItem

```dart
class AppMenuItem {
  final String icon;         // 이모지
  final Color iconBg;
  final String title;
  final String subtitle;     // default: ''
  final bool isNew;          // default: false
  final String route;        // default: ''
}
```

### Quiz

```dart
class Quiz {
  final String question;
  final bool answer;
  final bool isAnswered;     // default: false
  final bool? userAnswer;    // default: null

  Quiz copyWith({bool? isAnswered, bool? userAnswer});
}
```

### UserProfile

```dart
class UserProfile {
  final String name;
  final String company;
  final String avatarUrl;    // default: ''
}
```
