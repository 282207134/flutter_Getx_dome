/// 路由名称常量
/// 
/// 这个类定义了应用中所有的路由名称
/// 使用常量避免路由名称拼写错误
class AppRoutes {
  // 主页
  static const String HOME = '/';
  
  // 学习页面
  static const String STATE_MANAGEMENT = '/state-management';
  static const String COUNTER = '/counter';
  static const String REACTIVE = '/reactive';
  static const String WORKERS = '/workers';
  static const String DEPENDENCY_INJECTION = '/dependency-injection';
  static const String LIFECYCLE = '/lifecycle';
  static const String ROUTING = '/routing';
  static const String UI_UPDATE = '/ui-update';
  static const String STORAGE = '/storage';
  static const String DIALOG = '/dialog';
  
  // 详情页面示例
  static const String USER_DETAIL = '/user/:id';
  static const String PRODUCT_DETAIL = '/product/:id';
}
