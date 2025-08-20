// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:meals_app/core/routes/app_routes.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await EasyLocalization.ensureInitialized();
//   runApp(
//     EasyLocalization(
//       supportedLocales: [Locale('en'), Locale('ar')],
//       path: 'assets/translate',
//       saveLocale: true,
//       fallbackLocale: Locale('en'),
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: const Size(375, 812),
//       minTextAdapt: true,
//       splitScreenMode: true,
//       builder: (_, child) {
//         return MaterialApp(
//           title: 'Meal App',
//           localizationsDelegates: context.localizationDelegates,
//           supportedLocales: context.supportedLocales,
//           locale: context.locale,
//           debugShowCheckedModeBanner: false,
//           routes: routes,
//           initialRoute: "/",
//         );
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(SignLanguageApp());
}

class SignLanguageApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Bridge',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0xFF2196F3),
        // accentColor: Color(0xFF4CAF50),
        fontFamily: 'Roboto',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
  bool _isRecording = false;
  bool _isTranslating = false;
  String _translatedText = "";
  AnimationController? _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _pulseController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text(
          'Sign Bridge',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF2196F3),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () => _showSettingsDialog(context),
          ),
          IconButton(
            icon: Icon(Icons.help_outline, color: Colors.white),
            onPressed: () => _showHelpDialog(context),
          ),
        ],
      ),
      body: _buildCurrentPage(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildCurrentPage() {
    switch (_currentIndex) {
      case 0:
        return _buildTranslationPage();
      case 1:
        return _buildCameraPage();
      case 2:
        return _buildHistoryPage();
      case 3:
        return _buildLearningPage();
      default:
        return _buildTranslationPage();
    }
  }

  Widget _buildTranslationPage() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          _buildWelcomeCard(),
          SizedBox(height: 20),
          _buildTranslationCard(),
          SizedBox(height: 20),
          _buildQuickActionsGrid(),
          SizedBox(height: 20),
          _buildRecentTranslationsCard(),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2196F3), Color(0xFF21CBF3)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF2196F3).withOpacity(0.3),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.accessibility_new, color: Colors.white, size: 32),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'مرحباً بك في Sign Bridge',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'ابدأ التواصل بسهولة من خلال ترجمة لغة الإشارة والصوت',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTranslationCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'الترجمة الفورية',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildTranslationButton(
                  icon: Icons.mic,
                  title: 'صوت إلى إشارة',
                  subtitle: 'اضغط للتسجيل',
                  color: Color(0xFF4CAF50),
                  onTap: _startVoiceRecording,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildTranslationButton(
                  icon: Icons.videocam,
                  title: 'إشارة إلى صوت',
                  subtitle: 'ابدأ الكاميرا',
                  color: Color(0xFFFF9800),
                  onTap: _startSignDetection,
                ),
              ),
            ],
          ),
          if (_translatedText.isNotEmpty) ...[
            SizedBox(height: 20),
            _buildTranslationResult(),
          ],
        ],
      ),
    );
  }

  Widget _buildTranslationButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            AnimatedBuilder(
              animation: _pulseController!,
              builder: (context, child) {
                return Transform.scale(
                  scale: _isRecording && icon == Icons.mic
                      ? 1.0 + (_pulseController!.value * 0.1)
                      : 1.0,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Color(0xFF333333),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTranslationResult() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFE0E0E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.translate, color: Color(0xFF2196F3), size: 20),
              SizedBox(width: 8),
              Text(
                'النتيجة:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.copy, size: 20),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: _translatedText));
                  _showSnackBar('تم نسخ النص');
                },
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            _translatedText,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF333333),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsGrid() {
    final actions = [
      {
        'icon': Icons.bookmark,
        'title': 'المحفوظات',
        'color': Color(0xFF9C27B0),
      },
      {
        'icon': Icons.school,
        'title': 'تعلم الإشارات',
        'color': Color(0xFF3F51B5),
      },
      {
        'icon': Icons.text_fields,
        'title': 'النص إلى إشارة',
        'color': Color(0xFFE91E63),
      },
      {
        'icon': Icons.emergency,
        'title': 'الطوارئ',
        'color': Color(0xFFF44336),
      },
    ];

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'إجراءات سريعة',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.5,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: actions.length,
            itemBuilder: (context, index) {
              final action = actions[index];
              return _buildQuickActionItem(
                icon: action['icon'] as IconData,
                title: action['title'] as String,
                color: action['color'] as Color,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionItem({
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () => _showSnackBar('ميزة $title قيد التطوير'),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Color(0xFF333333),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentTranslationsCard() {
    final recentTranslations = [
      {'text': 'مرحباً كيف حالك؟', 'time': '10:30 صباحاً', 'type': 'voice'},
      {'text': 'أحتاج مساعدة من فضلك', 'time': '09:15 صباحاً', 'type': 'sign'},
      {'text': 'شكراً جزيلاً', 'time': 'أمس', 'type': 'voice'},
    ];

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'الترجمات الأخيرة',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              Spacer(),
              TextButton(
                onPressed: () => setState(() => _currentIndex = 2),
                child: Text('عرض الكل'),
              ),
            ],
          ),
          SizedBox(height: 12),
          ...recentTranslations.map((translation) => _buildRecentTranslationItem(
                text: translation['text']!,
                time: translation['time']!,
                isVoice: translation['type'] == 'voice',
              )),
        ],
      ),
    );
  }

  Widget _buildRecentTranslationItem({
    required String text,
    required String time,
    required bool isVoice,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isVoice ? Color(0xFF4CAF50) : Color(0xFFFF9800),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isVoice ? Icons.mic : Icons.videocam,
              color: Colors.white,
              size: 18,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF333333),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
        ],
      ),
    );
  }

  Widget _buildCameraPage() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.videocam, size: 80, color: Colors.white54),
                  SizedBox(height: 20),
                  Text(
                    'كاميرا لغة الإشارة',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'ضع يديك أمام الكاميرا لترجمة الإشارات',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCameraButton(
                icon: Icons.flip_camera_ios,
                label: 'قلب الكاميرا',
                onTap: () => _showSnackBar('تم قلب الكاميرا'),
              ),
              _buildCameraButton(
                icon: _isTranslating ? Icons.stop : Icons.play_arrow,
                label: _isTranslating ? 'إيقاف' : 'ابدأ',
                onTap: _toggleTranslation,
                isPrimary: true,
              ),
              _buildCameraButton(
                icon: Icons.flash_on,
                label: 'الفلاش',
                onTap: () => _showSnackBar('تم تشغيل الفلاش'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCameraButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isPrimary = false,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: isPrimary ? Color(0xFF2196F3) : Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: isPrimary ? Colors.white : Color(0xFF2196F3),
              size: 28,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF666666),
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryPage() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'سجل الترجمات',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => _buildHistoryItem(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(int index) {
    final isVoice = index % 2 == 0;
    final translations = [
      'مرحباً كيف حالك؟',
      'أحتاج مساعدة من فضلك',
      'شكراً جزيلاً',
      'أين المستشفى؟',
      'كم الساعة الآن؟',
    ];
    
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isVoice ? Color(0xFF4CAF50) : Color(0xFFFF9800),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isVoice ? Icons.mic : Icons.videocam,
              color: Colors.white,
              size: 24,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  translations[index % translations.length],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF333333),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'منذ ${index + 1} ساعة',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.share, color: Colors.grey[600]),
            onPressed: () => _showSnackBar('تم مشاركة الترجمة'),
          ),
        ],
      ),
    );
  }

  Widget _buildLearningPage() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'تعلم لغة الإشارة',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1.2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildLearningCard('الأبجدية', Icons.abc, Color(0xFF4CAF50)),
                _buildLearningCard('الأرقام', Icons.looks_one, Color(0xFF2196F3)),
                _buildLearningCard('التحيات', Icons.waving_hand, Color(0xFFFF9800)),
                _buildLearningCard('الطوارئ', Icons.emergency, Color(0xFFF44336)),
                _buildLearningCard('الطعام', Icons.restaurant, Color(0xFF9C27B0)),
                _buildLearningCard('العائلة', Icons.family_restroom, Color(0xFF607D8B)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLearningCard(String title, IconData icon, Color color) {
    return GestureDetector(
      onTap: () => _showSnackBar('درس $title قيد التطوير'),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 30, color: color),
            ),
            SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF2196F3),
        unselectedItemColor: Colors.grey[600],
        backgroundColor: Colors.white,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videocam),
            label: 'الكاميرا',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'السجل',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'تعلم',
          ),
        ],
      ),
    );
  }

  void _startVoiceRecording() {
    setState(() {
      _isRecording = !_isRecording;
      if (_isRecording) {
        _pulseController!.repeat(reverse: true);
        _translatedText = "";
      } else {
        _pulseController!.stop();
        _translatedText = "مرحباً، كيف يمكنني مساعدتك؟";
      }
    });
    
    HapticFeedback.mediumImpact();
    _showSnackBar(_isRecording ? 'بدأ التسجيل...' : 'انتهى التسجيل');
  }

  void _startSignDetection() {
    setState(() => _currentIndex = 1);
    _showSnackBar('انتقل إلى صفحة الكاميرا');
  }

  void _toggleTranslation() {
    setState(() => _isTranslating = !_isTranslating);
    _showSnackBar(_isTranslating ? 'بدأت الترجمة' : 'توقفت الترجمة');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Color(0xFF2196F3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('الإعدادات'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.language),
              title: Text('اللغة'),
              subtitle: Text('العربية'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.volume_up),
              title: Text('الصوت'),
              subtitle: Text('مرتفع'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('الإشعارات'),
              subtitle: Text('مفعلة'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('حسناً'),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('المساعدة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('كيفية استخدام التطبيق:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('• اضغط على زر الميكروفون لتسجيل صوتك'),
            SizedBox(height: 5),
            Text('• استخدم الكاميرا لترجمة لغة الإشارة'),
            SizedBox(height: 5),
            Text('• راجع السجل لمشاهدة الترجمات السابقة'),
            SizedBox(height: 5),
            Text('• تعلم لغة الإشارة من خلال الدروس التفاعلية'),
            SizedBox(height: 5),
            Text('• استخدم الإعدادات لتخصيص التطبيق'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('فهمت'),
          ),
        ],
      ),
    );
  }
}