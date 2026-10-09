import 'package:dotto/presentation/common/onboarding/onboarding_content.dart';
import 'package:dotto/presentation/common/onboarding/onboarding_page.dart';
import 'package:material_ui/material_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

Widget _content({required int page, bool isFunchEnabled = true}) {
  final pages = OnboardingPage.pages(isFunchEnabled: isFunchEnabled);
  final index = page < 0 ? pages.length + page : page;
  return OnboardingContent(
    pages: pages,
    currentPage: index,
    pageController: PageController(initialPage: index),
    onPageChanged: (_) {},
    onSkipped: () {},
    onNextButtonTapped: () {},
  );
}

@widgetbook.UseCase(name: 'Welcome', type: OnboardingContent)
Widget onboardingContentWelcome(BuildContext context) => _content(page: 0);

@widgetbook.UseCase(name: 'Feature', type: OnboardingContent)
Widget onboardingContentFeature(BuildContext context) => _content(page: 1);

@widgetbook.UseCase(name: 'Last page', type: OnboardingContent)
Widget onboardingContentLastPage(BuildContext context) => _content(page: -1);

@widgetbook.UseCase(name: 'Funch disabled', type: OnboardingContent)
Widget onboardingContentFunchDisabled(BuildContext context) =>
    _content(page: -1, isFunchEnabled: false);
