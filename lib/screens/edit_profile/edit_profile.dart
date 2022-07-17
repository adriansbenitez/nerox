import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:listar_flutter_pro/blocs/bloc.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/utils/utils.dart';
import 'package:listar_flutter_pro/widgets/widget.dart';

import '../../widgets/app_dropdown_item.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() {
    return _EditProfileState();
  }
}

class _EditProfileState extends State<EditProfile> {
  final _textNameController = TextEditingController();
  final _textLastNameController = TextEditingController();
  final _textEmailController = TextEditingController();
  final _textPhoneController = TextEditingController();
  final _textInfoController = TextEditingController();
  late String _genderSelected;


  final _focusName = FocusNode();
  final _focusLasName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPhone = FocusNode();
  final _focusInfo = FocusNode();
  final _focusGender = FocusNode();
  final picker = ImagePicker();

  ImageModel? _image;
  String? _errorName;
  String? _errorLastName;
  String? _errorEmail;
  String? _errorPhone;
  String? _errorInfo;

  final user = AppBloc.userCubit.state!;

  @override
  void initState() {
    super.initState();
    _textNameController.text = user.customerModel.nombre;
    _textLastNameController.text = user.customerModel.apellidos;
    _textEmailController.text = user.email;
    _textPhoneController.text = user.customerModel.mobile;
    _textInfoController.text = user.customerModel.notes;
    _genderSelected = user.customerModel.gender; //TODO internacionalizar;
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///On update image
  void _updateProfile() async {
    UtilOther.hiddenKeyboard(context);
    setState(() {
      _errorName = UtilValidator.validate(_textNameController.text);
      _errorLastName = UtilValidator.validate(_textLastNameController.text);
      _errorEmail = UtilValidator.validate(
        _textEmailController.text,
        type: ValidateType.email,
      );
      _errorPhone = UtilValidator.validate(_textPhoneController.text);
      _errorInfo = UtilValidator.validate(_textInfoController.text);
    });
    if (_errorName == null &&
        _errorLastName == null &&
        _errorEmail == null &&
        _errorPhone == null &&
        _errorInfo == null) {
      ///Fetch change profile
      final result = await AppBloc.userCubit.onUpdateUser(
        name: _textNameController.text,
        lastName: _textLastNameController.text,
        email: _textEmailController.text,
        phoneNumber: _textPhoneController.text,
        gender: _genderSelected,
        description: _textInfoController.text,
        id: user.customerModel.id
      );

      ///Case success
      if (result) {
        if (!mounted) return;
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(Translate.of(context).translate('edit_profile')),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: AppUploadImage(
                          type: UploadImageType.circle,
                          image: ImageModel(
                            id: 0,
                            full: AppBloc.userCubit.state!.profileImage,
                          ),
                          onChange: (result) {
                            setState(() {
                              _image = result;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    Translate.of(context).translate('name'),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  AppTextInput(
                    hintText: Translate.of(context).translate('input_name'),
                    errorText: _errorName,
                    focusNode: _focusName,
                    textInputAction: TextInputAction.next,
                    trailing: GestureDetector(
                      dragStartBehavior: DragStartBehavior.down,
                      onTap: () {
                        _textNameController.clear();
                      },
                      child: const Icon(Icons.clear),
                    ),
                    onSubmitted: (text) {
                      UtilOther.fieldFocusChange(
                        context,
                        _focusName,
                        _focusEmail,
                      );
                    },
                    onChanged: (text) {
                      setState(() {
                        _errorName = UtilValidator.validate(
                          _textNameController.text,
                        );
                      });
                    },
                    controller: _textNameController,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Apellidos', //TODO traducir
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  AppTextInput(
                    hintText: 'Apellidos', //TODO traducir
                    errorText: _errorLastName,
                    focusNode: _focusLasName,
                    textInputAction: TextInputAction.next,
                    trailing: GestureDetector(
                      dragStartBehavior: DragStartBehavior.down,
                      onTap: () {
                        _textLastNameController.clear();
                      },
                      child: const Icon(Icons.clear),
                    ),
                    onSubmitted: (text) {
                      UtilOther.fieldFocusChange(
                        context,
                        _focusName,
                        _focusEmail,
                      );
                    },
                    onChanged: (text) {
                      setState(() {
                        _errorLastName = UtilValidator.validate(
                          _textLastNameController.text,
                        );
                      });
                    },
                    controller: _textLastNameController,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    Translate.of(context).translate('email'),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  AppTextInput(
                    hintText: Translate.of(context).translate('input_email'),
                    errorText: _errorEmail,
                    focusNode: _focusEmail,
                    textInputAction: TextInputAction.next,
                    trailing: GestureDetector(
                      dragStartBehavior: DragStartBehavior.down,
                      onTap: () {
                        _textEmailController.clear();
                      },
                      child: const Icon(Icons.clear),
                    ),
                    onSubmitted: (text) {
                      UtilOther.fieldFocusChange(
                        context,
                        _focusEmail,
                        _focusPhone,
                      );
                    },
                    onChanged: (text) {
                      setState(() {
                        _errorEmail = UtilValidator.validate(
                          _textEmailController.text,
                          type: ValidateType.email,
                        );
                      });
                    },
                    controller: _textEmailController,
                    keyboardType: TextInputType.emailAddress,
                    enabled: false,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    Translate.of(context).translate('phone'),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  AppTextInput(
                    hintText: Translate.of(context).translate(
                      'input_phone',
                    ),
                    errorText: _errorPhone,
                    focusNode: _focusPhone,
                    textInputAction: TextInputAction.next,
                    trailing: GestureDetector(
                      dragStartBehavior: DragStartBehavior.down,
                      onTap: () {
                        _textPhoneController.clear();
                      },
                      child: const Icon(Icons.clear),
                    ),
                    onSubmitted: (text) {
                      UtilOther.fieldFocusChange(
                        context,
                        _focusPhone,
                        _focusInfo,
                      );
                    },
                    onChanged: (text) {
                      setState(() {
                        _errorPhone = UtilValidator.validate(
                          _textPhoneController.text,
                        );
                      });
                    },
                    controller: _textPhoneController,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Sexo',//TODO internacionalizar
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  AppDropdownItem(
                    selected: _genderSelected,
                    focusNode: _focusGender,
                    onSubmitted: (text) {
                      UtilOther.fieldFocusChange(
                        context,
                        _focusPhone,
                        _focusInfo,
                      );
                    },
                    onChanged: (newGender) {
                      setState(() {
                        _genderSelected = newGender!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    Translate.of(context).translate('information'),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  AppTextInput(
                    hintText: Translate.of(context).translate(
                      'input_information',
                    ),
                    errorText: _errorInfo,
                    focusNode: _focusInfo,
                    maxLines: 5,
                    trailing: GestureDetector(
                      dragStartBehavior: DragStartBehavior.down,
                      onTap: () {
                        _textInfoController.clear();
                      },
                      child: const Icon(Icons.clear),
                    ),
                    onSubmitted: (text) {
                      _updateProfile();
                    },
                    onChanged: (text) {
                      setState(() {
                        _errorInfo = UtilValidator.validate(
                          _textInfoController.text,
                        );
                      });
                    },
                    controller: _textInfoController,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: AppButton(
                Translate.of(context).translate('confirm'),
                mainAxisSize: MainAxisSize.max,
                onPressed: _updateProfile,
              ),
            )
          ],
        ),
      ),
    );
  }
}
