import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/home/home_cubit.dart';
import '../dao/dao_notes.dart';
import '../utils/app_routes.dart';
import '../utils/database.dart';
import 'note_tile.dart';

class HomeProvider extends StatelessWidget {
  const HomeProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(DaoNotes(AppDatabase.instance))..getNotes(),
      child: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeSuccess) {
            if (state.notes.isEmpty) {
              return const Center(
                child: Text('You do not have any notes! Add them!'),
              );
            } else {
              return ListView.builder(
                itemCount: state.notes.length,
                itemBuilder: (context, index) {
                  return NoteTile(state.notes[index]);
                },
              );
            }
          } else if (state is HomeError) {
            return Center(
              child: Text(state.exception.toString()),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, AppRoutes.addNoteScreen);
          await context.read<HomeCubit>().getNotes();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
