import 'package:dotto/domain/entity/flags.dart';
import 'package:dotto/presentation/common/onboarding/onboarding_content.dart';
import 'package:dotto/presentation/common/onboarding/onboarding_page.dart';
import 'package:dotto/presentation/common/use_flag.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

final class OnboardingScreen extends HookConsumerWidget {
  const new({required this.onDismissed, super.key});

  final void Function() onDismissed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFunchEnabled = useFlag(Flags.funch);
    final pages = OnboardingPage.pages(isFunchEnabled: isFunchEnabled);
    final pageController = usePageController();
    final currentPage = useState(0);

    useEffect(() {
      if (currentPage.value >= pages.length) {
        final clamped = pages.length - 1;
        currentPage.value = clamped;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (pageController.hasClients) {
            pageController.jumpToPage(clamped);
          }
        });
      }
      return null;
    }, [pages.length]);

    return OnboardingContent(
      pages: pages,
      currentPage: currentPage.value,
      pageController: pageController,
      onPageChanged: (index) => currentPage.value = index,
      onSkipped: onDismissed,
      onNextButtonTapped: () async {
        if (currentPage.value == pages.length - 1) {
          onDismissed();
          return;
        }
        await pageController.nextPage(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      },
    );
  }
}
