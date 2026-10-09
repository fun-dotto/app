import 'package:dotto/asset.dart';
import 'package:dotto/presentation/common/onboarding/onboarding_page.dart';
import 'package:dotto_design_system/component/button.dart';
import 'package:dotto_design_system/style/semantic_color.dart';
import 'package:material_ui/material_ui.dart';

/// アプリの使い方の説明。
final class OnboardingContent extends StatelessWidget {
  const new({
    required this.pages,
    required this.currentPage,
    required this.pageController,
    required this.onPageChanged,
    required this.onSkipped,
    required this.onNextButtonTapped,
    super.key,
  });

  final List<OnboardingPage> pages;
  final int currentPage;

  /// ページ送りを Screen から操作するため、Screen で持つ。
  final PageController pageController;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onSkipped;
  final VoidCallback onNextButtonTapped;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dottoの使い方')),
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            const Positioned.fill(child: _BackgroundDottoText()),
            Column(
              children: [
                _TopBar(isVisible: currentPage != 0, onSkipped: onSkipped),
                Expanded(
                  child: PageView.builder(
                    controller: pageController,
                    onPageChanged: onPageChanged,
                    itemCount: pages.length,
                    itemBuilder: (context, index) {
                      return switch (pages[index]) {
                        final OnboardingWelcomePage page => _WelcomePage(
                          page: page,
                        ),
                        final OnboardingContentPage page => _FeaturePage(
                          page: page,
                        ),
                        _ => const SizedBox.shrink(),
                      };
                    },
                  ),
                ),
                _BottomArea(
                  activeIndicatorIndex: currentPage == 0 ? -1 : currentPage - 1,
                  pageCount: pages.length,
                  onNextButtonTapped: onNextButtonTapped,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

final class _TopBar extends StatelessWidget {
  const new({required this.isVisible, required this.onSkipped});

  final bool isVisible;
  final VoidCallback onSkipped;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isVisible,
      child: Opacity(
        opacity: isVisible ? 1 : 0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 24, 40, 24),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(Asset.icon, width: 52, height: 52),
              ),
              const Spacer(),
              DottoButton(
                onPressed: onSkipped,
                type: DottoButtonType.text,
                style: DottoButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.bodySmall,
                  padding: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 10,
                  ),
                ),
                child: const Text('スキップ'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final class _WelcomePage extends StatelessWidget {
  const new({required this.page});

  final OnboardingWelcomePage page;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight > 40
                  ? constraints.maxHeight - 40
                  : 0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  page.title,
                  style: Theme.of(context).textTheme.titleLarge
                      ?.copyWith(color: SemanticColor.light.accentPrimary),
                ),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: Image.asset(Asset.icon, width: 140, height: 140),
                ),
                const SizedBox(height: 110),
                Text(
                  page.bodyTop,
                  style: Theme.of(context).textTheme.bodyLarge
                      ?.copyWith(color: SemanticColor.light.labelPrimary),
                  textAlign: TextAlign.center,
                ),
                Text(
                  page.bodyBottom,
                  style: Theme.of(context).textTheme.bodyLarge
                      ?.copyWith(color: SemanticColor.light.labelPrimary),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

final class _FeaturePage extends StatelessWidget {
  const new({required this.page});

  final OnboardingContentPage page;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bodyStyle = Theme.of(context).textTheme.bodyLarge;
        final titleStyle = Theme.of(context).textTheme.titleLarge;
        final estimatedTitleHeight =
            (titleStyle?.fontSize ?? 28) * (titleStyle?.height ?? 1.1);
        final estimatedDescriptionHeight =
            (bodyStyle?.fontSize ?? 16) * (bodyStyle?.height ?? 1.4) * 2;
        const horizontalPadding = 0.0;
        const topPadding = 0.0;
        const bottomPadding = 0.0;
        const titleToImageSpacing = 14.0;
        const imageToDescriptionSpacing = 12.0;
        const topAndBottomSpacing =
            topPadding +
            bottomPadding +
            titleToImageSpacing +
            imageToDescriptionSpacing;
        final availableImageHeight =
            (constraints.maxHeight -
                    topAndBottomSpacing -
                    estimatedTitleHeight -
                    estimatedDescriptionHeight)
                .clamp(0.0, 680.0);

        const imageAspectRatio = 2130 / 1080;
        const visibleTopRatio = 0.7;
        final contentWidth = constraints.maxWidth - (horizontalPadding * 2);
        const desiredImageWidthFactor = 1.0;
        final maxWidthFactorForTop70 =
            (availableImageHeight /
                    (contentWidth * imageAspectRatio * visibleTopRatio))
                .clamp(0.0, 1.0);
        final imageWidthFactor =
            desiredImageWidthFactor <= maxWidthFactorForTop70
            ? desiredImageWidthFactor
            : maxWidthFactorForTop70;
        final imageViewportHeight =
            contentWidth *
            imageWidthFactor *
            imageAspectRatio *
            visibleTopRatio;

        return Column(
          children: [
            Text(
              page.title,
              style: titleStyle?.copyWith(
                color: SemanticColor.light.accentPrimary,
                fontWeight: FontWeight.w600,
                fontSize: (titleStyle.fontSize ?? 24) - 2,
              ),
            ),
            const SizedBox(height: titleToImageSpacing),
            SizedBox(
              width: double.infinity,
              height: imageViewportHeight,
              child: Align(
                alignment: Alignment.topCenter,
                child: FractionallySizedBox(
                  widthFactor: imageWidthFactor,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.asset(
                      page.imagePath,
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topCenter,
                      errorBuilder: (_, _, _) => Image.asset(
                        Asset.noImage,
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: imageToDescriptionSpacing),
            Text(
              page.description,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: bodyStyle,
            ),
          ],
        );
      },
    );
  }
}

final class _BottomArea extends StatelessWidget {
  const new({
    required this.activeIndicatorIndex,
    required this.pageCount,
    required this.onNextButtonTapped,
  });

  final int activeIndicatorIndex;
  final int pageCount;
  final VoidCallback onNextButtonTapped;

  @override
  Widget build(BuildContext context) {
    final indicatorCount = pageCount - 1;

    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 40, 40, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(indicatorCount, (index) {
              final isReached = index <= activeIndicatorIndex;
              return Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: isReached
                      ? SemanticColor.light.accentPrimary
                      : SemanticColor.light.borderPrimary,
                  shape: BoxShape.circle,
                ),
              );
            }),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: DottoButton(
              onPressed: onNextButtonTapped,
              child: Text(
                activeIndicatorIndex == indicatorCount - 1 ? 'はじめる' : '次へ',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final class _BackgroundDottoText extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Transform.translate(
          offset: const Offset(-90, 132),
          child: RotatedBox(
            quarterTurns: 1,
            child: Text(
              'Dotto',
              style: TextStyle(
                fontSize: 170,
                fontWeight: FontWeight.w700,
                letterSpacing: -1.5,
                color: SemanticColor.light.accentPrimary.withValues(
                  alpha: 0.09,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
