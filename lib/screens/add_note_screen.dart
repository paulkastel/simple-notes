import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/add_note/add_note_cubit.dart';
import '../dao/dao_notes.dart';
import '../utils/database.dart';

class AddNoteProvider extends StatelessWidget {
  const AddNoteProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddNoteCubit(DaoNotes(AppDatabase.instance)),
      child: const AddNoteScreen(),
    );
  }
}

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final GlobalKey<FormState> _formAddNoteKey = GlobalKey();
  final _noteEditingController = TextEditingController();

  @override
  void dispose() {
    _noteEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add note'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Form(
              key: _formAddNoteKey,
              child: TextFormField(
                minLines: 3,
                maxLines: 10,
                keyboardType: TextInputType.multiline,
                controller: _noteEditingController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field must not be empty!';
                  } else {
                    return null;
                  }
                },
              ),
            ),
          ),
          BlocConsumer<AddNoteCubit, AddNoteState>(
            listener: (context, state) {
              if (state is AddNoteSuccess) {
                Navigator.pop(context);
              } else if (state is AddNoteError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Adding note failed: ${state.exception}'),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is AddNoteLoading) {
                return const CircularProgressIndicator.adaptive();
              }
              return ElevatedButton(
                onPressed: () {
                  if (_formAddNoteKey.currentState!.validate()) {
                    _formAddNoteKey.currentState!.save();
                    context.read<AddNoteCubit>().saveNote(_noteEditingController.text);
                  }
                },
                child: const Text('Save'),
              );
            },
          ),
        ],
      ),
    );
  }
}
