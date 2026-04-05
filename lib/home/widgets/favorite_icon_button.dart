import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scores_2_go_2/user_favorites/bloc/user_favorites_bloc.dart';

class FavoriteIconButton extends StatelessWidget {
  const FavoriteIconButton({
    super.key,
    required this.isFavorite,
    required this.scoreId,
  });

  final bool isFavorite;
  final int scoreId;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: isFavorite ? Colors.amber : Colors.grey,
      onPressed: () {
        if (!isFavorite) {
          context.read<UserFavoritesBloc>().add(AddUserFavoriteEvent(scoreId));
        } else {
          context.read<UserFavoritesBloc>().add(RemoveUserFavoriteEvent(scoreId));
        }
      },
      icon: const Icon(Icons.star),
    );
  }
}
