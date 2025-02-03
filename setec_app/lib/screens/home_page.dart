import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:setec_app/models/auth_provider_model.dart';
import 'package:setec_app/screens/login_options.dart';
import 'package:setec_app/widgets/card_carousel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> cards = List<Widget>.empty(growable: true);

  final authProvider = AuthProvider();

  @override
  void initState() {
    super.initState();
    cards.add(const CardCarousel());
    cards.add(const CardCarousel());
    cards.add(const CardCarousel());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () async {
              try {
                await authProvider.signOut();

                if (context.mounted) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginOptions(),
                    ),
                  );
                }
              } catch (e) {
                throw Exception("Failed to sign out: $e");
              }
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            CarouselSlider(
              items: cards,
              options: CarouselOptions(
                height: 400.0,
                autoPlay: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
