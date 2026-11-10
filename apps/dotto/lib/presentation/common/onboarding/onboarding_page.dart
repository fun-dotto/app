import 'package:dotto/asset.dart';
import 'package:dotto/l10n/app_localizations.dart';

class OnboardingPage {
  const new({required this.title});

  final String title;

  static List<OnboardingPage> pages(
    AppLocalizations l10n, {
    required bool isFunchEnabled,
  }) => List.unmodifiable([
    OnboardingWelcomePage(
      title: l10n.onboardingWelcomeTitle,
      bodyTop: l10n.onboardingWelcomeBodyTop,
      bodyBottom: l10n.onboardingWelcomeBodyBottom,
    ),
    OnboardingContentPage(
      title: l10n.onboardingTimetableTitle,
      description: l10n.onboardingTimetableDescription,
      imagePath: Asset.tutorialTimetableMock,
    ),
    OnboardingContentPage(
      title: l10n.onboardingBusTitle,
      description: l10n.onboardingBusDescription,
      imagePath: Asset.tutorialBusMock,
    ),
    OnboardingContentPage(
      title: l10n.onboardingMapTitle,
      description: l10n.onboardingMapDescription,
      imagePath: Asset.tutorialCampusMapMock,
    ),
    OnboardingContentPage(
      title: l10n.onboardingSubjectTitle,
      description: l10n.onboardingSubjectDescription,
      imagePath: Asset.tutorialSubjectMock,
    ),
    if (isFunchEnabled)
      OnboardingContentPage(
        title: l10n.onboardingFunchTitle,
        description: l10n.onboardingFunchDescription,
        imagePath: Asset.tutorialCafeteriaMock,
      ),
  ]);
}

final class OnboardingWelcomePage extends OnboardingPage {
  const new({
    required super.title,
    required this.bodyTop,
    required this.bodyBottom,
  });

  final String bodyTop;
  final String bodyBottom;
}

final class OnboardingContentPage extends OnboardingPage {
  const new({
    required super.title,
    required this.description,
    required this.imagePath,
  });

  final String description;
  final String imagePath;
}
