import 'package:flutter/material.dart';

void main() {
  runApp(const BijiApp());
}

class BijiApp extends StatelessWidget {
  const BijiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biji Coffee Shop',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: const Color(0xFF309f5f),
      ),
      home: const OnboardingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> slides = [
    {
      "title": "Best coffee shop\nin this town",
      "text":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor",
      "image": "assets/images/rank.png"
    },
    {
      "title": "Start your morning\nwith great coffee",
      "text":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor",
      "image": "assets/images/rank.png"
    },
    {
      "title": "Taste from the\ngood old days",
      "text":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor",
      "image": "assets/images/rank.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(74, 55, 73, 1),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              "assets/images/background/linebg.png",
              fit: BoxFit.cover,
            ),
          ),

          // PageView
          PageView.builder(
            controller: _controller,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemCount: slides.length,
            itemBuilder: (context, index) {
              final slide = slides[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  Image.asset(slide["image"]!, height: 200),
                  const SizedBox(height: 40),
                  Text(
                    slide["title"]!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      slide["text"]!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: const Color.fromARGB(255, 255, 255, 255),
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // Pagination Dots
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                slides.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 20 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? const Color(0xFF309f5f)
                        : Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),

          // Start Button
          Positioned(
            bottom: 40,
            right: 30,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const WelcomePage()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Color(0xFF4A3749),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF309f5f),
      body: const Center(
        child: Text(
          'Welcome to Biji Coffee ☕',
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
