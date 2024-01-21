import '../../../common/utils/pubspec/pubspec_utils.dart';

Future<void> installGet([bool runPubGet = false]) async {
  PubspecUtils.removeDependencies('get', logger: false);
  // TODO: 当 get 5 正式发布之后修改
  final isVersion5 = PubspecUtils.getxVersion == 5;
  final version = isVersion5 ? '5.0.0-release-candidate-5' : null;
  final isPrerelease = version?.contains('release') ?? false;
  await PubspecUtils.addDependencies('get', runPubGet: runPubGet, version: version, isPrerelease: isPrerelease);
}
