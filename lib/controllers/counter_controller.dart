import 'package:get/get.dart';

/// 计数器控制器
/// 
/// 这是一个简单的 GetxController 示例，展示了：
/// 1. 如何创建响应式变量 (RxInt, RxString)
/// 2. 如何创建方法来修改状态
/// 3. 生命周期管理 (onInit, onClose)
/// 4. 使用 ever() 监听变量变化
class CounterController extends GetxController {
  /// 计数值 - 使用 RxInt 使其成为响应式的
  /// RxInt 继承自 Rx<int>，是一个特殊的响应式类型
  final RxInt count = 0.obs; // .obs 是 .asObservable() 的快捷方式
  
  /// 点击次数
  final RxInt clickCount = 0.obs;
  
  /// 显示消息
  final RxString message = ''.obs;
  
  /// 是否正在加载
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    print('[CounterController] 初始化完成');
    
    // 使用 ever() 监听 count 的每一次变化
    // ever() 会立即执行一次，然后在每次值变化时执行
    ever(count, (value) {
      print('[CounterController] count 已更新: $value');
      if (value > 0 && value % 5 == 0) {
        message.value = '🎉 计数达到 $value 了！';
      }
    });
    
    // 使用 once() 只监听一次变化
    // 第一次值变化后就不再监听
    once(count, (value) {
      print('[CounterController] 第一次检测到 count 变化: $value');
    });
  }

  @override
  void onClose() {
    super.onClose();
    print('[CounterController] 控制器已销毁');
  }

  /// 增加计数
  /// 
  /// 当用户点击"增加"按钮时调用此方法
  /// count 变量的值会自动通知所有监听者，触发 UI 重新构建
  void increment() {
    count.value++;
    clickCount.value++;
  }

  /// 减少计数
  void decrement() {
    count.value--;
    clickCount.value++;
  }

  /// 重置计数
  void reset() {
    count.value = 0;
    clickCount.value = 0;
    message.value = '';
  }

  /// 模拟异步操作（如网络请求）
  /// 
  /// 这个方法展示了如何处理异步操作并更新 UI
  Future<void> fetchData() async {
    try {
      // 设置加载状态为 true
      isLoading.value = true;
      
      // 模拟网络延迟
      await Future.delayed(const Duration(seconds: 2));
      
      // 更新计数
      count.value += 10;
      message.value = '📡 数据加载完成！';
    } catch (e) {
      message.value = '❌ 加载失败: $e';
    } finally {
      // 加载完成
      isLoading.value = false;
    }
  }

  /// 自定义获取器：获取计数的两倍
  /// 
  /// Rx 变量虽然可以直接读取，但最佳实践是通过 getter 暴露
  int get doubleCount => count.value * 2;

  /// 获取当前状态的文本描述
  String get statusText {
    if (count.value < 0) return '😢 计数为负数';
    if (count.value == 0) return '😐 计数为零';
    if (count.value < 5) return '😊 计数较小';
    if (count.value < 10) return '😄 计数中等';
    return '🚀 计数很大';
  }
}

/// 简单计数器控制器 - 展示最小化用法
/// 
/// 这是一个更简洁的例子，如果你只需要处理简单的状态
class SimpleCounterController extends GetxController {
  // 使用 .obs 快速创建响应式变量
  final count = 0.obs;

  // 简单的增量方法
  increment() => count.value++;

  // 简单的减量方法
  decrement() => count.value--;

  // 这种简洁写法适合简单的业务逻辑
}
