import 'package:belts_test/app/theme/belts_theme.dart';
import 'package:belts_test/home/bloc/home_bloc.dart';
import 'package:belts_test/home/components/custom_textfield_widget.dart';
import 'package:belts_test/home/components/step_button.dart';
import 'package:belts_test/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeStepper extends StatelessWidget {
  const HomeStepper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.l10n.homePageInstructionError),
            ),
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 200),
          child: Stepper(
            currentStep: state.index,
            onStepTapped: (int index) {
              context.read<HomeBloc>().add(OnStepStepper(index));
            },
            controlsBuilder: (context, ControlsDetails controlsDetails) {
              return Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  children: [
                    if (state.index >= 0 && state.index < 4) ...[
                      StepButton(
                        key: const Key('nextStep'),
                        icon: const Icon(
                          Icons.arrow_downward,
                          color: primaryColor,
                          size: 15,
                        ),
                        onTap: () =>
                            context.read<HomeBloc>().add(NextStepStepper()),
                      ),
                      const SizedBox(width: 20),
                    ],
                    if (state.index > 0) ...[
                      StepButton(
                        key: const Key('backStep'),
                        icon: const Icon(
                          Icons.arrow_upward,
                          color: primaryColor,
                          size: 15,
                        ),
                        onTap: () =>
                            context.read<HomeBloc>().add(BackStepStepper()),
                      ),
                    ],
                  ],
                ),
              );
            },
            steps: <Step>[
              _buildStep(
                state.index == 0,
                context.l10n.homePageStep1,
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    context.l10n.homePageStep1Text,
                    style: BeltsTheme.themeData.textTheme.subtitle1,
                  ),
                ),
              ),
              _buildStep(
                state.index == 1,
                context.l10n.homePageStep2,
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    context.l10n.homePageStep2Text,
                    style: BeltsTheme.themeData.textTheme.subtitle1,
                  ),
                ),
              ),
              _buildStep(
                state.index == 2,
                context.l10n.homePageStep3,
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    context.l10n.homePageStep3Text,
                    style: BeltsTheme.themeData.textTheme.subtitle1,
                  ),
                ),
              ),
              _buildStep(
                state.index == 3,
                context.l10n.homePageStep4,
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    context.l10n.homePageStep4Text,
                    style: BeltsTheme.themeData.textTheme.subtitle1,
                  ),
                ),
              ),
              _buildStep(
                state.index == 4,
                context.l10n.homePageStep5,
                Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.l10n.homePageStep5Text,
                        style: BeltsTheme.themeData.textTheme.subtitle1,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          CustomTextFieldWidget(
                            key: const Key('input_instructions'),
                            placeholder: 'FFRRFFFRL',
                            onChange: (value) => context.read<HomeBloc>().add(
                                  OnChangeInstruction(value),
                                ),
                          ),
                          const SizedBox(width: 30),
                          ElevatedButton(
                            key: const Key('send_button'),
                            onPressed: () => context.read<HomeBloc>().add(
                                  SendInstructions(),
                                ),
                            child: Text(
                              context.l10n.homePageStep5TextButton,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Step _buildStep(
    final bool _isActive,
    final String _title,
    final Widget _content,
  ) {
    return Step(
      isActive: _isActive,
      title: Text(
        _title,
        style: BeltsTheme.themeData.textTheme.headline2,
      ),
      content: _content,
    );
  }
}
