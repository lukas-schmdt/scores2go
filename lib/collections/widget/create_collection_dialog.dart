import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scores_2_go/collections/bloc/collections_bloc.dart';
import 'package:scores_2_go/l10n/app_localizations.dart';

/// Asks for a name and creates a new collection. [context] must be below the
/// [CollectionsBloc].
Future<void> showCreateCollectionDialog(BuildContext context) async {
  final bloc = context.read<CollectionsBloc>();
  final l = AppLocalizations.of(context)!;
  final controller = TextEditingController();
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(l.newCollection),
      content: SizedBox(
        width: 320,
        child: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(
            hintText: l.collectionNameHint,
            border: const OutlineInputBorder(),
            isDense: true,
          ),
          textCapitalization: TextCapitalization.sentences,
          onSubmitted: (_) => Navigator.of(ctx).pop(true),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(false),
          child: Text(l.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(true),
          child: Text(l.create),
        ),
      ],
    ),
  );
  if (confirmed == true && controller.text.trim().isNotEmpty) {
    bloc.add(CreateCollectionEvent(controller.text.trim()));
  }
  controller.dispose();
}
