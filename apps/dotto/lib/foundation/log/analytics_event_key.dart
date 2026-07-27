enum AnalyticsEventKey {
  dottoWebButtonTapped('dotto_web_button_tapped'),
  macSupportButtonTapped('mac_support_button_tapped'),
  opinionBoxButtonTapped('opinion_box_button_tapped');

  const AnalyticsEventKey(this.value);

  final String value;
}
