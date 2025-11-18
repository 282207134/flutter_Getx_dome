# Flutter GetX 学习项目

这是一个全面的 Flutter GetX 框架学习项目，包含详细的中文代码注释和完整的文档说明。通过实际例子学习 GetX 的各种功能。

## 📱 项目概述

本项目涵盖 GetX 框架的核心功能：

1. **基础状态管理** - 学习简单的响应式变量
2. **计数器示例** - GetxController 的基本使用
3. **响应式编程** - Rx 类型详解（RxInt, RxString, RxList, RxMap 等）
4. **工作者 (Workers)** - ever(), once(), debounce(), throttle() 的使用
5. **依赖注入** - Get.put(), Get.lazyPut() 等方法
6. **生命周期管理** - onInit(), onReady(), onClose() 等回调
7. **路由管理** - GetX 的声明式路由和参数传递
8. **UI 更新方式** - GetBuilder 和 Obx 的对比
9. **本地存储** - GetStorage 的使用
10. **对话框和通知** - Get.dialog, Get.snackbar 等

## 🚀 快速开始

### 环境要求

- Flutter SDK >= 2.19.0
- Dart SDK >= 2.19.0

### 安装依赖

```bash
flutter pub get
```

### 运行项目

```bash
flutter run
```

## 📚 项目结构

```
lib/
├── main.dart                     # 应用入口和首页
├── controllers/                  # 控制器目录
│   ├── counter_controller.dart      # 计数器控制器
│   ├── reactive_controller.dart     # 响应式编程控制器
│   ├── workers_controller.dart      # 工作者控制器
│   ├── lifecycle_controller.dart    # 生命周期控制器
│   └── user_controller.dart         # 用户控制器
├── routes/                       # 路由目录
│   ├── app_routes.dart             # 路由常量定义
│   └── app_pages.dart              # 路由页面配置
├── translations/                 # 国际化目录
│   └── app_translations.dart       # 翻译配置
├── views/                        # 视图目录（可扩展）
└── models/                       # 模型目录（可扩展）
```

## 💡 核心概念解析

### 1. 响应式变量 (Rx Types)

GetX 提供了响应式变量，使状态管理更加简单直观。

```dart
// 基础类型
final RxInt count = 0.obs;              // 响应式整数
final RxString name = ''.obs;           // 响应式字符串
final RxBool isLoading = false.obs;     // 响应式布尔值

// 集合类型
final RxList<String> items = <String>[].obs;  // 响应式列表
final RxMap<String, int> scores = <String, int>{}.obs;  // 响应式字典

// 复杂对象
final Rx<User> user = Rx<User>(User(...));  // 响应式自定义对象
```

### 2. 控制器 (GetxController)

GetxController 是状态管理的中心，提供生命周期管理和状态通知。

```dart
class MyController extends GetxController {
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // 初始化逻辑
  }

  @override
  void onClose() {
    super.onClose();
    // 清理资源
  }

  void increment() {
    count.value++;
  }
}
```

### 3. 工作者 (Workers)

Workers 用于监听响应式变量的变化，支持防抖和节流。

```dart
// ever() - 每次变化都执行
ever(count, (value) {
  print('Count changed to $value');
});

// once() - 只执行一次
once(count, (value) {
  print('Count first changed to $value');
});

// debounce() - 防抖，延迟执行
debounce(searchQuery, (value) {
  performSearch(value);
}, time: const Duration(milliseconds: 800));

// throttle() - 节流，控制执行频率
throttle(userInput, (value) {
  processInput(value);
}, time: const Duration(milliseconds: 1000));
```

### 4. 依赖注入 (Dependency Injection)

GetX 提供强大的依赖注入支持。

```dart
// Put - 创建单例
Get.put(MyController());

// Find - 获取已注入的控制器
final controller = Get.find<MyController>();

// LazyPut - 延迟创建
Get.lazyPut(() => MyController());

// Create - 每次都创建新实例
Get.create(() => MyController());
```

### 5. UI 更新方式

两种主要的 UI 更新方式：

```dart
// Obx - 响应式更新（推荐）
Obx(() => Text(controller.count.toString()));

// GetBuilder - 手动更新
GetBuilder<MyController>(
  builder: (controller) => Text(controller.count.toString()),
);
```

### 6. 路由管理

GetX 支持命令式和声明式路由。

```dart
// 命令式路由（简单）
Get.to(() => NextPage());
Get.off(() => NextPage());  // 替换当前页面
Get.offAll(() => HomePage());  // 清空路由栈

// 声明式路由（复杂）
GetMaterialApp(
  getPages: AppPages.pages,
  initialRoute: AppRoutes.HOME,
);
```

### 7. 生命周期管理

GetxController 的生命周期回调：

