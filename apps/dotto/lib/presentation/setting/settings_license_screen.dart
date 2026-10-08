import 'package:dotto/asset.dart';
import 'package:material_ui/material_ui.dart';

final class SettingsLicenseScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return LicensePage(
      applicationName: 'Dotto',
      applicationIcon: Image.asset(Asset.icon, width: 150),
    );
  }
}
