import 'package:flutter/material.dart';
import 'package:sights_app/domain/model/sight.dart';
import 'package:sights_app/presentation/core/app_router.dart';
import 'package:sights_app/presentation/core/style/extensions.dart';
import 'package:sights_app/presentation/sights/widget/rating_stars.dart';

class SightCard extends StatelessWidget {
  final Sight sight;

  const SightCard(this.sight, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        AppRouter.sightDetailsScreen,
        arguments: sight,
      ),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [context.colorGradientBegin, context.colorGradientEnd],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                sight.imageUrl,
                width: 135,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sight.title,
                    style: context.textCardTitle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    sight.address,
                    style: context.textCardSubtitle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${sight.lat}, ${sight.lng}",
                    style: context.textCardLabel,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 15),
                  RatingStars(sight.rating),
                ],
              ),
            ),
            const Icon(Icons.favorite_rounded, color: Colors.white, size: 25),
          ],
        ),
      ),
    );
  }
}