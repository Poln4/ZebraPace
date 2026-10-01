// Whether the app is running as an installed home-screen web app
// (standalone PWA), where the browser has no toolbar of its own under the
// page and the home-indicator area has to be cleared by the app itself.
// Always false off the web.
export 'standalone_app_stub.dart' if (dart.library.js_interop) 'standalone_app_web.dart';
