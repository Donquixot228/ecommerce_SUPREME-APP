part of 'wishlist_bloc.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();

  List<Object> get props =>[];
}



class WishlistDefault extends WishlistState{}


class WishlistLoading extends WishlistState {}



class WishlistLoaded extends WishlistState {
  final Wishlist wishlist;

  const WishlistLoaded({this.wishlist = const Wishlist()});

  @override
  List<Object> get props => [wishlist];
}




class WishlistError extends WishlistState {}
