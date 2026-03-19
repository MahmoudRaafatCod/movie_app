import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/constants/extensions/assets.dart';
import 'package:movie/core/constants/extensions/context_extension.dart';
import 'package:movie/features/home_screen/logic/theme_cubit/theme_cubit.dart';
import 'package:movie/features/profile/ui/widgets/profile_header.dart';
import 'package:movie/features/profile/ui/widgets/profile_menu_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('profile'.tr() ,style: TextStyle(color: context.textColor , fontFamily: Assets.cairoFont), ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const ProfileHeader(),
              const SizedBox(height: 10),

              ProfileMenuItem(
                icon: Icons.language,
                title: 'language'.tr(),
                trailing: DropdownButton(
                  value: context.locale.languageCode,
                  underline: const SizedBox(),
                  items: [
                    DropdownMenuItem(
                      value: 'ar',
                      child: Text('العربية' , style: TextStyle(fontFamily: Assets.cairoFont),),
                    ),
                    DropdownMenuItem(
                      value: 'en',
                      child: Text('English'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value == 'ar') {
                      context.setLocale(const Locale('ar'));
                    } else {
                      context.setLocale(const Locale('en'));
                    }
                  },
                ),
                onTap: () {},
              ),

              BlocBuilder<ThemeCubit, ThemeMode>(
                builder: (context, themeMode) {
                  return ProfileMenuItem(
                    icon: Icons.dark_mode,
                    title: 'dark_mode'.tr(),
                    trailing: Switch(
                      value: context.isDark,
                      activeThumbColor: Theme.of(context).primaryColor,
                      onChanged: (value) {
                        context.read<ThemeCubit>().toggleTheme();
                      },
                    ),
                  );
                },
              ),

              ProfileMenuItem(
                icon: Icons.notifications_none,
                title: 'notifications'.tr(),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(
                      content: Text("coming_soon".tr()),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              ),

              ProfileMenuItem(
                icon: Icons.privacy_tip_outlined,
                title: 'privacy_policy'.tr(),
                onTap: () {
                    SnackBar(
                      content: Text("coming_soon".tr()),
                      duration: const Duration(seconds: 2),
                  );
                },
              ),

              ProfileMenuItem(
                icon: Icons.help_outline,
                title: 'help_center'.tr(),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("coming_soon".tr()),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              ),

              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),

              ProfileMenuItem(
                icon: Icons.logout,
                title: 'logout'.tr(),
                iconColor: Colors.red,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("coming_soon".tr()),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              ),

              const SizedBox(height: 40),
              Text(
                '${'app_version'.tr()} : 0.0.1',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
