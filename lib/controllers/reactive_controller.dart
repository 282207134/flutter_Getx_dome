import 'package:get/get.dart';

/// 响应式编程控制器
/// 
/// 这个控制器展示了 GetX 中的各种响应式类型：
/// - RxInt / RxDouble / RxString / RxBool - 基础类型
/// - RxList - 列表
/// - RxMap - 字典
/// - Rx<T> - 泛型包装
/// 
/// 这些类型都继承自 Rx 类，支持响应式编程
class ReactiveController extends GetxController {
  // ==================== 基础响应式类型 ====================
  
  /// RxInt - 响应式整数
  final RxInt age = 25.obs;
  
  /// RxDouble - 响应式浮点数
  final RxDouble price = 99.99.obs;
  
  /// RxString - 响应式字符串
  final RxString name = '张三'.obs;
  
  /// RxBool - 响应式布尔值
  final RxBool isSubscribed = false.obs;

  // ==================== 集合响应式类型 ====================
  
  /// RxList - 响应式列表
  /// 
  /// 当列表元素变化时，所有监听者都会收到通知
  /// 支持 add(), remove(), clear() 等操作
  final RxList<String> hobbies = <String>[
    '阅读',
    '编程',
    '运动',
  ].obs;
  
  /// RxMap - 响应式字典
  /// 
  /// 用于存储键值对数据，支持响应式更新
  final RxMap<String, dynamic> userInfo = {
    '性别': '男',
    '城市': '北京',
    '职业': '工程师',
  }.obs;

  // ==================== 复杂对象响应式 ====================
  
  /// 使用 Rx<T> 包装自定义对象
  /// 
  /// 这允许你对任何类型的对象进行响应式管理
  final Rx<UserProfile> userProfile = Rx<UserProfile>(
    UserProfile(
      id: 1,
      username: 'flutter_user',
      email: 'user@flutter.com',
    ),
  );

  // ==================== 生命周期 ====================

  @override
  void onInit() {
    super.onInit();
    print('[ReactiveController] 初始化完成');
    
    // 监听 name 变化
    ever(name, (String value) {
      print('[Reactive] 名字已更新: $value');
    });
    
    // 监听 hobbies 列表变化
    ever(hobbies, (List<String> list) {
      print('[Reactive] 爱好列表已更新: $list');
    });
    
    // 监听 userInfo 字典变化
    ever(userInfo, (Map<String, dynamic> map) {
      print('[Reactive] 用户信息已更新: $map');
    });
    
    // 监听自定义对象变化
    ever(userProfile, (UserProfile profile) {
      print('[Reactive] 用户资料已更新: ${profile.username}');
    });
  }

  @override
  void onClose() {
    super.onClose();
    print('[ReactiveController] 控制器已销毁');
  }

  // ==================== 基础类型操作 ====================

  /// 修改年龄
  void updateAge(int newAge) {
    age.value = newAge;
  }

  /// 修改价格
  void updatePrice(double newPrice) {
    price.value = newPrice;
  }

  /// 修改名字
  void updateName(String newName) {
    name.value = newName;
  }

  /// 切换订阅状态
  void toggleSubscription() {
    isSubscribed.value = !isSubscribed.value;
  }

  // ==================== 列表操作 ====================

  /// 添加爱好
  /// 
  /// RxList 支持常规列表操作
  void addHobby(String hobby) {
    if (!hobbies.contains(hobby)) {
      hobbies.add(hobby); // 自动触发响应式更新
    }
  }

  /// 删除爱好
  void removeHobby(String hobby) {
    hobbies.remove(hobby);
  }

  /// 清空爱好列表
  void clearHobbies() {
    hobbies.clear();
  }

  /// 获取爱好数量
  int get hobbyCount => hobbies.length;

  /// 检查是否喜欢某个爱好
  bool hasHobby(String hobby) => hobbies.contains(hobby);

  // ==================== 字典操作 ====================

  /// 更新用户信息
  /// 
  /// 直接修改 RxMap 中的值
  void updateUserInfo(String key, dynamic value) {
    userInfo[key] = value;
  }

  /// 添加新的用户信息
  void addUserInfo(String key, dynamic value) {
    userInfo.addAll({key: value});
  }

  /// 删除用户信息
  void removeUserInfo(String key) {
    userInfo.remove(key);
  }

  /// 获取用户信息
  dynamic getUserInfo(String key) => userInfo[key];

  /// 检查是否有某个信息
  bool hasUserInfo(String key) => userInfo.containsKey(key);

  // ==================== 复杂对象操作 ====================

  /// 更新用户资料
  /// 
  /// 对于复杂对象，需要创建新实例或使用 Rx<T> 的 update 方法
  void updateUserProfile({
    String? username,
    String? email,
  }) {
    final current = userProfile.value;
    userProfile.value = UserProfile(
      id: current.id,
      username: username ?? current.username,
      email: email ?? current.email,
    );
  }

  /// 使用 update 方法更新（推荐方式）
  /// 
  /// update 方法允许更细粒度的控制
  void updateUserProfileWithUpdate(String newUsername) {
    userProfile.update((profile) {
      if (profile != null) {
        profile.username = newUsername;
      }
    });
  }

  // ==================== 计算属性 ====================

  /// 计算：用户简介
  /// 
  /// 结合多个响应式变量形成新的计算值
  String get userSummary => '$name, $age 岁, $price 元';

  /// 计算：爱好字符串
  String get hobbyString => hobbies.join(', ');

  /// 计算：用户信息字符串
  String get userInfoString {
    return userInfo.entries
        .map((e) => '${e.key}: ${e.value}')
        .join('\n');
  }

  /// 检查数据是否完整
  bool get isProfileComplete {
    return name.isNotEmpty && age.value > 0;
  }
}

/// 用户资料模型
/// 
/// 用于展示如何使用 Rx<T> 包装自定义对象
class UserProfile {
  final int id;
  String username;
  String email;

  UserProfile({
    required this.id,
    required this.username,
    required this.email,
  });

  @override
  String toString() => 'UserProfile(id: $id, username: $username, email: $email)';
}
