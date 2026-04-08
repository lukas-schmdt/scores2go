import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scores_2_go/user_favorites/bloc/user_favorites_bloc.dart';

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
    return BlocBuilder<UserFavoritesBloc, UserFavoritesState>(
      builder: (context, state) {
        final isPending = state.pendingId == scoreId;
        final color = isFavorite ? Colors.amber : Colors.grey;

        return SizedBox(
          width: 40,
          height: 40,
          child: IconButton(
            padding: EdgeInsets.zero,
            color: color,
            onPressed: isPending
                ? null
                : () {
                    if (!isFavorite) {
                      context
                          .read<UserFavoritesBloc>()
                          .add(AddUserFavoriteEvent(scoreId));
                    } else {
                      context
                          .read<UserFavoritesBloc>()
                          .add(RemoveUserFavoriteEvent(scoreId));
                    }
                  },
            icon: isPending
                ? SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: color,
                    ),
                  )
                : const Icon(Icons.star),
          ),
        );
      },
    );
  }
}
