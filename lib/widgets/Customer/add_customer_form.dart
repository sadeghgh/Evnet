import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddCustomerForm extends StatefulWidget {
  AddCustomerForm(
    this.submitFn,
    this.isLoading,
  );

  final bool isLoading;
  final void Function(
    String saleOrRent,
    String email,
    String customerName,
    String phoneNr,
    BuildContext ctx,
  ) submitFn;

  @override
  _AddCustomerFormState createState() => _AddCustomerFormState();
}

class _AddCustomerFormState extends State<AddCustomerForm> {
  final _formKey = GlobalKey<FormState>();
  var _saleOrRent = '';
  var _userEmail = '';
  var _customerName = '';
  var _phoneNr = '';
  String _saleOrRentDropdownValue = 'Sale';

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
        _saleOrRent,
        _userEmail.trim(),
        _customerName.trim(),
        _phoneNr,
        context,
      );
      _formKey.currentState.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  DropdownButton<String>(
                    value: _saleOrRentDropdownValue,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    isExpanded: true,
                    style: Theme.of(context).textTheme.bodyText2,
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        _saleOrRentDropdownValue = _saleOrRent = newValue;
                      });
                    },
                    items: <String>['Sale', 'Rental']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  TextFormField(
                    key: ValueKey('customerName'),
                    autocorrect: true,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    enableSuggestions: false,
                    validator: (value) {
                      if (value.isEmpty) {
                        return AppLocalizations.of(context).nameWarningMessage;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).customerName,
                    ),
                    onSaved: (value) {
                      _customerName = value;
                    },
                  ),
                  // TextFormField(
                  //   key: ValueKey('userLastname'),
                  //   autocorrect: true,
                  //   textCapitalization: TextCapitalization.words,
                  //   enableSuggestions: false,
                  //   validator: (value) {
                  //     if (value.isEmpty) {
                  //       return AppLocalizations.of(context).nameWarningMessage;
                  //     }
                  //     return null;
                  //   },
                  //   decoration: InputDecoration(
                  //     labelText: AppLocalizations.of(context).lastName,
                  //   ),
                  //   onSaved: (value) {
                  //     _userLastName = value;
                  //   },
                  // ),
                  TextFormField(
                    key: ValueKey('email'),
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    enableSuggestions: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).email,
                    ),
                    onSaved: (value) {
                      _userEmail = value;
                    },
                  ),
                  IntlPhoneField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).phoneNr,
                    ),
                    initialCountryCode: 'TR',
                    onSaved: (value) {
                      _phoneNr = value.completeNumber;
                    },
                  ),
                  SizedBox(height: 12),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    RaisedButton(
                      child: Text(AppLocalizations.of(context).addCustomer),
                      onPressed: _trySubmit,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
