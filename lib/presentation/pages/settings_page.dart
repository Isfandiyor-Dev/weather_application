import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/cubits/theme/theme_mode_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text("Settings"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text("THEME", style: TextStyle(fontSize: 15, height: 2)),
          ),
          BlocBuilder<ThemeModeCubit, bool>(builder: (context, state) {
            return SwitchListTile.adaptive(
              title: const Text("Theme mode", style: TextStyle(fontSize: 18)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              value: state,
              onChanged: (value) {
                context.read<ThemeModeCubit>().toggleThemeMode();
              },
            );
          }),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Divider(
              height: 30,
            ),
          ),
        ],
      ),
    );
  }
}
