import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/web.dart';
import 'package:setec_app/core/enums/relationship.dart';
import 'package:setec_app/core/enums/roles.dart';
import 'package:setec_app/domain/models/user_app.dart';
import 'package:setec_app/ui/auth/providers/auth_provider.dart';
import 'package:setec_app/ui/auth/viewModel/auth_view_model.dart';
import 'package:setec_app/ui/auth/widgets/will_palestrate_widget.dart';
import 'package:setec_app/ui/utils/widgets/Text/FormField/speaker_forms_widget.dart';

class CreateAccount extends ConsumerStatefulWidget {
  const CreateAccount({super.key});

  @override
  ConsumerState<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends ConsumerState<CreateAccount> {
  final formKey = GlobalKey<FormState>();

  // Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final companyController = TextEditingController();
  final bioController = TextEditingController();
  final positionController = TextEditingController();
  final ra = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Providers
    final authState = ref.watch(authAsyncProvider);
    final authVM = ref.read(authAsyncProvider.notifier);
    final isSpeaker = ref.watch(isSpeakerProvider);
    final relationship = ref.watch(relationshipProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Criar Conta")),
      body: Form(
        key: formKey,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(16.0),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration:
                            const InputDecoration(labelText: 'Nome completo'),
                        validator: (value) => authVM.validateName(value),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(labelText: 'Email'),
                        validator: (value) => authVM.validateEmail(value),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(labelText: 'Senha'),
                        validator: (value) => authVM.validatePassword(value),
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField(
                        value: relationship.isNotEmpty ? relationship : null,
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.normal,
                          color: Colors.deepPurple,
                          fontSize: 16,
                        ),
                        items: authVM.items(Relationship.rolesName),
                        onChanged: (value) {
                          Logger().i('Relationship: $value');
                          ref.read(relationshipProvider.notifier).state =
                              value!;
                        },
                        decoration: const InputDecoration(
                            labelText: 'Relação com a FATEC'),
                      ),
                      const SizedBox(height: 16),
                      if (relationship == Relationship.aluno.displayName)
                        TextFormField(
                          controller: ra,
                          keyboardType: TextInputType.number,
                          maxLength: 13,
                          decoration: const InputDecoration(labelText: 'RA'),
                          style: GoogleFonts.lato(
                              color: Colors.deepPurple, fontSize: 15),
                        ),
                      WillPalestrateWidget(
                        value: isSpeaker,
                        onChanged: (value) {
                          ref.read(isSpeakerProvider.notifier).state = value;
                        },
                      ),
                      if (isSpeaker) SizedBox(height: 16),
                      if (isSpeaker)
                        SpeakerFormsWidget(
                          parentContext: context,
                          company: companyController,
                          position: positionController,
                          bio: bioController,
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: authState is AsyncLoading
                    ? null
                    : () async {
                        Logger().i("Entrou no onpressed");
                        await authVM.createUser(
                          context: context,
                          formKey: formKey,
                          email: emailController.text,
                          password: passwordController.text,
                          company: companyController.text,
                          position: positionController.text,
                          bio: bioController.text,
                          isSpeaker: isSpeaker,
                          user: UserApp(
                            uid: '',
                            name: nameController.text,
                            relationship: Relationship.values.firstWhere(
                              (e) => e.name == relationship,
                              orElse: () => Relationship.aluno,
                            ),
                            ra: ra.text,
                            email: emailController.text,
                            role: isSpeaker ? Roles.speaker : Roles.student,
                          ),
                        );
                      },
                child: authState is AsyncLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Criar Conta',
                        style: TextStyle(color: Colors.white)),
              ),
              ElevatedButton(
                onPressed: () {
                  nameController.text = "Teste Speaker";
                  emailController.text = "testespeaker1@speaker.com";
                  passwordController.text = "123456";
                  companyController.text = "FATEC";
                  positionController.text = "Desenvolvedor Flutter";
                  bioController.text = "Desenvolvedor Flutter";
                },
                child: Text('Mock Speaker'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
