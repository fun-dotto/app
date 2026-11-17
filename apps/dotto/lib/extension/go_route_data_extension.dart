import 'package:dotto_design_system/component/list_detail.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

extension GoRouteDataListDetail on GoRouteData {
  /// 一覧から詳細を開く。
  ///
  /// 一覧と詳細を左右に並べているときは右ペインを差し替え、詳細を
  /// 積み重ねない。並べていないときはこれまでどおり画面を積む。
  void openAsDetail(BuildContext context) {
    if (DottoListDetail.isSplit(context)) {
      go(context);
    } else {
      // 戻り値を待つ呼び出し元はないため、結果は捨てる。
      push<void>(context).ignore();
    }
  }
}
