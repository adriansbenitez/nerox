import 'package:flutter/material.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:listar_flutter_pro/blocs/bloc.dart';
import 'package:listar_flutter_pro/configs/config.dart';
import 'package:listar_flutter_pro/utils/utils.dart';

class Intro extends StatefulWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  _IntroState createState() {
    return _IntroState();
  }
}

class _IntroState extends State<Intro> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///On complete preview intro
  void _onCompleted() {
    AppBloc.applicationCubit.onCompletedIntro();
  }

  @override
  Widget build(BuildContext context) {
    ///List Intro view page model
    final List<PageViewModel> pages = [
      PageViewModel(
        pageColor:const Color(0xff1c4c72),
        bubble: const Icon(
          Icons.schedule,
          color: Colors.white,
        ),
        body: Text(
          Translate.of(context).translate('appointment_description'),
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Colors.white,
              ),
        ),
        title: Text(
          Translate.of(context).translate('appointment'),
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: Colors.white),
        ),
        mainImage: Image.asset(
          Images.intro1,
          fit: BoxFit.contain,
        ),
      ),
      PageViewModel(
        pageColor: const Color(0xff1c4c72),
        bubble: const Icon(
          Icons.punch_clock,
          color: Colors.white,
        ),
        body: Text(
          Translate.of(context).translate('reminder_description'),
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.white),
        ),
        title: Text(
          Translate.of(context).translate('reminder'),
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: Colors.white),
        ),
        mainImage: Image.asset(
          Images.intro2,
          fit: BoxFit.contain,
        ),
      ),
      PageViewModel(
        pageColor: const Color(0xff1c4c72),
        bubble: const Icon(
          Icons.integration_instructions,
          color: Colors.white,
        ),
        body: Text(
          Translate.of(context).translate('integration_description'),
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.white),
        ),
        title: Text(
          Translate.of(context).translate('integration'),
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: Colors.white),
        ),
        mainImage: Image.asset(
          Images.intro3,
          fit: BoxFit.contain,
        ),
      ),
    ];

    ///Build Page
    return Scaffold(
      body: IntroViewsFlutter(
        pages,
        onTapSkipButton: _onCompleted,
        onTapDoneButton: _onCompleted,
        doneText: Text(Translate.of(context).translate('done')),
        nextText: Text(Translate.of(context).translate('next')),
        skipText: Text(Translate.of(context).translate('skip')),
        backText: Text(Translate.of(context).translate('back')),
        pageButtonTextStyles: Theme.of(context).textTheme.button!.copyWith(
              color: Colors.white,
            ),
      ),
    );
  }
}
