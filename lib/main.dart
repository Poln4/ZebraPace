import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart';
import 'core/config/supabase_config.dart';
import 'core/errors/error_reporter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Crashes in widgets/framework code, then anything async that escapes.
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    ErrorReporter.report(details.exception, details.stack, where: details.library);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    ErrorReporter.report(error, stack);
    return true;
  };

  // Fonts ship in assets/google_fonts/ — never download them from Google.
  GoogleFonts.config.allowRuntimeFetching = false;
  LicenseRegistry.addLicense(() async* {
    for (final family in ['Fraunces', 'Nunito']) {
      final license = await rootBundle.loadString('assets/google_fonts/$family-OFL.txt');
      yield LicenseEntryWithLineBreaks([family], license);
    }
  });

  // Portrait only — the forms and charts are laid out for a tall screen.
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Supabase.initialize(url: SupabaseConfig.url, publishableKey: SupabaseConfig.anonKey);
  runApp(const ProviderScope(child: ZebraPaceApp()));
}
