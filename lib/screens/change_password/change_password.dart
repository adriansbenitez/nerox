import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/blocs/bloc.dart';
import 'package:listar_flutter_pro/utils/utils.dart';
import 'package:listar_flutter_pro/widgets/widget.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() {
    return _ChangePasswordState();
  }
}

class _ChangePasswordState extends State<ChangePassword> {

  final user = AppBloc.userCubit.state!;

  final _textCurrentPassController = TextEditingController();
  final _textNewPassController = TextEditingController();
  final _focusCurrentPass = FocusNode();
  final _focusNewPass = FocusNode();

  String? _errorCurrentPass;
  String? _errorNewPass;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textCurrentPassController.dispose();
    _textNewPassController.dispose();
    _focusCurrentPass.dispose();
    _focusNewPass.dispose();
    super.dispose();
  }

  ///On change password
  void _changePassword() async {
    UtilOther.hiddenKeyboard(context);
    setState(() {
      _errorCurrentPass = UtilValidator.validate(
        _textCurrentPassController.text,
      );
      _errorNewPass = UtilValidator.validate(
        _textNewPassController.text,
      );
    });
    if (_errorCurrentPass == null && _errorNewPass == null) {
      final result = await AppBloc.userCubit.onChangePassword(
        _textCurrentPassController.text,
        _textNewPassController.text,
          user.id
      );
      if (!mounted) return;
      if (result) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        title: Text(
          Translate.of(context).translate('change_password'),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  Translate.of(context).translate('password'),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                AppTextInput(
                  hintText: Translate.of(context).translate(
                    'input_your_password',
                  ),
                  errorText: _errorCurrentPass,
                  focusNode: _focusCurrentPass,
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  trailing: GestureDetector(
                    dragStartBehavior: DragStartBehavior.down,
                    onTap: () {
                      _textCurrentPassController.clear();
                    },
                    child: const Icon(Icons.clear),
                  ),
                  onSubmitted: (text) {
                    UtilOther.fieldFocusChange(
                      context,
                      _focusCurrentPass,
                      _focusNewPass,
                    );
                  },
                  onChanged: (text) {
                    setState(() {
                      _errorCurrentPass = UtilValidator.validate(
                        _textCurrentPassController.text,
                      );
                    });
                  },
                  controller: _textCurrentPassController,
                ),
                const SizedBox(height: 16),
                Text(
                  Translate.of(context).translate('confirm_password'),
                  maxLines: 1,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                AppTextInput(
                  hintText: Translate.of(context).translate(
                    'confirm_your_password',
                  ),
                  errorText: _errorNewPass,
                  focusNode: _focusNewPass,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  trailing: GestureDetector(
                    dragStartBehavior: DragStartBehavior.down,
                    onTap: () {
                      _textNewPassController.clear();
                    },
                    child: const Icon(Icons.clear),
                  ),
                  onSubmitted: (text) {
                    _changePassword();
                  },
                  onChanged: (text) {
                    setState(() {
                      _errorNewPass = UtilValidator.validate(
                        _textNewPassController.text,
                      );
                    });
                  },
                  controller: _textNewPassController,
                ),
                const SizedBox(height: 16),
                AppButton(
                  Translate.of(context).translate('update'),
                  mainAxisSize: MainAxisSize.max,
                  onPressed: _changePassword,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
