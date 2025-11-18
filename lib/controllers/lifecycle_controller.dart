import 'dart:async';

import 'package:get/get.dart';

/// 生命周期控制器
///
/// GetxController 提供了完整的生命周期回调，让你在适当的时刻执行初始化和清理工作
///
/// 生命周期顺序：
/// 1. 构造函数 (Constructor)
/// 2. onInit() - 初始化
/// 3. onReady() - 准备完毕，小部件已构建
/// 4. ... 运行中 ...
/// 5. onClose() - 销毁，清理资源
class LifecycleController extends GetxController {
  /// 日志列表
  final RxList<String> logs = <String>[].obs;

  /// 是否已初始化
  final RxBool isInitialized = false.obs;

  /// 是否已准备就绪
  final RxBool isReady = false.obs;

  /// 运行时间（秒）
  final RxInt runtimeSeconds = 0.obs;
  Timer? _timer;

  /// 构造函数
  ///
  /// 注意：在构造函数中，响应式变量可能尚未完全初始化
  /// 建议在 onInit() 中执行初始化逻辑
  LifecycleController() {
    addLog('1️⃣  构造函数被调用');
  }

  /// 初始化方法 (最先调用的生命周期回调)
  ///
  /// 在这个方法中：
  /// - 初始化响应式变量
  /// - 设置监听器
  /// - 加载本地数据
  /// - 但不要在这里访问 UI 元素
  @override
  void onInit() {
    super.onInit();
    addLog('2️⃣  onInit() 被调用 - 初始化时刻');
    isInitialized.value = true;

    // 这是初始化数据的好地方
    // 比如从本地存储加载数据
    _loadInitialData();

    // 设置监听器
    ever(runtimeSeconds, (seconds) {
      // 每当运行时间改变时执行
    });
  }

  /// 准备就绪方法
  ///
  /// 在这个方法中：
  /// - 页面小部件已经构建完成
  /// - 可以安全地访问上下文
  /// - 可以执行 API 调用
  /// - 适合获取远程数据
  ///
  /// onReady() 在 onInit() 之后调用
  @override
  void onReady() {
    super.onReady();
    addLog('3️⃣  onReady() 被调用 - 页面已构建');
    isReady.value = true;

    // 在这里执行 API 调用或其他耗时操作
    _fetchRemoteData();

    // 启动定时器来记录运行时间
    _startTimer();
  }

  /// 销毁方法 (最后调用的生命周期回调)
  ///
  /// 在这个方法中：
  /// - 取消订阅
  /// - 停止定时器
  /// - 释放资源
  /// - 清理缓存
  ///
  /// 必须调用 super.onClose()
  @override
  void onClose() {
    addLog('5️⃣  onClose() 被调用 - 清理资源');
    isReady.value = false;
    _stopTimer();
    super.onClose();
  }

  // ==================== 辅助方法 ====================

  /// 添加日志
  void addLog(String message) {
    logs.add('[${DateTime.now().toIso8601String()}] $message');
    print(message);
  }

  /// 清空日志
  void clearLogs() {
    logs.clear();
  }

  /// 加载初始数据
  void _loadInitialData() {
    addLog('📂 正在加载初始数据...');
    // 模拟加载本地数据
    Future.delayed(const Duration(milliseconds: 500), () {
      addLog('✅ 初始数据加载完成');
    });
  }

  /// 获取远程数据
  void _fetchRemoteData() {
    addLog('🌐 正在获取远程数据...');
    // 模拟 API 调用
    Future.delayed(const Duration(seconds: 2), () {
      addLog('✅ 远程数据获取完成');
    });
  }

  /// 启动计时器
  void _startTimer() {
    addLog('⏱️  计时器已启动');
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      runtimeSeconds.value++;
    });
  }

  /// 停止计时器
  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
    addLog('⏱️  计时器已停止，总运行时间: ${runtimeSeconds.value} 秒');
  }

  /// 获取运行时间的友好格式
  String get runtimeText {
    final seconds = runtimeSeconds.value;
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    if (minutes > 0) {
      return '$minutes 分 $remainingSeconds 秒';
    }
    return '$seconds 秒';
  }
}

/// 另一个演示生命周期的控制器
///
/// 这个控制器展示如何正确处理资源和避免内存泄漏
class ResourceManagementController extends GetxController {
  /// 订阅列表
  final List<String> subscriptions = [];

  /// 定时器列表
  final List<Future<void>?> timers = [];

  @override
  void onInit() {
    super.onInit();
    print('[ResourceManagement] 初始化开始');
    _setupSubscriptions();
  }

  @override
  void onReady() {
    super.onReady();
    print('[ResourceManagement] 页面已准备，开始监听');
  }

  @override
  void onClose() {
    super.onClose();
    print('[ResourceManagement] 开始清理资源');
    _cleanupSubscriptions();
    _cleanupTimers();
    super.onClose();
  }

  /// 设置订阅
  void _setupSubscriptions() {
    // 模拟添加订阅
    subscriptions.add('subscription_1');
    subscriptions.add('subscription_2');
    subscriptions.add('subscription_3');
    print('[ResourceManagement] 已创建 ${subscriptions.length} 个订阅');
  }

  /// 清理订阅 - 必须在 onClose() 中做
  void _cleanupSubscriptions() {
    for (final subscription in subscriptions) {
      print('[ResourceManagement] 取消订阅: $subscription');
    }
    subscriptions.clear();
  }

  /// 清理定时器 - 必须在 onClose() 中做
  void _cleanupTimers() {
    print('[ResourceManagement] 停止 ${timers.length} 个定时器');
    timers.clear();
  }
}

/// 生命周期最佳实践
///
/// 总结：
/// 1. 在 onInit() 中初始化数据和设置监听器
/// 2. 在 onReady() 中执行 API 调用
/// 3. 在 onClose() 中清理所有资源
/// 4. 避免在构造函数中做太多工作
/// 5. 确保所有异步操作都在正确的生命周期阶段启动
/// 6. 必须在 onClose() 中取消所有订阅和计时器，避免内存泄漏
class LifecycleBestPractices {
  static const String guide = '''
  ============ GetxController 生命周期最佳实践 ============
  
  【构造函数】
  - 最小化初始化工作
  - 不要访问 Context
  - 不要启动定时器或异步操作
  
  【onInit()】
  - 初始化响应式变量
  - 设置监听器（ever, once, debounce, throttle）
  - 加载本地数据
  - 不要做耗时操作
  
  【onReady()】
  - 小部件已构建，可以访问 Context
  - 执行 API 调用获取远程数据
  - 启动定时器或长期任务
  - 更新 UI 不需要的后台操作
  
  【onClose()】
  - 必须清理所有资源！
  - 取消所有订阅
  - 停止所有定时器
  - 释放大对象引用
  - 调用 super.onClose()
  
  【常见错误】
  ❌ 在 onInit() 中做大量网络请求
  ❌ 忘记在 onClose() 中取消订阅
  ❌ 在构造函数中访问 Context
  ❌ 在 onClose() 中没有调用 super
  
  【正确做法】
  ✅ 数据初始化 -> onInit()
  ✅ API 调用 -> onReady()
  ✅ 资源清理 -> onClose()
  ''';
}
