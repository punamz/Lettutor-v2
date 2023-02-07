import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StarRatingWidget extends StatelessWidget {
  final double? rating;
  final double size;
  const StarRatingWidget({Key? key, this.rating, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return rating == null
        ? Text(
            'No review yet',
            style:
                context.textTheme.apply(bodyColor: context.theme.colorScheme.secondary).labelMedium,
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              rating! < 0.5
                  ? _InactiveStar(size: size)
                  : rating! < 1
                      ? _HalfStar(size: size)
                      : _ActiveStar(size: size),
              rating! < 1.5
                  ? _InactiveStar(size: size)
                  : rating! < 2
                      ? _HalfStar(size: size)
                      : _ActiveStar(size: size),
              rating! < 2.5
                  ? _InactiveStar(size: size)
                  : rating! < 3
                      ? _HalfStar(size: size)
                      : _ActiveStar(size: size),
              rating! < 3.5
                  ? _InactiveStar(size: size)
                  : rating! < 4
                      ? _HalfStar(size: size)
                      : _ActiveStar(size: size),
              rating! < 4.5
                  ? _InactiveStar(size: size)
                  : rating! < 5
                      ? _HalfStar(size: size)
                      : _ActiveStar(size: size),
            ],
          );
  }
}

class _ActiveStar extends StatelessWidget {
  final double size;
  const _ActiveStar({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.star_rounded, color: Colors.amber, size: size);
  }
}

class _InactiveStar extends StatelessWidget {
  final double size;
  const _InactiveStar({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.star_border_rounded, color: Colors.amber, size: size);
  }
}

class _HalfStar extends StatelessWidget {
  final double size;
  const _HalfStar({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.star_half_rounded, color: Colors.amber, size: size);
  }
}
