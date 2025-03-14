import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:matule_me_speedrun/default.dart';
import 'package:matule_me_speedrun/features/main/presentation/bloc/goods/goods_bloc.dart';
import 'package:matule_me_speedrun/features/router/presentation/app_router.dart';
import 'package:matule_me_speedrun/features/main/presentation/widgets/cart_button.dart';
import 'package:matule_me_speedrun/features/main/presentation/widgets/product_card_small.dart';

class HomeScreenOld extends StatefulWidget {
  const HomeScreenOld({super.key});

  @override
  State<HomeScreenOld> createState() => _HomeScreenOldState();
}

class _HomeScreenOldState extends State<HomeScreenOld> {
  final categories = const ['Все', 'Outdoor', 'Tennis', 'Running'];

  final goodsBloc = GetIt.I<GoodsBloc>();

  @override
  void initState() {
    goodsBloc.add(const GoodsFetch());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer(
      bloc: goodsBloc,
      listener: (context, state) {
        // TODO: implement listener
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
                  Image.asset('assets/icons/hamburger.png'),
                  Text(
                    'Главная',
                    style: theme.textTheme.displayMedium,
                  ),
                  const CartButton(hasItems: true),
                ],
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  constraints: const BoxConstraints.expand(height: 52),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 4),
                                blurRadius: 4,
                                spreadRadius: 0,
                                color: Colors.black.withValues(alpha: 0.04),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            style: theme.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                              height: 20 / 12,
                            ),
                            decoration: InputDecoration(
                              fillColor: theme.colorScheme.onSurface,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.only(
                                top: 14,
                                bottom: 14,
                                right: 57,
                              ),
                              hintText: 'Поиск',
                              hintStyle: theme.textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.w500,
                                height: 20 / 12,
                              ),
                              prefixIcon: Padding(
                                padding:
                                    const EdgeInsets.only(left: 26, right: 12),
                                child: ImageIcon(
                                  const AssetImage('assets/icons/search.png'),
                                  size: 24,
                                  color: theme.colorScheme.darkGrey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      SizedBox.square(
                        dimension: 52,
                        child: IconButton(
                          onPressed: () {},
                          icon: ImageIcon(
                            const AssetImage('assets/icons/filters.png'),
                            size: 24,
                            color: theme.colorScheme.onSurface,
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: theme.colorScheme.blue,
                            padding: const EdgeInsets.all(14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
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
                                      context.router.push(
                                        CategoryRoute(
                                          category: state.categories[index],
                                          index: index,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 108,
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.onSurface,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        state.categories[index].name,
                                        style: theme.textTheme.labelLarge
                                            ?.copyWith(
                                          height: null,
                                          color: theme
                                              .colorScheme.onSurfaceVariant,
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
                            : Center(
                                child: CircularProgressIndicator(
                                  color: theme.colorScheme.blue,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 224,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Популярное',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              height: 24 / 16,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              context.router.push(const PopularRoute());
                            },
                            child: Text(
                              'Все',
                              style: theme.textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: theme.colorScheme.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ProductCardSmall(
                            product:
                                state is GoodsLoaded ? state.products[0] : null,
                          ),
                          ProductCardSmall(
                            product:
                                state is GoodsLoaded ? state.products[0] : null,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  height: 135,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Акции',
                            style: theme.textTheme.headlineSmall,
                          ),
                          Text(
                            'Все',
                            style: theme.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: theme.colorScheme.blue,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Image.asset('assets/images/summer_sale.png'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
