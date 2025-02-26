import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:matule_me_speedrun/features/main/presentation/bloc/goods/goods_bloc.dart';
import 'package:matule_me_speedrun/features/main/presentation/widgets/favourites_button.dart';
import 'package:matule_me_speedrun/features/main/presentation/widgets/product_card_small.dart';

@RoutePage()
class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  GoodsBloc goodsBloc = GetIt.I<GoodsBloc>();

  @override
  void initState() {
    super.initState();
    goodsBloc.add(const FetchGoods());
  }
  
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
                    // context.router.maybePop();
                    goodsBloc.add(const FetchGoods());
                    AutoTabsRouter.of(context).back();
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
                'Избранное',
                style: theme.textTheme.headlineSmall,
              ),
              const FavouritesButton(),
            ],
          ),
        ),
      ),
      body: BlocConsumer(
        bloc: goodsBloc,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is GoodsLoaded) {
            var favProducts = state.products.where((element) => element.isFavourite).toList();

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(21),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 13,
                    crossAxisSpacing: 13,
                    childAspectRatio: 160 / 184,
                  ),
                  itemBuilder: (context, index) {
                    return ProductCardSmall(
                      product: favProducts[index],
                    );
                  },
                  itemCount: favProducts.length,
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
