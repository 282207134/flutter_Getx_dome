import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_getx_learning/controllers/counter_controller.dart';
import 'package:flutter_getx_learning/controllers/lifecycle_controller.dart';
import 'package:flutter_getx_learning/controllers/reactive_controller.dart';
import 'package:flutter_getx_learning/controllers/user_controller.dart';
import 'package:flutter_getx_learning/controllers/workers_controller.dart';
import 'package:flutter_getx_learning/translations/app_translations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put<UserController>(UserController(), permanent: true);
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
                () => Get.to(() => StateManagementPage()),
              ),

              _buildMenuCard(
                context,
                '2. 计数器示例',
                '通过计数器学习 GetxController 的基本用法',
                Colors.green,
                () => Get.to(() => CounterPage()),
              ),

              _buildMenuCard(
                context,
                '3. 响应式编程',
                '学习 Rx 类型: RxInt, RxString, RxList, RxMap 等',
                Colors.orange,
                () => Get.to(() => ReactivePage()),
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

class StateManagementPage extends StatelessWidget {
  StateManagementPage({Key? key}) : super(key: key);

  final SimpleCounterController _controller =
      Get.put(SimpleCounterController(), tag: 'state_management');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('基础状态管理')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            '通过最小的控制器体验 GetX 的响应式能力。下面的示例展示了 '
            '计数变化如何实时刷新 UI，并附带常用的状态操作按钮。',
          ),
          const SizedBox(height: 16),
          Obx(
            () => _buildInfoCard(
              title: '当前计数',
              subtitle: '来自 RxInt 的实时值',
              value: _controller.count.value.toString(),
              icon: Icons.numbers,
            ),
          ),
          Obx(
            () => _buildInfoCard(
              title: '是否为偶数',
              subtitle: '依据计数实时判断',
              value: _controller.count.value % 2 == 0 ? '是' : '否',
              icon: Icons.swap_horiz,
              color: _controller.count.value % 2 == 0
                  ? Colors.teal
                  : Colors.orange,
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              ElevatedButton.icon(
                onPressed: _controller.increment,
                icon: const Icon(Icons.add),
                label: const Text('增加'),
              ),
              ElevatedButton.icon(
                onPressed: _controller.decrement,
                icon: const Icon(Icons.remove),
                label: const Text('减少'),
              ),
              OutlinedButton.icon(
                onPressed: _controller.reset,
                icon: const Icon(Icons.restart_alt),
                label: const Text('重置'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildTipsCard(),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String subtitle,
    required String value,
    IconData icon = Icons.info,
    Color color = Colors.blue,
  }) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.15),
          child: Icon(icon, color: color),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildTipsCard() {
    return Card(
      elevation: 0,
      color: Colors.blueGrey.withOpacity(0.08),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '为什么选 Rx?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('• 通过 .obs 将任意数据变为可监听的响应式对象。'),
            Text('• 使用 Obx 或 GetX 小部件自动监听变化。'),
            Text('• 控制器逻辑与 UI 解耦，便于复用和测试。'),
          ],
        ),
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  CounterPage({Key? key}) : super(key: key);

  final CounterController _controller =
      Get.put(CounterController(), tag: 'counter_page');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('计数器示例')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Obx(
            () => _buildCounterHeader(
              context,
              value: _controller.count.value,
              doubleValue: _controller.doubleCount,
              clicks: _controller.clickCount.value,
            ),
          ),
          const SizedBox(height: 16),
          Obx(
            () => _buildStatusTile(
              title: '当前状态',
              description: _controller.statusText,
              icon: Icons.analytics,
            ),
          ),
          Obx(
            () => Visibility(
              visible: _controller.message.value.isNotEmpty,
              child: _buildStatusTile(
                title: '提示',
                description: _controller.message.value,
                icon: Icons.celebration,
                color: Colors.green,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Obx(
            () => _controller.isLoading.value
                ? const LinearProgressIndicator()
                : const SizedBox.shrink(),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              ElevatedButton.icon(
                onPressed: _controller.increment,
                icon: const Icon(Icons.add),
                label: const Text('增加'),
              ),
              ElevatedButton.icon(
                onPressed: _controller.decrement,
                icon: const Icon(Icons.remove),
                label: const Text('减少'),
              ),
              ElevatedButton.icon(
                onPressed: () => _controller.fetchData(),
                icon: const Icon(Icons.cloud_download),
                label: const Text('模拟网络 +10'),
              ),
              OutlinedButton.icon(
                onPressed: _controller.reset,
                icon: const Icon(Icons.refresh),
                label: const Text('重置'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCounterHeader(
    BuildContext context, {
    required int value,
    required int doubleValue,
    required int clicks,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '计数器：$value',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 4),
            Text('点击次数：$clicks'),
            const SizedBox(height: 8),
            Chip(
              avatar: const Icon(Icons.auto_awesome, size: 18),
              label: Text('双倍值：$doubleValue'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusTile({
    required String title,
    required String description,
    IconData icon = Icons.info,
    Color color = Colors.blueGrey,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title),
        subtitle: Text(description),
      ),
    );
  }
}

class ReactivePage extends StatelessWidget {
  ReactivePage({Key? key}) : super(key: key);

  final ReactiveController _controller =
      Get.put(ReactiveController(), tag: 'reactive_page');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('响应式编程示例')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle('基础类型'),
          Obx(
            () => Card(
              child: ListTile(
                title: Text(
                    '${_controller.name.value}，${_controller.age.value} 岁'),
                subtitle: Text(
                  '价格：${_controller.price.value.toStringAsFixed(2)}  | '
                  '订阅：${_controller.isSubscribed.value ? '已开启' : '未开启'}',
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.swap_calls),
                  onPressed: () {
                    final newAge = _controller.age.value + 1;
                    _controller.updateAge(newAge);
                    _controller.toggleSubscription();
                  },
                ),
              ),
            ),
          ),
          Wrap(
            spacing: 12,
            children: [
              OutlinedButton(
                onPressed: () => _controller.updateName('GetX 爱好者'),
                child: const Text('改名'),
              ),
              OutlinedButton(
                onPressed: () => _controller.updatePrice(
                  (_controller.price.value + 10).clamp(0, 999).toDouble(),
                ),
                child: const Text('价格 +10'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSectionTitle('响应式列表'),
          Obx(
            () => Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      children: _controller.hobbies
                          .map(
                            (hobby) => Chip(
                              label: Text(hobby),
                              onDeleted: () => _controller.removeHobby(hobby),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        onPressed: () => _showTextDialog(
                          title: '添加爱好',
                          hintText: '例如：旅行',
                          onSubmit: _controller.addHobby,
                        ),
                        icon: const Icon(Icons.add),
                        label: const Text('添加爱好'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildSectionTitle('响应式字典'),
          Obx(
            () => Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ..._controller.userInfo.entries.map(
                      (entry) => ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: Text(entry.key),
                        subtitle: Text(entry.value.toString()),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _showTextDialog(
                            title: '修改 ${entry.key}',
                            hintText: entry.value.toString(),
                            onSubmit: (value) =>
                                _controller.updateUserInfo(entry.key, value),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        onPressed: () => _showKeyValueDialog(),
                        icon: const Icon(Icons.add),
                        label: const Text('添加字段'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildSectionTitle('自定义对象'),
          Obx(
            () {
              final profile = _controller.userProfile.value;
              return Card(
                child: ListTile(
                  title: Text(profile.username),
                  subtitle: Text(profile.email),
                  leading: const Icon(Icons.person),
                  trailing: IconButton(
                    icon: const Icon(Icons.upgrade),
                    onPressed: () => _controller.updateUserProfile(
                      username: '${profile.username}_new',
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _showTextDialog({
    required String title,
    required ValueChanged<String> onSubmit,
    String hintText = '',
  }) {
    final textController = TextEditingController(text: hintText);
    Get.dialog(
      AlertDialog(
        title: Text(title),
        content: TextField(
          controller: textController,
          decoration: InputDecoration(hintText: hintText),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () {
              textController.dispose();
              Get.back();
            },
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              final value = textController.text.trim();
              if (value.isNotEmpty) {
                onSubmit(value);
              }
              textController.dispose();
              Get.back();
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  void _showKeyValueDialog() {
    final keyController = TextEditingController();
    final valueController = TextEditingController();
    Get.dialog(
      AlertDialog(
        title: const Text('添加字段'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: keyController,
              decoration: const InputDecoration(labelText: '键 (Key)'),
            ),
            TextField(
              controller: valueController,
              decoration: const InputDecoration(labelText: '值 (Value)'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              keyController.dispose();
              valueController.dispose();
              Get.back();
            },
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              final key = keyController.text.trim();
              final value = valueController.text.trim();
              if (key.isNotEmpty) {
                _controller.addUserInfo(key, value);
              }
              keyController.dispose();
              valueController.dispose();
              Get.back();
            },
            child: const Text('添加'),
          ),
        ],
      ),
    );
  }
}

class WorkersPage extends StatefulWidget {
  const WorkersPage({Key? key}) : super(key: key);

  @override
  State<WorkersPage> createState() => _WorkersPageState();
}

class _WorkersPageState extends State<WorkersPage> {
  late final WorkersController _controller;
  late final TextEditingController _searchController;
  late final TextEditingController _inputController;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(WorkersController(), tag: 'workers_page');
    _searchController = TextEditingController();
    _inputController = TextEditingController();
  }

  @override
  void dispose() {
    Get.delete<WorkersController>(tag: 'workers_page');
    _searchController.dispose();
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Workers 监听示例')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              labelText: '搜索关键字 (debounce)',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: _controller.updateSearchQuery,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _inputController,
            decoration: const InputDecoration(
              labelText: '用户输入 (throttle)',
              prefixIcon: Icon(Icons.speed),
            ),
            onChanged: _controller.updateUserInput,
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildCounterButton(
                    title: '计数',
                    onAdd: _controller.increment,
                    onMinus: _controller.decrement,
                  ),
                  _buildCounterButton(
                    title: '按钮点击',
                    onAdd: _controller.onButtonClick,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Obx(
            () => Card(
              child: Column(
                children: [
                  ListTile(
                    title: const Text('搜索结果 (debounce 执行后更新)'),
                    subtitle: Text(
                      _controller.hasSearchResults
                          ? '共 ${_controller.searchResultCount} 条'
                          : '暂无结果',
                    ),
                  ),
                  if (_controller.hasSearchResults)
                    ..._controller.searchResults.map(
                      (item) => ListTile(
                        leading: const Icon(Icons.bookmark),
                        title: Text(item),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Obx(
            () => Card(
              child: ExpansionTile(
                title: Text('日志记录 (${_controller.logCount})'),
                children: _controller.logs.isEmpty
                    ? const [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Text('暂无日志，开始尝试输入吧！'),
                        ),
                      ]
                    : _controller.logs
                        .map(
                          (log) => ListTile(
                            dense: true,
                            title: Text(log),
                          ),
                        )
                        .toList(),
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextButton.icon(
            onPressed: _controller.reset,
            icon: const Icon(Icons.delete_sweep),
            label: const Text('清空所有状态'),
          ),
        ],
      ),
    );
  }

  Widget _buildCounterButton({
    required String title,
    VoidCallback? onAdd,
    VoidCallback? onMinus,
  }) {
    return Column(
      children: [
        Text(title),
        const SizedBox(height: 8),
        Row(
          children: [
            IconButton(
              onPressed: onAdd,
              icon: const Icon(Icons.add_circle),
            ),
            if (onMinus != null)
              IconButton(
                onPressed: onMinus,
                icon: const Icon(Icons.remove_circle),
              ),
          ],
        ),
      ],
    );
  }
}

class DependencyInjectionPage extends StatefulWidget {
  const DependencyInjectionPage({Key? key}) : super(key: key);

  @override
  State<DependencyInjectionPage> createState() =>
      _DependencyInjectionPageState();
}

class _DependencyInjectionPageState extends State<DependencyInjectionPage> {
  late final UserController _userController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _userController = Get.find<UserController>();
    _emailController = TextEditingController(text: 'demo@getx.dev');
    _passwordController = TextEditingController(text: '123456');
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('依赖注入 & 全局状态')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'UserController 在 main() 中通过 Get.put(...) 提前注入，因此本页 '
            '直接使用 Get.find() 取得全局实例，实现真正的全局状态共享。',
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('模拟登录', style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: '邮箱'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: '密码'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 12),
                  Obx(
                    () => _userController.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : Row(
                            children: [
                              ElevatedButton(
                                onPressed: () => _userController.login(
                                  _emailController.text.trim(),
                                  _passwordController.text.trim(),
                                ),
                                child: const Text('登录'),
                              ),
                              const SizedBox(width: 12),
                              TextButton(
                                onPressed: _userController.logout,
                                child: const Text('登出'),
                              ),
                            ],
                          ),
                  ),
                  const SizedBox(height: 12),
                  Obx(
                    () => Text(
                      _userController.isLoggedIn.value
                          ? '当前用户：${_userController.userName}'
                          : '尚未登录',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Obx(
                    () => Visibility(
                      visible: _userController.errorMessage.value.isNotEmpty,
                      child: Text(
                        _userController.errorMessage.value,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('在线修改全局用户信息'),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: '新的昵称',
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      if (_nameController.text.trim().isEmpty) return;
                      _userController.updateUser(_nameController.text.trim());
                      _nameController.clear();
                    },
                    child: const Text('更新昵称'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Obx(
            () => Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ListTile(
                    title: Text('预加载的用户列表'),
                    subtitle: Text('来自 UserController._loadUsers'),
                  ),
                  ..._userController.users.map(
                    (user) => ListTile(
                      leading: CircleAvatar(child: Text(user.name[0])),
                      title: Text(user.name),
                      subtitle: Text(user.email),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LifecyclePage extends StatefulWidget {
  const LifecyclePage({Key? key}) : super(key: key);

  @override
  State<LifecyclePage> createState() => _LifecyclePageState();
}

class _LifecyclePageState extends State<LifecyclePage> {
  late final LifecycleController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(LifecycleController(), tag: 'lifecycle_page');
  }

  @override
  void dispose() {
    Get.delete<LifecycleController>(tag: 'lifecycle_page');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('生命周期跟踪')),
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: ListTile(
                title: const Text('初始化完成'),
                trailing: Icon(
                  _controller.isInitialized.value
                      ? Icons.check_circle
                      : Icons.hourglass_empty,
                  color: _controller.isInitialized.value
                      ? Colors.green
                      : Colors.grey,
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('页面已准备'),
                subtitle: Text('运行时间：${_controller.runtimeText}'),
                trailing: Icon(
                  _controller.isReady.value
                      ? Icons.play_circle
                      : Icons.hourglass_empty,
                  color: _controller.isReady.value ? Colors.blue : Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ExpansionTile(
                initiallyExpanded: true,
                title: const Text('生命周期日志'),
                children: _controller.logs.isEmpty
                    ? const [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Text('日志正在准备中...'),
                        ),
                      ]
                    : _controller.logs
                        .map(
                          (log) => ListTile(
                            dense: true,
                            title: Text(log),
                          ),
                        )
                        .toList(),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: _controller.clearLogs,
              child: const Text('清空日志'),
            ),
          ],
        ),
      ),
    );
  }
}

class RoutingPage extends StatelessWidget {
  const RoutingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final demos = [
      RouteExample(
        title: '跳转并传递参数',
        description: '使用 Get.to + arguments 传递 Map 数据',
        arguments: {
          'title': '来自首页的问候',
          'count': 1,
        },
      ),
      RouteExample(
        title: '等待返回值',
        description: '在详情页调用 Get.back(result: ...)',
        arguments: {
          'title': '返回值示例',
          'count': 2,
          'needResult': true,
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('路由与参数演示')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: demos.length,
        itemBuilder: (_, index) {
          final item = demos[index];
          return Card(
            child: ListTile(
              title: Text(item.title),
              subtitle: Text(item.description),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                final result = await Get.to(
                  () => const RoutingDetailPage(),
                  arguments: item.arguments,
                );
                if (result != null) {
                  Get.snackbar(
                    '收到返回值',
                    result.toString(),
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class RouteExample {
  final String title;
  final String description;
  final Map<String, dynamic> arguments;

  RouteExample({
    required this.title,
    required this.description,
    required this.arguments,
  });
}

class RoutingDetailPage extends StatelessWidget {
  const RoutingDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data = Get.arguments ?? {};
    final title = data['title'] ?? '详情页';
    final count = data['count'] ?? 0;
    final needResult = data['needResult'] == true;

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('收到的参数：$data'),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Get.snackbar('导航成功', '当前计数：$count');
              },
              child: const Text('显示 Snackbar'),
            ),
            const SizedBox(height: 12),
            if (needResult)
              ElevatedButton(
                onPressed: () => Get.back(result: '返回自详情页的问候'),
                child: const Text('返回结果给上一个页面'),
              ),
          ],
        ),
      ),
    );
  }
}

class UIUpdateController extends GetxController {
  int builderCount = 0;
  final RxInt obxCount = 0.obs;

  void increaseBuilder() {
    builderCount++;
    update(['builder-counter']);
  }

  void increaseObx() {
    obxCount.value++;
  }

  void reset() {
    builderCount = 0;
    obxCount.value = 0;
    update(['builder-counter']);
  }
}

class UIUpdatePage extends StatefulWidget {
  const UIUpdatePage({Key? key}) : super(key: key);

  @override
  State<UIUpdatePage> createState() => _UIUpdatePageState();
}

class _UIUpdatePageState extends State<UIUpdatePage> {
  late final UIUpdateController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(UIUpdateController(), tag: 'ui_update_page');
  }

  @override
  void dispose() {
    Get.delete<UIUpdateController>(tag: 'ui_update_page');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GetBuilder vs Obx')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'GetBuilder',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text('依靠 controller.update() 手动刷新'),
                            const Spacer(),
                            GetBuilder<UIUpdateController>(
                              init: _controller,
                              id: 'builder-counter',
                              builder: (_) => Text(
                                '${_.builderCount}',
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: _controller.increaseBuilder,
                              child: const Text('builderCount++'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Obx',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text('监听 Rx 对象，自动刷新'),
                            const Spacer(),
                            Obx(
                              () => Text(
                                '${_controller.obxCount.value}',
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: _controller.increaseObx,
                              child: const Text('obxCount++'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: _controller.reset,
              icon: const Icon(Icons.refresh),
              label: const Text('同时重置'),
            ),
          ],
        ),
      ),
    );
  }
}

class StoragePage extends StatefulWidget {
  const StoragePage({Key? key}) : super(key: key);

  @override
  State<StoragePage> createState() => _StoragePageState();
}

class _StoragePageState extends State<StoragePage> {
  final GetStorage _storage = GetStorage();
  late final TextEditingController _nameController;
  late final TextEditingController _noteController;

  bool _isDark = false;
  List<String> _notes = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: _storage.read('username'));
    _noteController = TextEditingController();
    _isDark = _storage.read('pref_isDark') ?? false;
    _notes = List<String>.from(_storage.read<List>('notes') ?? []);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GetStorage 本地存储')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('保存用户名'),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: '输入昵称',
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _saveName,
                    child: const Text('保存到本地'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text('偏好：深色模式'),
            value: _isDark,
            onChanged: _toggleTheme,
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('快速备忘录'),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _noteController,
                    decoration: const InputDecoration(
                      hintText: '输入完成后点击添加',
                    ),
                    minLines: 1,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      onPressed: _addNote,
                      icon: const Icon(Icons.add),
                      label: const Text('添加'),
                    ),
                  ),
                  const Divider(),
                  if (_notes.isEmpty)
                    const Text('还没有笔记，赶紧添加一条吧！')
                  else
                    ..._notes.asMap().entries.map(
                          (entry) => ListTile(
                            leading: CircleAvatar(
                              child: Text('${entry.key + 1}'),
                            ),
                            title: Text(entry.value),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _removeNote(entry.key),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _saveName() {
    final value = _nameController.text.trim();
    _storage.write('username', value);
    Get.snackbar('保存成功', '用户名已写入本地存储');
  }

  void _toggleTheme(bool value) {
    setState(() => _isDark = value);
    _storage.write('pref_isDark', value);
  }

  void _addNote() {
    final note = _noteController.text.trim();
    if (note.isEmpty) return;
    setState(() {
      _notes.add(note);
    });
    _storage.write('notes', _notes);
    _noteController.clear();
  }

  void _removeNote(int index) {
    setState(() {
      _notes.removeAt(index);
    });
    _storage.write('notes', _notes);
  }
}

class DialogPage extends StatelessWidget {
  const DialogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('对话框 & 通知示例')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ElevatedButton(
            onPressed: () {
              Get.snackbar(
                'Snackbar',
                '这是一条全局通知',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: const Text('Get.snackbar'),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              Get.defaultDialog(
                title: '默认对话框',
                middleText: '利用 Get.defaultDialog 可以快速展示确认弹框。',
                textCancel: '取消',
                textConfirm: '确定',
                onConfirm: () => Get.back(),
              );
            },
            child: const Text('Get.defaultDialog'),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              Get.bottomSheet(
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'BottomSheet 示例',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text('可以放入任意自定义内容，例如分享菜单。'),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: Get.back,
                        child: const Text('关闭'),
                      ),
                    ],
                  ),
                ),
              );
            },
            child: const Text('Get.bottomSheet'),
          ),
        ],
      ),
    );
  }
}
