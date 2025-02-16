import 'package:fake_process_manager/fake_process_manager.dart';
import 'package:mockito/mockito.dart';
import 'package:process/process.dart';
import 'package:screenshots/src/resources.dart';
import 'package:screenshots/src/screens.dart';
import 'package:test/test.dart';
import 'package:tool_base/tool_base.dart';

//import 'src/common_tools.dart';
import 'src/context.dart';

main() {
  group('resources', () {
    final tmpDir = '/tmp/screenshots_test';

    group('in context', () {
      late ProcessManager mockProcessManager;

      setUp(() {
        mockProcessManager = FakeProcessManager(
            customResultSync: () => ProcessResult(0, 0, null, null));
      });

      testUsingContext('unpack scripts', () async {
        final result = await unpackScripts(tmpDir);
        expect(result, isNull);
      }, overrides: {ProcessManager: () => mockProcessManager});
    });

    group('no context', () {
      test('unpack screen resource images', () async {
        final Screens screens = Screens();
        await screens.init();
        final screen = screens.getScreen('iPhone 7 Plus');
        final Map screenResources = screen!['resources'];
        await unpackImages(screenResources, tmpDir);
      });
    });
  });
}
