import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fundflow/Core/AppRouter.dart';
import 'package:go_router/go_router.dart';

import '../../../Core/AppColors.dart';

import 'package:hive_flutter/hive_flutter.dart';

class Language extends StatefulWidget {
  const Language({super.key});

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  String? _selectedLanguage;
  static const String _langPrefKey = 'user_language_pref';

  // Use a getter to safely access the box
  Box get _settingsBox => Hive.box('settings');

  @override
  void initState() {
    super.initState();
    _initializeLanguage();
  }

  void _initializeLanguage() {
    // We use a post-frame callback to ensure context is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 1. Check if the box has our specific saved intent
      final String? savedSelection = _settingsBox.get(_langPrefKey);

      setState(() {
        if (savedSelection != null) {
          _selectedLanguage = savedSelection;
        } else {
          // Fallback: If no intent saved, check easy_localization's state
          _selectedLanguage = context.savedLocale == null
              ? 'system'
              : context.locale.languageCode;
        }
      });
    });
  }

  Future<void> _changeLanguage(String languageCode) async {
    // Update UI highlight
    setState(() => _selectedLanguage = languageCode);

    // Save intent to Hive
    await _settingsBox.put(_langPrefKey, languageCode);

    // Execute locale change
    if (languageCode == 'system') {
      if (!mounted) return;
      context.resetLocale();
      context.go("/");
    } else {
      if (!mounted) return;
      context.setLocale(Locale(languageCode));
      context.go("/");
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('languages'.tr()),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text('selectLanguage'.tr(), style: theme.textTheme.headlineSmall),

              const SizedBox(height: 15),
              // // SYSTEM CARD - Now correctly tracks the 'system' string
              // _LanguageCard(
              //   languageCode: 'system',
              //   languageName: 'followSystem'.tr(),
              //   nativeName: 'systemDefault'.tr(),
              //   flag: '🌐',
              //   isSelected: _selectedLanguage == 'system',
              //   onTap: () => _changeLanguage('system'),
              // ),

              // const SizedBox(height: 16),
              // // _buildDivider(theme),
              // const SizedBox(height: 16),

              // SPECIFIC LANGUAGES
              Expanded(
                child: ListView(
                  children: [
                    _LanguageCard(
                      languageCode: 'en',
                      languageName: 'English',
                      nativeName: 'English',
                      flag: '🇺🇸',
                      isSelected: _selectedLanguage == 'en',
                      onTap: () => _changeLanguage('en'),
                    ),
                    const SizedBox(height: 12),
                    _LanguageCard(
                      languageCode: 'fr',
                      languageName: 'French',
                      nativeName: 'Français',
                      flag: '🇫🇷',
                      isSelected: _selectedLanguage == 'fr',
                      onTap: () => _changeLanguage('fr'),
                    ),
                    const SizedBox(height: 12),
                    _LanguageCard(
                      languageCode: 'ar',
                      languageName: 'Arabic',
                      nativeName: 'العربية',
                      flag: '🇸🇦',
                      isSelected: _selectedLanguage == 'ar',
                      onTap: () => _changeLanguage('ar'),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.accentBlueSubtle.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.accentBlueSubtle.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: AppColors.accentBlueSubtle,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'languageChangeNote'.tr(),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.darkText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// _LanguageCard remains as you had it, as the logic fix is in the Parent state.
class _LanguageCard extends StatelessWidget {
  final String languageCode;
  final String languageName;
  final String nativeName;
  final String flag;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageCard({
    required this.languageCode,
    required this.languageName,
    required this.nativeName,
    required this.flag,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryDark : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primaryDark : AppColors.dividerLight,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primaryDark.withValues(alpha: 0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            // Flag
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withValues(alpha: 0.15)
                    : AppColors.lightGreyColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  flag,
                  style: const TextStyle(fontSize: 32),
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Language Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    languageName,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : AppColors.darkText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    nativeName,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isSelected
                          ? Colors.white.withValues(alpha: 0.8)
                          : AppColors.greyColor,
                    ),
                  ),
                ],
              ),
            ),

            // Check Icon
            AnimatedScale(
              scale: isSelected ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: AppColors.primaryDark,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
