import 'dart:js_interop';

/// iOS Safari's legacy flag for a home-screen launch.
@JS('navigator.standalone')
external bool? get _navigatorStandalone;

extension type _MediaQueryList(JSObject _) implements JSObject {
  external bool get matches;
}

@JS('matchMedia')
external _MediaQueryList _matchMedia(String query);

bool isStandaloneWebApp() =>
    (_navigatorStandalone ?? false) || _matchMedia('(display-mode: standalone)').matches;
