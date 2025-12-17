import 'package:flutter/material.dart';
import 'pantry_scan_screen.dart';

class MoodQuizScreen extends StatefulWidget {
  const MoodQuizScreen({super.key});

  @override
  State<MoodQuizScreen> createState() => _MoodQuizScreenState();
}

class _MoodQuizScreenState extends State<MoodQuizScreen> {
  double _stressLevel = 50.0;
  double _hungerLevel = 50.0;

  String _getStressLabel() {
    if (_stressLevel < 25) return 'Relaxed';
    if (_stressLevel < 50) return 'Calm';
    if (_stressLevel < 75) return 'Tense';
    return 'Stressed';
  }

  String _getHungerLabel() {
    if (_hungerLevel < 25) return 'Not Hungry';
    if (_hungerLevel < 50) return 'A Bit Hungry';
    if (_hungerLevel < 75) return 'Hungry';
    return 'Very Hungry';
  }

  Color _getStressColor() {
    return Color.lerp(
      Colors.green.shade600,
      Colors.red.shade600,
      _stressLevel / 100,
    )!;
  }

  Color _getHungerColor() {
    return Color.lerp(
      Colors.blue.shade600,
      Colors.orange.shade600,
      _hungerLevel / 100,
    )!;
  }

  void _onNext() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PantryScanScreen(
          stressLevel: _stressLevel,
          hungerLevel: _hungerLevel,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: const Text(
          'FlavorMood',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Responsive padding based on screen width
          final horizontalPadding = constraints.maxWidth > 600 ? 48.0 : 20.0;
          final maxContentWidth = constraints.maxWidth > 600 ? 600.0 : constraints.maxWidth;

          return SafeArea(
            child: Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: maxContentWidth),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 24.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Welcome Header
                      const SizedBox(height: 8),
                      Text(
                        'Welcome!',
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'How are you feeling today?',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Select your mood to find the perfect recipe',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey.shade700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),

                      // Stress Level Card
                      _buildMoodCard(
                        title: 'Stress Level',
                        icon: Icons.psychology_outlined,
                        value: _stressLevel,
                        label: _getStressLabel(),
                        color: _getStressColor(),
                        onChanged: (value) {
                          setState(() {
                            _stressLevel = value;
                          });
                        },
                        minLabel: 'Relaxed',
                        maxLabel: 'Stressed',
                      ),
                      const SizedBox(height: 20),

                      // Hunger Level Card
                      _buildMoodCard(
                        title: 'Hunger Level',
                        icon: Icons.restaurant_outlined,
                        value: _hungerLevel,
                        label: _getHungerLabel(),
                        color: _getHungerColor(),
                        onChanged: (value) {
                          setState(() {
                            _hungerLevel = value;
                          });
                        },
                        minLabel: 'Not Hungry',
                        maxLabel: 'Very Hungry',
                      ),
                      const SizedBox(height: 32),

                      // Next Button
                      SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _onNext,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Next',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward, size: 20),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMoodCard({
    required String title,
    required IconData icon,
    required double value,
    required String label,
    required Color color,
    required ValueChanged<double> onChanged,
    required String minLabel,
    required String maxLabel,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Label
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon, color: Colors.grey.shade700, size: 24),
                    const SizedBox(width: 10),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: color,
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Slider
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: color,
                inactiveTrackColor: color.withOpacity(0.25),
                thumbColor: color,
                overlayColor: color.withOpacity(0.2),
                trackHeight: 6,
                thumbShape: const RoundSliderThumbShape(
                  enabledThumbRadius: 12,
                ),
              ),
              child: Slider(
                value: value,
                min: 0,
                max: 100,
                divisions: 100,
                onChanged: onChanged,
              ),
            ),
            
            // Min/Max Labels and Percentage
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      minLabel,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    '${value.round()}%',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      maxLabel,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
