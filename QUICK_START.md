# GetX 快速开始指南

这是一个 15 分钟快速入门教程，让你快速了解 GetX 的核心概念。

## 第 1 步：安装 GetX（1 分钟）

在 `pubspec.yaml` 中添加依赖：

```yaml
dependencies:
  flutter:
    sdk: flutter
  get: ^4.6.5
```

然后运行：

```bash
flutter pub get
```

## 第 2 步：创建你的第一个控制器（2 分钟）

```dart
import 'package:get/get.dart';

class FirstController extends GetxController {
  // 1. 创建响应式变量
  final count = 0.obs;
  
  // 2. 创建方法
  void increment() {
    count.value++;
  }
  
  void decrement() {
    count.value--;
  }
}
```

**关键点：**
- 继承 `GetxController`
- 使用 `.obs` 使变量响应式
- 通过 `.value` 修改值

## 第 3 步：使用 GetMaterialApp（1 分钟）

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(  // 使用 GetMaterialApp
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
```

## 第 4 步：创建 UI 并绑定数据（3 分钟）

```dart
class HomePage extends StatelessWidget {
  // 1. 注入控制器
  final controller = Get.put(FirstController());
  
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的第一个 GetX 应用'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('计数器值：'),
            // 2. 使用 Obx 进行响应式更新
            Obx(() {
              return Text(
                controller.count.toString(),
                style: const TextStyle(fontSize: 48),
              );
            }),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: controller.decrement,
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 20),
                FloatingActionButton(
                  onPressed: controller.increment,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

**关键点：**
- `Get.put()` 注入控制器
- `Obx()` 创建响应式 UI
- 当 `count` 改变时，`Obx` 中的 UI 自动重建

## 第 5 步：运行应用（1 分钟）

```bash
flutter run
```

现在你应该看到一个可工作的计数器应用！

---

## 理解核心概念

### 概念 1：响应式变量 (.obs)

```dart
// 普通变量（不会触发 UI 更新）
int count = 0;

// 响应式变量（改变时触发 UI 更新）
final RxInt count = 0.obs;

// 快捷方式（自动推断类型）
final count = 0.obs;  // RxInt
final name = ''.obs;  // RxString
final items = <String>[].obs;  // RxList<String>
```

### 概念 2：获取和修改值

```dart
// 获取值
int value = count.value;  // 获取 RxInt 的值

// 修改值
count.value = 5;          // 修改值，触发 UI 更新

// 快速操作
count.value++;            // 增加
name.value = '新名字';    // 修改字符串

// 列表操作
items.add('新项');        // 自动触发 UI 更新
items.remove('旧项');
items.clear();
```

### 概念 3：Obx 响应式 UI

```dart
// 简单用法
Obx(() => Text(controller.count.toString()))

// 多个变量
Obx(() {
  return Column(
    children: [
      Text(controller.name.value),
      Text(controller.count.toString()),
    ],
  );
})

// 复杂逻辑
Obx(() {
  if (controller.isLoading.value) {
    return const CircularProgressIndicator();
  }
  return Text(controller.data.value);
})
```

### 概念 4：Get.put() 依赖注入

```dart
// 在应用启动时注入
Get.put(UserController());

// 在任何地方都可以获取
final userController = Get.find<UserController>();

// 使用 shortcut
Get.find<UserController>().user.value
```

### 概念 5：导航（路由）

```dart
// 打开新页面
Get.to(() => NextPage());

// 打开新页面并关闭当前
Get.off(() => NextPage());

// 返回上一页
Get.back();

// 传递参数
Get.to(
  () => NextPage(),
  arguments: {'id': 123, 'name': '张三'},
);

// 接收参数
final args = Get.arguments;
print(args['id']);  // 123
```

---

## 实用示例

### 示例 1：简单列表

```dart
class ListController extends GetxController {
  final items = <String>['苹果', '香蕉', '橙子'].obs;
  
  void addItem(String item) {
    items.add(item);  // 自动触发 UI 更新
  }
  
  void removeItem(String item) {
    items.remove(item);
  }
}

class ListPage extends StatelessWidget {
  final controller = Get.put(ListController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('我的列表')),
      body: Obx(() {
        return ListView.builder(
          itemCount: controller.items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(controller.items[index]),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  controller.removeItem(controller.items[index]);
                },
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.addItem('新水果');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

### 示例 2：表单输入

```dart
class FormController extends GetxController {
  final name = ''.obs;
  final email = ''.obs;
  final isSubmitting = false.obs;
  
  bool get isFormValid => name.isNotEmpty && email.isNotEmpty;
  
  Future<void> submit() async {
    if (!isFormValid) {
      Get.snackbar('错误', '请填写所有字段');
      return;
    }
    
    isSubmitting.value = true;
    try {
      // 模拟提交
      await Future.delayed(const Duration(seconds: 2));
      Get.snackbar('成功', '提交成功！');
    } finally {
      isSubmitting.value = false;
    }
  }
}

class FormPage extends StatelessWidget {
  final controller = Get.put(FormController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('表单')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => controller.name.value = value,
              decoration: const InputDecoration(labelText: '名字'),
            ),
            TextField(
              onChanged: (value) => controller.email.value = value,
              decoration: const InputDecoration(labelText: '邮箱'),
            ),
            const SizedBox(height: 20),
            Obx(() {
              return ElevatedButton(
                onPressed: controller.isSubmitting.value
                    ? null
                    : controller.submit,
                child: controller.isSubmitting.value
                    ? const CircularProgressIndicator()
                    : const Text('提交'),
              );
            }),
          ],
        ),
      ),
    );
  }
}
```

### 示例 3：监听变量变化

```dart
class WatcherController extends GetxController {
  final searchQuery = ''.obs;
  final searchResults = <String>[].obs;

