import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_getx_learning/routes/app_routes.dart';

/// GetX 声明式路由配置
/// 
/// 这是 GetX 推荐的路由定义方式
/// 使用 GetPages 配置所有路由，支持：
/// - 路由转换动画
/// - 参数传递
/// - 中间件
/// - 默认转换效果
class AppPages {
  AppPages._(); // 私有构造函数，防止实例化

  /// 应用的初始路由
  static const INITIAL = AppRoutes.HOME;

  /// 默认转换效果
  static final defaultTransition = Transition.cupertino;

  /// 默认转换时间
  static const defaultDurationTransition = Duration(milliseconds: 300);

  /// 所有页面配置
  static final pages = [
    // 主页
    GetPage(
      name: AppRoutes.HOME,
      page: () {
        // 需要导入主页面，这里是占位符
        return const Placeholder();
      },
      transition: Transition.native,
    ),
    
    // 状态管理页面
    GetPage(
      name: AppRoutes.STATE_MANAGEMENT,
      page: () => const Placeholder(),
      transition: defaultTransition,
      transitionDuration: defaultDurationTransition,
    ),
    
    // 计数器页面
    GetPage(
      name: AppRoutes.COUNTER,
      page: () => const Placeholder(),
      transition: defaultTransition,
      transitionDuration: defaultDurationTransition,
    ),
    
    // 响应式编程页面
    GetPage(
      name: AppRoutes.REACTIVE,
      page: () => const Placeholder(),
      transition: defaultTransition,
      transitionDuration: defaultDurationTransition,
    ),
    
    // Workers 页面
    GetPage(
      name: AppRoutes.WORKERS,
      page: () => const Placeholder(),
      transition: defaultTransition,
      transitionDuration: defaultDurationTransition,
    ),
    
    // 依赖注入页面
    GetPage(
      name: AppRoutes.DEPENDENCY_INJECTION,
      page: () => const Placeholder(),
      transition: defaultTransition,
      transitionDuration: defaultDurationTransition,
    ),
    
    // 生命周期页面
    GetPage(
      name: AppRoutes.LIFECYCLE,
      page: () => const Placeholder(),
      transition: defaultTransition,
      transitionDuration: defaultDurationTransition,
    ),
    
    // 路由管理页面
    GetPage(
      name: AppRoutes.ROUTING,
      page: () => const Placeholder(),
      transition: defaultTransition,
      transitionDuration: defaultDurationTransition,
    ),
    
    // UI 更新方式页面
    GetPage(
      name: AppRoutes.UI_UPDATE,
      page: () => const Placeholder(),
      transition: defaultTransition,
      transitionDuration: defaultDurationTransition,
    ),
    
    // 本地存储页面
    GetPage(
      name: AppRoutes.STORAGE,
      page: () => const Placeholder(),
      transition: defaultTransition,
      transitionDuration: defaultDurationTransition,
    ),
    
    // 对话框页面
    GetPage(
      name: AppRoutes.DIALOG,
      page: () => const Placeholder(),
      transition: defaultTransition,
      transitionDuration: defaultDurationTransition,
    ),
  ];
}

/// GetX 页面转换效果说明
/// 
/// Transition.native - 原生效果（针对不同平台）
/// Transition.cupertino - iOS 风格的侧滑转换
/// Transition.fadeIn - 淡入效果
/// Transition.rightToLeft - 从右到左
/// Transition.leftToRight - 从左到右
/// Transition.upToDown - 从上到下
/// Transition.downToUp - 从下到上
/// Transition.zoom - 缩放效果
/// Transition.topLevel - 顶层效果
/// Transition.noTransition - 无转换效果（直接切换）
class TransitionExamples {
  static const String description = '''
  ============ GetX 页面转换效果 ============
  
  Transition.native
    - iOS 使用 cupertino（侧滑）
    - Android 使用 fadeIn（淡入）
    - 推荐用于通用应用
  
  Transition.cupertino
    - iOS 风格的侧滑转换
    - 推荐用于 iOS 优先的应用
  
  Transition.fadeIn
    - 淡入效果，页面逐渐显示
    - 轻微感觉
  
  Transition.rightToLeft
    - 新页面从右侧进入
    - 旧页面从左侧退出
  
  Transition.zoom
    - 缩放效果，页面放大显示
    - 强调感
  
  Transition.noTransition
    - 直接切换，无任何转换效果
    - 最快速度
  ''';
}
