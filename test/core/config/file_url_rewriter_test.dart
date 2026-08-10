import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/config/file_url_rewriter.dart';

void main() {
  group('rewriteFileUrlHost', () {
    test('rewrites localhost host to emulator host when rewrite enabled', () {
      expect(
        rewriteFileUrlHost(
          'http://localhost:8000/media/attachment.png',
          shouldRewriteLocalhost: true,
        ),
        'http://10.0.2.2:8000/media/attachment.png',
      );
    });

    test('rewrites 127.0.0.1 host when rewrite enabled', () {
      expect(
        rewriteFileUrlHost(
          'https://127.0.0.1:8443/media/avatar.jpg',
          shouldRewriteLocalhost: true,
        ),
        'https://10.0.2.2:8443/media/avatar.jpg',
      );
    });

    test('preserves path, query, and fragment during rewrite', () {
      expect(
        rewriteFileUrlHost(
          'http://localhost:8000/api/v1/files/a.pdf?token=abc&x=1#frag',
          shouldRewriteLocalhost: true,
        ),
        'http://10.0.2.2:8000/api/v1/files/a.pdf?token=abc&x=1#frag',
      );
    });

    test('leaves non-localhost URLs unchanged (e.g. S3 presigned)', () {
      const url = 'https://s3.amazonaws.com/bucket/file.pdf?X-Amz-Signature=123';
      expect(rewriteFileUrlHost(url, shouldRewriteLocalhost: true), url);
    });

    test('leaves localhost URL unchanged when rewrite disabled', () {
      const url = 'http://localhost:8000/media/a.png';
      expect(rewriteFileUrlHost(url, shouldRewriteLocalhost: false), url);
    });

    test('leaves empty string unchanged', () {
      expect(rewriteFileUrlHost('', shouldRewriteLocalhost: true), '');
    });
  });
}
