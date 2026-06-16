import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sights_app/di.dart';
import 'package:sights_app/domain/model/sight.dart';
import 'package:sights_app/presentation/core/style/extensions.dart';
import 'package:sights_app/presentation/core/widget/custom_action_button.dart';
import 'package:sights_app/presentation/sights/widget/rating_stars.dart';

class SightDetailsScreen extends ConsumerWidget {
  final Sight sight;

  const SightDetailsScreen({super.key, required this.sight});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(
      favoritesNotifierProvider.select(
            (favorites) => favorites.any((s) => s.id == sight.id),
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageHeader(context, ref, isFavorite),
            const SizedBox(height: 30),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(sight.title, style: context.textTitle.copyWith(fontSize: 26)),
                    const SizedBox(height: 4),
                    Text(
                      sight.address,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                    Text("Rating", style: context.textLabel.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    RatingStars(sight.rating),
                    const SizedBox(height: 20),
                    Text(sight.description, style: const TextStyle(fontSize: 14, height: 1.5)),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: CustomActionButton(
                label: "Show on maps",
                onPressed: () => _openInMaps(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageHeader(BuildContext context, WidgetRef ref, bool isFavorite) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Hero(
            tag: 'sight-image-${sight.id}',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                sight.imageUrl,
                height: 280,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    height: 280,
                    color: Colors.black12,
                    child: const Center(child: CircularProgressIndicator.adaptive()),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  'assets/images/placeholder.jpg',
                  height: 280,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 16,
          left: 36,
          child: _circleButton(
            icon: Icons.chevron_left,
            iconColor: context.colorText,
            background: Colors.white,
            onTap: () => Navigator.of(context).pop(),
          ),
        ),
        Positioned(
          bottom: -24,
          right: 36,
          child: GestureDetector(
            onTap: () => ref.read(favoritesNotifierProvider.notifier).toggle(sight),
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [context.colorGradientBegin, context.colorGradientEnd],
                ),
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (child, animation) =>
                    ScaleTransition(scale: animation, child: child),
                child: Icon(
                  isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  key: ValueKey(isFavorite),
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _circleButton({
    required IconData icon,
    required Color iconColor,
    required Color background,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: background,
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6)],
        ),
        child: Icon(icon, color: iconColor, size: 26),
      ),
    );
  }

  Future<void> _openInMaps() async {
    final lat = sight.lat;
    final lng = sight.lng;
    final label = Uri.encodeComponent(sight.title);

    if (Platform.isIOS) {

      final googleMaps = Uri.parse('comgooglemaps://?q=$lat,$lng&center=$lat,$lng');
      if (await canLaunchUrl(googleMaps)) {
        await launchUrl(googleMaps);
        return;
      }
      final appleMaps = Uri.parse('https://maps.apple.com/?q=$label&ll=$lat,$lng');
      await launchUrl(appleMaps, mode: LaunchMode.externalApplication);
      return;
    }

    final geo = Uri.parse('geo:$lat,$lng?q=$lat,$lng($label)');
    if (await canLaunchUrl(geo)) {
      await launchUrl(geo, mode: LaunchMode.externalApplication);
      return;
    }
    final fallback = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');
    await launchUrl(fallback, mode: LaunchMode.externalApplication);
  }
}