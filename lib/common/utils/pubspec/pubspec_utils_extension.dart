part of 'pubspec_utils.dart';

/// 工具拓展
class PubspecUtilsExt {
  static final _pageName = _PubValue<String?>(
    () {
      try {
        var yaml = pubspecJson;
        if (yaml.containsKey('get_cli')) {
          if ((yaml['get_cli'] as Map).containsKey('page_name')) {
            return (yaml['get_cli']['page_name'] as String);
          }
        }
      } on Exception catch (_) {}
      return null;
    },
  );
  static final _translationClassName = _PubValue<String?>(() {
    try {
      var yaml = pubspecJson;
      if (yaml.containsKey('get_cli')) {
        if ((yaml['get_cli'] as Map).containsKey('intl')) {
          if (yaml['get_cli']['intl'] != null) {
            if ((yaml['get_cli']['intl'] as Map).containsKey('class_name')) {
              return (yaml['get_cli']['intl']['class_name'] as String);
            }
          }
        }
      }
    } on Exception catch (_) {}
    return null;
  });

  static final _getxVersion = _PubValue<int?>(
    () {
      try {
        var yaml = pubspecJson;
        if (yaml.containsKey('get_cli')) {
          if ((yaml['get_cli'] as Map).containsKey('version')) {
            return (yaml['get_cli']['version'] as int);
          }
        }
      } on Exception catch (_) {}
      return null;
    },
  );

  /// 配置的 Getx Version
  static int get getxVersion => _getxVersion.value ?? 4;

  /// 配置的 pageName
  static String get pageName => _pageName.value ?? 'page';

  static get pubspecJson => PubspecUtils.pubspecJson;

  /// 配置的 translationClassName
  static String? get translationClassName => _translationClassName.value;

  static bool updateGetCliYaml(
    String key,
    dynamic value, {
    bool logger = true,
  }) {
    try {
      var yaml = pubspecJson;
      final entries = (yaml['get_cli'] as YamlMap?)?.entries;
      var newVaule = Map.fromEntries(entries ?? {})..[key] = value;
      // 创建一个 YamlEditor 来编辑 YAML 文件
      final yamlEditor = YamlEditor(PubspecUtils.pubspecString);
      yamlEditor.update(
        ["get_cli"],
        newVaule,
      );
      _savePub(yamlEditor);
    } on Exception catch (_) {
      return false;
    }
    if (logger) {
      LogService.success(
          LocaleKeys.sucess_update_yaml.trArgs(['$key: $value']));
    }
    return true;
  }

  static void _savePub(YamlEditor yaml) {
    PubspecUtils._pubspecFile.writeAsStringSync(yaml.toString());
  }
}
