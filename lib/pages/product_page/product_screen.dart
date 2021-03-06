import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/blocs/cart/cart_bloc.dart';
import 'package:ecommerce/blocs/wishlist_bloc/wishlist_bloc.dart';
import 'package:ecommerce/models/models.dart';
import 'package:ecommerce/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatelessWidget {
  final Product product;

  const ProductScreen({Key? key, required this.product}) : super(key: key);

  static const String routeName = '/product';

  static Route route({required Product product}) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => ProductScreen(product: product),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: product.name,
      ),
      //вынести
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(300)),
            color: Colors.black,
            gradient: LinearGradient(
              colors: [
                Colors.black,
                Colors.black.withAlpha(50),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            )),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(
                Icons.share,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            BlocBuilder<WishlistBloc, WishlistState>(
              builder: (context, state) {
                return IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    context.read<WishlistBloc>().add(AddWishlistProduct(product));
                    final snackBar = SnackBar(
                      content: Text('Added to your favorite'),
                      duration: Duration(seconds: 1),
                      action: SnackBarAction(
                        label: '',
                        textColor: Colors.white,
                        onPressed: () {},
                      ),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      backgroundColor: Colors.blue,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  },
                );
              },
            ),
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    context.read<CartBloc>().add(CartProductAdded(product));
                    Navigator.pushNamed(context, '/cart');
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                  child: Text(
                    'ADD TO CART',
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontSize: 25, color: Colors.black),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      body: ListView(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              scrollPhysics: const BouncingScrollPhysics(),
              //tall image
              aspectRatio: 1.5,
              scrollDirection: Axis.horizontal,
              viewportFraction: 0.9,
              //ао аокам чутка видно дрпугие фото
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              //INITIAL
              initialPage: 1,
              autoPlay: true,
              //AUTOPLAY
            ),
            items: [
              HeroCarouselCard(product: product),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  alignment: Alignment.bottomCenter,
                  color: Colors.black.withAlpha(50),
                ),
                Container(
                  margin: EdgeInsets.all(5.0),
                  width: MediaQuery.of(context).size.width - 10,
                  height: 50,
                  color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        product.name,
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(fontSize: 20),
                      ),
                      Text(
                        '\$${product.price}',
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ExpansionTile(
              initiallyExpanded: false,
              title: Text(
                'Product information',
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: Colors.black),
              ),
              children: [
                ListTile(
                  title: Text(
                    'hajfsdhfjaskdfjksa',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ExpansionTile(
              initiallyExpanded: false,
              title: Text(
                'Delivery information',
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: Colors.black),
              ),
              children: [
                ListTile(
                  title: Text(
                    'Shiping time dependson your location. UK orders placed before 4pm will be delivered between 3-5 working days, central Europe within 5 business '
                    'days and all other countries please allow up to 10 business days. Note these transit are estimates and may vary',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
