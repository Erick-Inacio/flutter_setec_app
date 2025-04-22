import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:setec_app/ui/speaker/viewModel/speaker_view_model.dart';
import 'package:setec_app/ui/speaker/widgets/speaker_card_widget.dart';
import 'package:setec_app/ui/utils/widgets/iconButton/reload_widget.dart';

class SpeakersView extends ConsumerStatefulWidget {
  const SpeakersView({
    super.key,
  });

  @override
  ConsumerState<SpeakersView> createState() => _SpeakersView();
}

class _SpeakersView extends ConsumerState<SpeakersView> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final speakerVM = ref.watch(speakerViewModel);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Palestrantes'),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ReloadWidget(onPressed: () {
              ref.read(speakerViewModel.notifier).fetchSpeaker();
            }),
          )
        ],
      ),
      body: speakerVM.when(
        data: (speakers) => SafeArea(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            itemCount: speakers.length,
            itemBuilder: (context, index) => SpeakerCardWidget(
              user: speakers[index],
              width: width,
            ),
          ),
        ),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
