import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/home/home_cubit.dart';
import '../models/note.dart';

class NoteTile extends StatelessWidget {
  const NoteTile(this.note, {Key? key}) : super(key: key);

  final Note note;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        context.read<HomeCubit>().deleteNote(note);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Text(
                note.content,
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  note.creationDate.toString(),
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