```dart
class MyController extends GetxController {
  @override
  void onInit() {
    // 初始化
    super.onInit();
  }

  @override
  void onReady() {
    // 页面已构建，可以做 API 调用
    super.onReady();
  }

  @override
  void onClose() {
    // 清理资源
    super.onClose();
  }
}
```

## 📖 学习路径

### 初级 (第 1-2 天)

1. 理解响应式变量的概念
2. 创建第一个简单的 GetxController
3. 使用 Obx 更新 UI
4. 学习基本的状态修改

### 中级 (第 3-5 天)

1. 学习 Workers（ever, once, debounce, throttle）
2. 理解生命周期管理
3. 学习依赖注入的各种方法
4. 掌握 GetBuilder 的用法

### 高级 (第 6-7 天)

1. 综合运用多个控制器
2. 实现复杂的业务逻辑
3. 性能优化
4. 国际化和本地存储

## 🎯 常见使用场景

### 1. 计数器应用

```dart
class CounterController extends GetxController {
  final count = 0.obs;
  
  increment() => count.value++;
  decrement() => count.value--;
}

// 在 UI 中使用
Obx(() => Text(controller.count.toString()))
```

### 2. 搜索功能（使用 debounce）

```dart
debounce(searchQuery, (String query) {
  performSearch(query);
}, time: const Duration(milliseconds: 800));
```

### 3. 按钮快速点击（使用 throttle）

```dart
throttle(buttonClick, (value) {
  submitForm();
}, time: const Duration(seconds: 1));
```

### 4. 表单管理

```dart
final name = ''.obs;
final email = ''.obs;
final isSubmitting = false.obs;

void submit() {
  isSubmitting.value = true;
  // 提交逻辑
}
```

### 5. 用户认证

```dart
final user = Rx<User?>(null);
final isLoggedIn = false.obs;

void login(String email, String password) async {
  user.value = await api.login(email, password);
  isLoggedIn.value = true;
}
```

## ⚡ 最佳实践

### 1. 始终使用 GetxController

```dart
// ✅ 好的做法
class MyController extends GetxController {
  final count = 0.obs;
  increment() => count.value++;
}

// ❌ 避免
RxInt count = 0.obs; // 不在控制器中
```

### 2. 在生命周期中做正确的事

```dart
@override
void onInit() {
  super.onInit();
  // 加载本地数据
  _loadLocalData();
}

@override
void onReady() {
  super.onReady();
  // 做网络请求
  _fetchRemoteData();
}

@override
void onClose() {
  super.onClose();
  // 清理资源，取消订阅
  _cleanup();
  super.onClose();
}
```

### 3. 合理使用 Obx 和 GetBuilder

```dart
// ✅ 使用 Obx 的简单情况
Obx(() => Text(controller.name.value))

// ✅ 使用 GetBuilder 的复杂情况
GetBuilder<MyController>(
  builder: (controller) {
    return ListView.builder(
      itemCount: controller.items.length,
      itemBuilder: (context, index) {
        return Text(controller.items[index]);
      },
    );
  },
)
```

### 4. 避免内存泄漏

```dart
@override
void onClose() {
  // ✅ 取消所有订阅
  subscriptions.forEach((sub) => sub.cancel());
  
  // ✅ 停止所有计时器
  timers.forEach((timer) => timer.cancel());
  
  // ✅ 最后调用 super
  super.onClose();
}
```

### 5. 使用 Get.find() 访问全局控制器

```dart
// Put 时
Get.put(UserController());

// 其他地方访问
final userController = Get.find<UserController>();
```

## 🐛 常见问题

### Q1: 控制器没有及时更新 UI

**A:** 确保使用了 `.obs` 使变量变成响应式的：

```dart
final count = 0.obs;  // ✅ 正确
final count = 0;      // ❌ 错误
```

### Q2: 内存泄漏怎么办

**A:** 务必在 `onClose()` 中清理所有资源：

```dart
@override
void onClose() {
  super.onClose();
  // 清理
}
```

### Q3: Obx 和 GetBuilder 哪个更好

**A:** 根据使用场景选择：
- 简单单个变量：Obx
- 复杂逻辑或列表：GetBuilder

### Q4: 如何切换语言

**A:** 使用 `Get.updateLocale()`：

```dart
Get.updateLocale(const Locale('en', 'US'));
```

## 📚 参考资源

- [GetX 官方文档](https://github.com/jonataslaw/getx)
- [GetX 中文文档](https://github.com/jonataslaw/getx/wiki)
- [Dart 官方文档](https://dart.dev/guides)
- [Flutter 官方文档](https://flutter.dev/docs)

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📝 许可证

MIT License

## 🎓 学习建议

1. **阅读代码** - 每个文件都有详细的中文注释
2. **运行示例** - 在真实应用中体验效果
3. **修改代码** - 尝试自己修改和扩展
4. **构建项目** - 使用 GetX 构建自己的项目
5. **阅读文档** - 查看 GetX 官方文档深入学习

---

祝你学习愉快！🚀
