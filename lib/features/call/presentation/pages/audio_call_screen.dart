import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neurocare_app/core/constants/app_assets.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/features/call/domain/entities/call_entity.dart';

class AudioCallScreen extends StatefulWidget {
  final CallEntity? call;

  const AudioCallScreen({
    super.key,
    this.call,
  });

  @override
  State<AudioCallScreen> createState() => _AudioCallScreenState();
}

class _AudioCallScreenState extends State<AudioCallScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  bool _isMuted = false;
  bool _isSpeakerOn = false;
  bool _isCallConnected = false;

  Duration _callDuration = Duration.zero;
  late DateTime _callStartTime;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _callStartTime = DateTime.now();

    // Simulate call connection after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isCallConnected = true;
        });
        _startCallTimer();
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _startCallTimer() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted && _isCallConnected) {
        setState(() {
          _callDuration = DateTime.now().difference(_callStartTime);
        });
        return true;
      }
      return false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      body: SafeArea(
        child: Stack(
          children: [
            // Background Gradient
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF1A73E8),
                    Color(0xFF4285F4),
                    Color(0xFF8AB4F8),
                  ],
                ),
              ),
            ),

            // Content
            Column(
              children: [
                // Header
                _buildHeader(),

                // Doctor Avatar and Info
                Expanded(
                  child: _buildDoctorSection(),
                ),

                // Call Controls
                _buildCallControls(),
              ],
            ),

            // Connection Status Overlay
            if (!_isCallConnected) _buildConnectionStatus(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => context.pop(),
          ),
          const Spacer(),
          if (_isCallConnected)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    _formatDuration(_callDuration),
                    style: const TextStyle(
                      fontFamily: 'IBM Plex Sans Arabic',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDoctorSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Doctor Avatar with Pulse Animation
        AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _isCallConnected ? 1.0 : _pulseAnimation.value,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 4,
                  ),
                  image: const DecorationImage(
                    image: AssetImage(AppAssets.doctorImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 32),

        // Doctor Name
        const Text(
          'د. أحمد محمد',
          style: TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 8),

        // Specialty
        Text(
          'أخصائي أعصاب',
          style: TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontSize: 18,
            color: Colors.white.withOpacity(0.8),
          ),
        ),

        const SizedBox(height: 16),

        // Call Type Indicator
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.phone,
                color: Colors.white,
                size: 16,
              ),
              SizedBox(width: 6),
              Text(
                'مكالمة صوتية',
                style: TextStyle(
                  fontFamily: 'IBM Plex Sans Arabic',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildConnectionStatus() {
    return Positioned(
      top: MediaQuery.of(context).size.height / 2 + 100,
      left: 20,
      right: 20,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(24),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
            SizedBox(width: 12),
            Text(
              'جاري الاتصال...',
              style: TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCallControls() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          // Status Text
          Text(
            _isCallConnected ? 'متصل الآن' : 'جاري الاتصال...',
            style: TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
              fontSize: 16,
              color: Colors.white.withOpacity(0.8),
            ),
          ),

          const SizedBox(height: 32),

          // Control Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Mute Button
              _buildControlButton(
                icon: _isMuted ? Icons.mic_off : Icons.mic,
                label: _isMuted ? 'إلغاء كتم' : 'كتم',
                color: _isMuted ? Colors.red : Colors.white,
                onPressed: _toggleMute,
              ),

              // Speaker Button
              _buildControlButton(
                icon: _isSpeakerOn ? Icons.volume_up : Icons.volume_off,
                label: _isSpeakerOn ? 'مكبر الصوت' : 'سماعات',
                color: Colors.white,
                onPressed: _toggleSpeaker,
              ),

              // End Call Button
              Container(
                width: 72,
                height: 72,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.call_end,
                    color: Colors.white,
                    size: 32,
                  ),
                  onPressed: _endCall,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Additional Controls (when call is connected)
          if (_isCallConnected) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Keypad Button
                _buildSmallControlButton(
                  icon: Icons.dialpad,
                  label: 'لوحة المفاتيح',
                  onPressed: () {
                    // TODO: Show keypad
                  },
                ),

                const SizedBox(width: 24),

                // Hold Button
                _buildSmallControlButton(
                  icon: Icons.pause,
                  label: 'تعليق',
                  onPressed: () {
                    // TODO: Implement hold functionality
                  },
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(28),
          ),
          child: IconButton(
            icon: Icon(
              icon,
              color: color,
              size: 24,
            ),
            onPressed: onPressed,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontSize: 12,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildSmallControlButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 16,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
    });
  }

  void _toggleSpeaker() {
    setState(() {
      _isSpeakerOn = !_isSpeakerOn;
    });
  }

  void _endCall() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'إنهاء المكالمة',
          style: TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.right,
        ),
        content: const Text(
          'هل أنت متأكد من إنهاء المكالمة؟',
          style: TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
          ),
          textAlign: TextAlign.right,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'إلغاء',
              style: TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text(
              'إنهاء',
              style: TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
