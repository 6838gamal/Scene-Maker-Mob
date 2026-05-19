# Scene Maker

An AI-powered video scene manipulation Flutter application.

## Overview

Scene Maker is a mobile-first web app that lets users tap objects in videos and apply AI edits (remove, replace, recolor, animate, relight) with a simple, cinematic interface. Built for TikTok, Instagram Reels, and YouTube Shorts creators.

## Architecture

- **Framework**: Flutter 3.32 (web target)
- **Language**: Dart
- **State Management**: Provider
- **Localization**: Custom `AppLocalizations` with English and Arabic support (RTL/LTR)
- **Theme**: Material 3, Dark mode first
- **Fonts**: Poppins + Inter (English), Cairo + IBM Plex Sans Arabic (Arabic)

## Project Structure

```
lib/
  main.dart                    # App entry point with MultiProvider
  theme/
    app_colors.dart            # Color palette (dark + light)
    app_theme.dart             # ThemeData definitions + typography
  l10n/
    app_localizations.dart     # English + Arabic localization (no code gen)
  providers/
    theme_provider.dart        # Dark/light/system theme management
    locale_provider.dart       # Language + RTL/LTR switching
    project_provider.dart      # Projects state
  models/
    project.dart               # Project model
    ai_template.dart           # AI template data + kTemplates list
  screens/
    home_screen.dart           # Home dashboard (SliverAppBar, projects, templates)
    editor_screen.dart         # Video editor with AI action menu
    projects_screen.dart       # All projects grid
    templates_screen.dart      # AI template browser with tab categories
    contact_screen.dart        # Contact developer screen
    feedback_screen.dart       # Feedback form with rating
    version_screen.dart        # Version details + release notes
    settings_screen.dart       # Language, theme, export quality, preferences
  widgets/
    app_drawer.dart            # Side navigation drawer with premium banner
    ai_action_menu.dart        # Floating AI action menu (Remove/Replace/Recolor/Animate/Relight)
    glass_card.dart            # Glassmorphism card + gradient card
    gradient_button.dart       # Gradient CTAs
    project_card.dart          # Project thumbnail card
    template_card.dart         # AI template card (small + large variants)
```

## Running the App

```bash
flutter run -d web-server --web-hostname 0.0.0.0 --web-port 5000
```

**Note**: On first load in the preview pane, do a hard refresh (Ctrl+Shift+R) to clear the service worker cache from the old hello world app.

## Key Features Implemented

- **Home Screen**: Expandable app bar, New Project banner, recent projects carousel, AI templates scroll, trending styles grid
- **Editor Screen**: Tap-to-select objects, floating AI action menu with animations, timeline scrubber, play/pause, Export sheet with platform/quality selection
- **AI Templates**: Cinematic, Luxury, Horror, Tech, Vintage, Motivational, Dark Aesthetic, Auto Captions
- **Navigation Drawer**: Smooth drawer with all screens linked, premium upgrade banner
- **Feedback Screen**: Feedback type selector, star rating, text field, success state
- **Version Screen**: Current version card, release notes with bullets
- **Settings Screen**: Language toggle, theme selector, export quality, notification toggles
- **Localization**: Full English + Arabic with dynamic RTL/LTR switching
- **Freemium model**: PRO badges on premium templates

## User Preferences

- Dark mode first aesthetic
- Cinematic, premium feel
- Arabic and English localization with RTL support
