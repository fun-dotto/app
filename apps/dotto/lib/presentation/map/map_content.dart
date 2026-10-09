import 'package:dotto/l10n/app_localizations.dart';
import 'package:dotto/l10n/app_localizations_ja.dart';
import 'package:dotto_design_system/style/semantic_color.dart';
import 'package:material_ui/material_ui.dart';

/// マップ画面の外枠。
///
/// 部屋の詳細は [Scaffold] の BottomSheet として表示するため、[scaffoldKey] を受け取る。
final class MapContent extends StatelessWidget {
  const new({
    required this.searchBar,
    required this.body,
    this.scaffoldKey,
    super.key,
  });

  final Widget searchBar;
  final Widget body;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          (AppLocalizations.of(context) ?? AppLocalizationsJa()).mapTitle,
          style: Theme.of(context).textTheme.titleLarge
              ?.copyWith(color: SemanticColor.light.accentPrimary),
        ),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: searchBar,
          ),
        ),
      ),
      body: Padding(padding: const EdgeInsets.only(top: 8), child: body),
    );
  }
}

/// 部屋を検索するバー。候補の組み立ては [suggestionsBuilder] に委ねる。
final class MapSearchBar extends StatelessWidget {
  const new({
    required this.searchController,
    required this.focusNode,
    required this.suggestionsBuilder,
    super.key,
  });

  final SearchController searchController;
  final FocusNode focusNode;
  final SuggestionsBuilder suggestionsBuilder;

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      searchController: searchController,
      textCapitalization: TextCapitalization.none,
      builder: (context, controller) => SearchBar(
        controller: controller,
        focusNode: focusNode,
        padding: const WidgetStatePropertyAll<EdgeInsets>(
          EdgeInsets.symmetric(horizontal: 16),
        ),
        textCapitalization: TextCapitalization.none,
        onTap: controller.openView,
        onChanged: (_) => controller.openView(),
        leading: const Icon(Icons.search),
        hintText: (AppLocalizations.of(context) ?? AppLocalizationsJa())
            .mapSearchHint,
      ),
      suggestionsBuilder: suggestionsBuilder,
    );
  }
}

/// 読み込みに失敗した場合の本文。
final class MapErrorBody extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) => Center(
    child: Text(
      (AppLocalizations.of(context) ?? AppLocalizationsJa()).mapError,
    ),
  );
}
