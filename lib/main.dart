import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_getx_learning/routes/app_routes.dart';
import 'package:flutter_getx_learning/routes/app_pages.dart';
import 'package:flutter_getx_learning/translations/app_translations.dart';

void main() {
  runApp(const MyApp());
}

/// GetX 学习应用主入口
/// 
/// 这个应用展示了 GetX 框架的各种功能：
/// 1. 路由管理 (GetX Navigation)
/// 2. 状态管理 (GetxController)
/// 3. 响应式编程 (Rx 类型)
/// 4. 依赖注入 (Get.put, Get.lazyPut)
/// 5. 国际化支持 (GetX Translations)
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // 应用标题
      title: 'Flutter GetX 学习',
      
      // 调试横幅关闭
      debugShowCheckedModeBanner: false,
      
      // 主题配置
      theme: ThemeData(
        // 主色调
        primarySwatch: Colors.blue,
        // 使用 Material 3 设计
        useMaterial3: true,
        // 应用栏样式
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.blue,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      
      // 暗黑主题
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
      ),
      
      // 路由配置
      // initialRoute: AppRoutes.HOME, // 初始路由
      home: const HomePage(),
      
      // GetX 路由配置 (可选)
      // getPages: AppPages.pages,
      
      // 国际化配置
      translations: AppTranslations(),
      locale: const Locale('zh', 'CN'), // 默认语言
      fallbackLocale: const Locale('zh', 'CN'), // 备用语言
      
      // 全局滚动行为
      scrollBehavior: const ScrollBehavior(),
    );
  }
}

/// 主页面
/// 
/// 这是应用的主入口页面，展示了 GetX 学习的各个主题
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter GetX 学习'),
        centerTitle: true,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 标题
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'GetX 核心功能演示',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              
              // 学习项目列表
              _buildMenuCard(
                context,
                '1. 基础状态管理',
                '学习简单的响应式变量和控制器',
                Colors.blue,
                () => Get.to(() => const StateManagementPage()),
              ),
              
              _buildMenuCard(
                context,
                '2. 计数器示例',
                '通过计数器学习 GetxController 的基本用法',
                Colors.green,
                () => Get.to(() => const CounterPage()),
              ),
              
              _buildMenuCard(
                context,
                '3. 响应式编程',
                '学习 Rx 类型: RxInt, RxString, RxList, RxMap 等',
                Colors.orange,
                () => Get.to(() => const ReactivePage()),
              ),
              
              _buildMenuCard(
                context,
                '4. 工作者 (Workers)',
                '使用 ever, once, debounce, throttle 监听变量变化',
                Colors.purple,
                () => Get.to(() => const WorkersPage()),
              ),
              
              _buildMenuCard(
                context,
                '5. 依赖注入',
                '学习 Get.put, Get.lazyPut 等依赖注入方法',
                Colors.pink,
                () => Get.to(() => const DependencyInjectionPage()),
              ),
              
              _buildMenuCard(
                context,
                '6. 页面生命周期',
                '了解 GetxController 的生命周期回调',
                Colors.teal,
                () => Get.to(() => const LifecyclePage()),
              ),
              
              _buildMenuCard(
                context,
                '7. 路由和参数传递',
                '学习 GetX 的声明式路由和参数传递',
                Colors.indigo,
                () => Get.to(() => const RoutingPage()),
              ),
              
              _buildMenuCard(
                context,
                '8. GetBuilder 和 Obx',
                '比较两种 UI 更新方式的差异',
                Colors.cyan,
                () => Get.to(() => const UIUpdatePage()),
              ),
              
              _buildMenuCard(
                context,
                '9. 本地存储',
                '使用 GetStorage 实现本地数据持久化',
                Colors.amber,
                () => Get.to(() => const StoragePage()),
              ),
              
              _buildMenuCard(
                context,
                '10. 对话框和通知',
                '使用 Get.dialog, Get.snackbar, Get.bottomSheet 等',
                Colors.red,
                () => Get.to(() => const DialogPage()),
              ),
              
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  /// 构建菜单卡片
  /// 
  /// [title] - 卡片标题
  /// [subtitle] - 卡片副标题
  /// [color] - 卡片颜色
  /// [onTap] - 点击回调
  Widget _buildMenuCard(
    BuildContext context,
    String title,
    String subtitle,
    Color color,
    VoidCallback onTap,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [
                  color.withOpacity(0.8),
                  color.withOpacity(0.6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 占位页面 - 将在其他文件中实现
class StateManagementPage extends StatelessWidget {
  const StateManagementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('基础状态管理')),
      body: const Center(child: Text('敬请期待')),
    );
  }
}

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('计数器示例')),
      body: const Center(child: Text('敬请期待')),
    );
  }
}

class ReactivePage extends StatelessWidget {
  const ReactivePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('响应式编程')),
      body: const Center(child: Text('敬请期待')),
    );
  }
}

class WorkersPage extends StatelessWidget {
  const WorkersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('工作者')),
      body: const Center(child: Text('敬请期待')),
    );
  }
}

class DependencyInjectionPage extends StatelessWidget {
  const DependencyInjectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('依赖注入')),
      body: const Center(child: Text('敬请期待')),
    );
  }
}

class LifecyclePage extends StatelessWidget {
  const LifecyclePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('页面生命周期')),
      body: const Center(child: Text('敬请期待')),
    );
  }
}

class RoutingPage extends StatelessWidget {
  const RoutingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('路由和参数')),
      body: const Center(child: Text('敬请期待')),
    );
  }
}

class UIUpdatePage extends StatelessWidget {
  const UIUpdatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('UI 更新方式')),
      body: const Center(child: Text('敬请期待')),
    );
  }
}

class StoragePage extends StatelessWidget {
  const StoragePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('本地存储')),
      body: const Center(child: Text('敬请期待')),
    );
  }
}

class DialogPage extends StatelessWidget {
  const DialogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('对话框和通知')),
      body: const Center(child: Text('敬请期待')),
    );
  }
}
