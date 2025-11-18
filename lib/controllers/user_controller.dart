import 'package:get/get.dart';

/// 用户控制器 - 展示依赖注入和全局状态管理
/// 
/// 这个控制器展示了如何：
/// 1. 创建全局可访问的单例控制器
/// 2. 在应用全局使用状态
/// 3. 使用 Get.find() 获取已注入的控制器
class UserController extends GetxController {
  /// 用户信息
  final Rx<User?> user = Rx<User?>(null);
  
  /// 是否已登录
  final RxBool isLoggedIn = false.obs;
  
  /// 是否正在加载
  final RxBool isLoading = false.obs;
  
  /// 错误信息
  final RxString errorMessage = ''.obs;
  
  /// 用户列表
  final RxList<User> users = <User>[].obs;

  @override
  void onInit() {
    super.onInit();
    print('[UserController] 初始化完成 - 这是一个全局单例');
    
    // 加载初始用户数据
    _loadUsers();
  }

  /// 登录
  Future<void> login(String email, String password) async {
    isLoading.value = true;
    errorMessage.value = '';
    
    try {
      // 模拟 API 调用
      await Future.delayed(const Duration(seconds: 1));
      
      // 创建用户对象
      user.value = User(
        id: 1,
        name: '张三',
        email: email,
        avatar: 'https://via.placeholder.com/150',
      );
      
      isLoggedIn.value = true;
    } catch (e) {
      errorMessage.value = '登录失败: $e';
    } finally {
      isLoading.value = false;
    }
  }

  /// 登出
  void logout() {
    user.value = null;
    isLoggedIn.value = false;
    errorMessage.value = '';
  }

  /// 更新用户信息
  void updateUser(String newName) {
    if (user.value != null) {
      user.update((val) {
        if (val != null) {
          val.name = newName;
        }
      });
    }
  }

  /// 加载用户列表
  void _loadUsers() {
    users.assignAll([
      User(id: 1, name: '张三', email: 'zhang@example.com'),
      User(id: 2, name: '李四', email: 'li@example.com'),
      User(id: 3, name: '王五', email: 'wang@example.com'),
    ]);
  }

  /// 获取用户名
  String get userName => user.value?.name ?? '未登录';
  
  /// 获取用户邮箱
  String get userEmail => user.value?.email ?? '';
}

/// 用户模型
class User {
  final int id;
  String name;
  final String email;
  final String? avatar;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
  });

  @override
  String toString() => 'User(id: $id, name: $name, email: $email)';
}
