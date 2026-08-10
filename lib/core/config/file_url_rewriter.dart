/// Pure helpers for rewriting backend-returned file URLs so they resolve
/// from emulators/devices when the app is pointed at a local backend.
///
/// These functions carry no platform or global state on purpose: callers
/// decide whether a rewrite is required (e.g. based on `AppConfig.isAndroid`
/// and the API base URL), which keeps them trivially unit-testable.
library;

/// Host an Android emulator uses to reach the host machine's localhost.
const String androidEmulatorHost = '10.0.2.2';

/// Rewrites [url]'s host when it points at a local backend.
///
/// When [shouldRewriteLocalhost] is true and the URL host is `localhost` or
/// `127.0.0.1`, the host is replaced with [replacementHost] (default
/// [androidEmulatorHost]) and the rest of the URL (scheme, port, path, query,
/// fragment) is preserved.
///
/// Returns [url] unchanged when:
/// - [shouldRewriteLocalhost] is false (e.g. desktop/iOS/physical device
///   where `localhost` is reachable directly), or
/// - the host is not `localhost`/`127.0.0.1` (e.g. S3 presigned URLs), or
/// - [url] is empty or cannot be parsed.
String rewriteFileUrlHost(
  String url, {
  required bool shouldRewriteLocalhost,
  String replacementHost = androidEmulatorHost,
}) {
  if (!shouldRewriteLocalhost || url.isEmpty) return url;
  final uri = Uri.tryParse(url);
  if (uri == null || !uri.hasAuthority) return url;
  final host = uri.host;
  if (host != 'localhost' && host != '127.0.0.1') return url;
  return uri.replace(host: replacementHost).toString();
}
