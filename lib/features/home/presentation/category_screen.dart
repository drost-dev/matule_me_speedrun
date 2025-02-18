import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:matule_me_speedrun/default.dart';
import 'package:matule_me_speedrun/features/home/presentation/widgets/product_card_small.dart';

@RoutePage()
class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key, required this.category});

  final String category;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final categories = const ['Все', 'Outdoor', 'Tennis', 'Running'];
  late int selectedCategory = categories.indexOf(widget.category);

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
                categories[selectedCategory],
                style: theme.textTheme.headlineSmall,
              ),
              const SizedBox(width: 44),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(21),
          child: Column(
            children: [
              SizedBox(
                height: 75,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Категории',
                      style: theme.textTheme.headlineSmall,
                    ),
                    SizedBox(
                      height: 40,
                      child: ListView.separated(
                        clipBehavior: Clip.none,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCategory = index;
                              });
                            },
                            child: Container(
                              width: 108,
                              decoration: BoxDecoration(
                                color: selectedCategory == index ? theme.colorScheme.blue : theme.colorScheme.onSurface,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                categories[index],
                                style: theme.textTheme.labelLarge?.copyWith(
                                  height: null,
                                  color: selectedCategory == index ? theme.colorScheme.onSurface : theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(width: 16);
                        },
                        itemCount: 4,
                        shrinkWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24.75),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 13,
                  crossAxisSpacing: 13,
                  childAspectRatio: 160 / 184,
                ),
                itemBuilder: (context, index) {
                  return const ProductCardSmall();
                },
                itemCount: 6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
