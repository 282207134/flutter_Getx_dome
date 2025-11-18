import 'package:get/get.dart';

/// 应用国际化翻译
/// 
/// GetX 支持国际化（i18n），允许应用支持多种语言
/// 继承 Translations 类，定义每种语言的翻译
class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    // 中文 (简体)
    'zh_CN': {
      'app_title': 'Flutter GetX 学习',
      'home': '首页',
      'counter': '计数器',
      'reactive': '响应式',
      'workers': '工作者',
      'dependency': '依赖注入',
      'lifecycle': '生命周期',
      'routing': '路由管理',
      'ui_update': 'UI 更新',
      'storage': '本地存储',
      'dialog': '对话框',
      
      // 按钮
      'increment': '增加',
      'decrement': '减少',
      'reset': '重置',
      'login': '登录',
      'logout': '登出',
      'submit': '提交',
      'cancel': '取消',
      'save': '保存',
      'delete': '删除',
      
      // 提示信息
      'success': '成功',
      'error': '错误',
      'warning': '警告',
      'info': '信息',
      'loading': '加载中...',
      'no_data': '暂无数据',
      
      // 欢迎信息
      'welcome': '欢迎使用 GetX',
      'welcome_message': '这是一个 GetX 学习项目',
    },
    
    // 中文 (繁体)
    'zh_TW': {
      'app_title': 'Flutter GetX 學習',
      'home': '首頁',
      'counter': '計數器',
      'reactive': '響應式',
      'workers': '工作者',
      'dependency': '依賴注入',
      'lifecycle': '生命週期',
      'routing': '路由管理',
      'ui_update': 'UI 更新',
      'storage': '本地存儲',
      'dialog': '對話框',
      
      'increment': '增加',
      'decrement': '減少',
      'reset': '重置',
      'login': '登錄',
      'logout': '登出',
      'submit': '提交',
      'cancel': '取消',
      'save': '保存',
      'delete': '刪除',
      
      'success': '成功',
      'error': '錯誤',
      'warning': '警告',
      'info': '信息',
      'loading': '加載中...',
      'no_data': '暫無數據',
      
      'welcome': '歡迎使用 GetX',
      'welcome_message': '這是一個 GetX 學習項目',
    },
    
    // 英文
    'en_US': {
      'app_title': 'Flutter GetX Learning',
      'home': 'Home',
      'counter': 'Counter',
      'reactive': 'Reactive',
      'workers': 'Workers',
      'dependency': 'Dependency Injection',
      'lifecycle': 'Lifecycle',
      'routing': 'Routing',
      'ui_update': 'UI Update',
      'storage': 'Local Storage',
      'dialog': 'Dialog',
      
      'increment': 'Increment',
      'decrement': 'Decrement',
      'reset': 'Reset',
      'login': 'Login',
      'logout': 'Logout',
      'submit': 'Submit',
      'cancel': 'Cancel',
      'save': 'Save',
      'delete': 'Delete',
      
      'success': 'Success',
      'error': 'Error',
      'warning': 'Warning',
      'info': 'Info',
      'loading': 'Loading...',
      'no_data': 'No Data',
      
      'welcome': 'Welcome to GetX',
      'welcome_message': 'This is a GetX learning project',
    },
  };
}

/// 国际化使用示例
/// 
/// 在应用中使用翻译的方式：
/// 
/// 1. 在 GetMaterialApp 中配置：
///    ```dart
///    GetMaterialApp(
///      translations: AppTranslations(),
///      locale: const Locale('zh', 'CN'),
///      fallbackLocale: const Locale('en', 'US'),
///    )
///    ```
/// 
/// 2. 在代码中使用翻译：
///    ```dart
///    Text('app_title'.tr)  // 获取翻译
///    Text('welcome'.tr)
///    ```
/// 
/// 3. 切换语言：
///    ```dart
///    Get.updateLocale(const Locale('en', 'US'));
///    ```
/// 
/// 4. 获取当前语言：
///    ```dart
///    print(Get.locale);  // Locale('zh', 'CN')
///    ```
class I18nExamples {
  static void demonstrateTranslations() {
    print('====== GetX 国际化使用示例 ======\n');
    
    print('1. 获取翻译字符串');
    print('   "app_title".tr  →  ${AppTranslations().keys['zh_CN']?['app_title']}');
    
    print('\n2. 切换语言');
    print('   Get.updateLocale(const Locale("en", "US"))');
    print('   之后 "app_title".tr 会返回英文版本');
    
    print('\n3. 获取当前语言');
    print('   Get.locale  →  当前的 Locale 对象');
    
    print('\n4. 语言代码');
    print('   zh_CN - 简体中文');
    print('   zh_TW - 繁体中文');
    print('   en_US - 美式英文');
    
    print('\n5. 在 UI 中使用');
    print('   Text("app_title".tr)');
    print('   ElevatedButton(');
    print('     onPressed: () {},');
    print('     child: Text("submit".tr),');
    print('   )');
  }
}
