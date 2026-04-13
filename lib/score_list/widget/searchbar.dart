import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scores_2_go/score_list/bloc/scores_bloc.dart';

class ScoreSearchBar extends StatelessWidget {
  const ScoreSearchBar({super.key, required this.showSearch});

  final bool showSearch;

  @override
  Widget build(BuildContext context) {
    return showSearch
        ? Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              spacing: 8,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(25),
                    child: TextFormField(
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Score suchen',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            context.read<ScoresBloc>().add(
                              ToggleShowSearchEvent(),
                            );
                            context.read<ScoresBloc>().add(
                              SearchScoresEvent(searchString: ''),
                            );
                          },
                        ),
                        filled: true,
                        fillColor: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerHighest,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onChanged: (value) {
                        BlocProvider.of<ScoresBloc>(
                          context,
                        ).add(SearchScoresEvent(searchString: value));
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(16),
            child: FloatingActionButton(
              onPressed: () =>
                  context.read<ScoresBloc>().add(ToggleShowSearchEvent()),
              child: const Icon(Icons.search),
            ),
          );
  }
}
