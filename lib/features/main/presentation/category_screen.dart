import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:matule_me_speedrun/default.dart';
import 'package:matule_me_speedrun/features/main/presentation/bloc/goods/goods_bloc.dart';
import 'package:matule_me_speedrun/features/main/presentation/widgets/product_card_small.dart';
import 'package:matule_me_speedrun/features/products/domain/models/category.dart';

@RoutePage()
class CategoryScreen extends StatefulWidget {
  const CategoryScreen(
      {super.key, required this.category, required this.index});

  final Category category;
  final int index;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  GoodsBloc goodsBloc = GetIt.I<GoodsBloc>();

  late int selectedIndex = widget.index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer(
      bloc: goodsBloc,
      listener: (context, state) {
        if (state is GoodsLoaded) {
          setState(() {
            selectedIndex = state.categories.indexWhere(
              (element) => element.id == widget.category.id,
            );
          });
        }
      },
      builder: (context, state) {
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
                    widget.category.name,
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
                          child: state is GoodsLoaded
                              ? ListView.separated(
                                  clipBehavior: Clip.none,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = index;
                                        });
                                      },
                                      child: Container(
                                        width: 108,
                                        decoration: BoxDecoration(
                                          color: selectedIndex == index
                                              ? theme.colorScheme.blue
                                              : theme.colorScheme.onSurface,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          state.categories[index].name,
                                          style: theme.textTheme.labelLarge
                                              ?.copyWith(
                                            height: null,
                                            color: selectedIndex == index
                                                ? theme.colorScheme.onSurface
                                                : theme.colorScheme
                                                    .onSurfaceVariant,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(width: 16);
                                  },
                                  itemCount: state.categories.length,
                                  shrinkWrap: true,
                                )
                              : const CircularProgressIndicator(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24.75),
                  BlocConsumer(
                    bloc: goodsBloc,
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      if (state is GoodsLoaded) {
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 13,
                            crossAxisSpacing: 13,
                            childAspectRatio: 160 / 184,
                          ),
                          itemBuilder: (context, index) {
                            var products = state.products.where((product) {
                              return product.categoryId ==
                                  state.categories[selectedIndex].id;
                            }).toList();

                            return ProductCardSmall(
                              product: products[index],
                            );
                          },
                          itemCount: state.products.where((product) {
                            return product.categoryId ==
                                state.categories[selectedIndex].id;
                          }).length,
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
