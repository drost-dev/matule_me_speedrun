import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:matule_me_speedrun/features/main/presentation/widgets/favourites_button.dart';
import 'package:matule_me_speedrun/features/main/presentation/widgets/product_card_small.dart';

@RoutePage()
class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(92),
        child: Container(
          padding: const EdgeInsets.only(top: 48, left: 20, right: 20),
          constraints: const BoxConstraints.expand(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox.square(
                dimension: 44,
                child: IconButton(
                  onPressed: () {
                    context.router.maybePop();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: theme.colorScheme.onSurface,
                  ),
                  icon: const ImageIcon(
                    AssetImage('icons/arrow_left.png'),
                  ),
                ),
              ),
              Text(
                'Популярное',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  height: 24 / 16,
                ),
              ),
              const FavouritesButton(),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(21),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 13,
              crossAxisSpacing: 13,
              childAspectRatio: 160/184,
            ),
            itemBuilder: (context, index) {
              return const ProductCardSmall();
            },
            itemCount: 6,
          ),
        ),
      ),
    );
  }
}
