import 'package:get/get.dart';

/// 工作者 (Workers) 控制器
///
/// GetX 提供了四种监听变量变化的方式：
/// 1. ever() - 监听每一次变化（包括初始化）
/// 2. once() - 只监听一次变化
/// 3. debounce() - 防抖，等待一段时间后才执行
/// 4. interval() - 节流，在指定时间内只执行一次
///
/// 这些方法都是 Worker，用于处理响应式编程中的副作用（Side Effects）
class WorkersController extends GetxController {
  /// 搜索关键词
  final RxString searchQuery = ''.obs;

  /// 用户输入
  final RxString userInput = ''.obs;

  /// 计数值
  final RxInt counter = 0.obs;

  /// 按钮点击计数
  final RxInt clickCount = 0.obs;

  /// 搜索结果
  final RxList<String> searchResults = <String>[].obs;

  /// 日志记录
  final RxList<String> logs = <String>[].obs;

  /// 模拟数据库
  final List<String> database = [
    'Flutter',
    'Dart',
    'GetX',
    'Riverpod',
    'Provider',
    'Bloc',
    'Redux',
    '响应式编程',
    '状态管理',
    '依赖注入',
  ];

  @override
  void onInit() {
    super.onInit();
    addLog('[WorkersController] 初始化完成');

    // ==================== ever() 示例 ====================
    // ever() 会立即执行一次，然后在每次值变化时执行
    // 用于需要立即响应的场景
    ever(counter, (int value) {
      addLog('[ever] counter 值已更新为: $value');
    });

    // ==================== once() 示例 ====================
    // once() 只监听一次值变化，然后自动停止监听
    // 用于只需响应一次的场景，比如初始化后的第一次更新
    once(clickCount, (int value) {
      addLog('[once] 首次检测到点击计数变化: $value');
    });

    // ==================== debounce() 示例 ====================
    // debounce() 防抖：当变量在指定时间内频繁变化时，
    // 只在最后一次变化后的指定延迟后执行
    //
    // 典型应用场景：
    // - 搜索框输入：等待用户停止输入后再发送搜索请求
    // - 表单验证：等待用户停止输入后再验证
    debounce(
      searchQuery,
      (String query) {
        addLog('[debounce] 执行搜索: "$query" (防抖后)');
        // 执行搜索操作
        _performSearch(query);
      },
      time: const Duration(milliseconds: 800),
    );

    // ==================== interval() 示例 ====================
    // interval() 节流：在指定时间内，变量变化时只执行一次
    //
    // 与 debounce() 的区别：
    // - interval() 会在指定时间间隔内立即执行第一次，然后等待
    // - debounce() 会等待，直到指定时间内没有新的变化
    //
    // 典型应用场景：
    // - 按钮快速点击：防止重复提交
    // - 滚动事件：防止高频触发
    interval(
      userInput,
      (String input) {
        addLog('[interval] 用户输入已处理: "$input" (节流后)');
        // 处理用户输入
        _processUserInput(input);
      },
      time: const Duration(milliseconds: 1000),
    );
  }

  @override
  void onClose() {
    super.onClose();
    addLog('[WorkersController] 控制器已销毁');
  }

  /// 添加日志
  void addLog(String message) {
    logs.add(message);
    print(message);
  }

  /// 清空日志
  void clearLogs() {
    logs.clear();
  }

  // ==================== 方法实现 ====================

  /// 执行搜索
  ///
  /// 模拟搜索操作，在真实应用中这可能是 API 调用
  void _performSearch(String query) {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    // 模拟搜索延迟
    Future.delayed(const Duration(milliseconds: 200), () {
      final results = database
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
      searchResults.value = results;
    });
  }

  /// 处理用户输入
  void _processUserInput(String input) {
    // 在这里处理用户输入
    // 比如表单验证、数据格式化等
  }

  /// 更新搜索关键词
  ///
  /// 这会触发 debounce，防止频繁搜索
  void updateSearchQuery(String query) {
    searchQuery.value = query;
    addLog('[手动] 搜索框输入: "$query"');
  }

  /// 更新用户输入
  ///
  /// 这会触发 interval，控制处理频率
  void updateUserInput(String input) {
    userInput.value = input;
    addLog('[手动] 用户输入: "$input"');
  }

  /// 增加计数
  ///
  /// 触发 ever 监听
  void increment() {
    counter.value++;
    addLog('[手动] 计数增加');
  }

  /// 减少计数
  void decrement() {
    counter.value--;
    addLog('[手动] 计数减少');
  }

  /// 点击按钮
  ///
  /// 第一次点击会触发 once 监听，后续点击不会
  void onButtonClick() {
    clickCount.value++;
    addLog('[手动] 按钮被点击');
  }

  /// 重置所有状态
  void reset() {
    searchQuery.value = '';
    userInput.value = '';
    counter.value = 0;
    clickCount.value = 0;
    searchResults.clear();
    clearLogs();
    addLog('[手动] 所有状态已重置');
  }

  // ==================== 计算属性 ====================

  /// 搜索结果数量
  int get searchResultCount => searchResults.length;

  /// 是否有搜索结果
  bool get hasSearchResults => searchResults.isNotEmpty;

  /// 日志数量
  int get logCount => logs.length;
}

/// Worker 对比示例
///
/// 这个示例展示不同 Worker 类型的执行时机差异
class WorkerComparisonExample {
  static void demonstrateWorkers() {
    final counter = 0.obs;

    print('========== Worker 执行时机对比 ==========\n');

    // ever() - 立即执行一次 + 每次变化时执行
    print('ever() - 立即执行 + 响应所有变化');
    ever(counter, (value) {
      print('  [ever] counter = $value');
    });

    // once() - 不立即执行，只响应第一次变化
    print('once() - 仅响应第一次变化');
    once(counter, (value) {
      print('  [once] counter = $value (仅此一次)');
    });

    // debounce() - 防抖，延迟执行最后一次变化
    print('debounce() - 防抖，延迟执行最后一次变化');
    debounce(counter, (value) {
      print('  [debounce] counter = $value (防抖后)');
    }, time: const Duration(milliseconds: 500));

    // interval() - 节流，控制执行频率
    print('interval() - 节流，控制执行频率');
    interval(counter, (value) {
      print('  [interval] counter = $value (节流后)');
    }, time: const Duration(milliseconds: 500));

    print('\n输出顺序和次数会因为防抖和节流而不同\n');
  }
}
