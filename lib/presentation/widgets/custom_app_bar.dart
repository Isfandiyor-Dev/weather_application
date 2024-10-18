import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/presentation/pages/favorites_page.dart';
import 'package:weather_app/presentation/pages/search_page.dart';
import 'package:weather_app/presentation/pages/settings_page.dart';

class CustomAppBar extends StatelessWidget {
  final String cityName;
  const CustomAppBar({super.key, required this.cityName});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton.outlined(
          style: IconButton.styleFrom(
            side: BorderSide(
              color: Colors.white.withOpacity(0.3),
            ),
          ),
          color: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FavoritesPage(),
              ),
            );
          },
          icon: const Icon(CupertinoIcons.heart_fill),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SearchPage(),
              ),
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.location_on_rounded,
                color: Colors.white,
                size: 22,
              ),
              Text(
                cityName,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        IconButton.outlined(
          style: IconButton.styleFrom(
            side: BorderSide(
              color: Colors.white.withOpacity(0.3),
            ),
          ),
          color: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => const SettingsPage(),
              ),
            );
          },
          icon: const Icon(Icons.more_vert_rounded),
        ),
      ],
    );
  }
}