  final database = ['Flutter', 'Dart', 'GetX', 'Provider'];

  @override
  void onInit() {
    super.onInit();
    
    // 监听 searchQuery 的变化（防抖 800ms）
    debounce(
      searchQuery,
      (query) {
        if (query.isEmpty) {
          searchResults.clear();
        } else {
          searchResults.value = database
              .where((item) =>
                  item.toLowerCase().contains(query.toLowerCase()))
              .toList();
        }
      },
      time: const Duration(milliseconds: 800),
    );
  }
}

class SearchPage extends StatelessWidget {
  final controller = Get.put(WatcherController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('搜索')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (value) => controller.searchQuery.value = value,
              decoration: const InputDecoration(
                hintText: '搜索...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: controller.searchResults.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(controller.searchResults[index]),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
```

---

## 常见错误

### ❌ 错误 1：忘记使用 .obs

```dart
// 错误
final count = 0;  // 普通变量

// 正确
final count = 0.obs;  // 响应式变量
```

### ❌ 错误 2：没有使用 Obx 或 GetBuilder

```dart
// 错误
Text(controller.count.toString())  // UI 不会更新

// 正确
Obx(() => Text(controller.count.toString()))  // UI 会自动更新
```

### ❌ 错误 3：忘记使用 .value

```dart
// 错误
controller.count++;  // 不会更新

// 正确
controller.count.value++;  // 会正确更新
```

### ❌ 错误 4：在 onClose 中忘记清理资源

```dart
// 错误
@override
void onClose() {
  super.onClose();
  // 没有清理定时器和订阅
}

// 正确
@override
void onClose() {
  timers.forEach((timer) => timer.cancel());
  subscriptions.forEach((sub) => sub.cancel());
  super.onClose();
}
```

---

## 下一步

现在你已经学会了基础，可以：

1. **查看项目代码** - 学习更多实例
2. **阅读 GETX_GUIDE.md** - 深入理解高级特性
3. **构建自己的应用** - 实践所学知识
4. **查看官方文档** - https://github.com/jonataslaw/getx

---

## 速查表

### 常用代码片段

```dart
// 创建响应式变量
final variable = value.obs;

// 获取值
variable.value

// 在 UI 中响应
Obx(() => Widget())

// 注入控制器
Get.put(Controller())

// 获取控制器
Get.find<Controller>()

// 导航
Get.to(() => Page())

// 返回
Get.back()

// 监听变化
ever(variable, (value) {})

// 防抖
debounce(variable, callback, time: Duration(...))

// 节流
throttle(variable, callback, time: Duration(...))

// 显示提示
Get.snackbar('标题', '消息')

// 显示对话框
Get.dialog(AlertDialog(...))

// 显示底部菜单
Get.bottomSheet(Widget())
```

祝你学习愉快！🚀
