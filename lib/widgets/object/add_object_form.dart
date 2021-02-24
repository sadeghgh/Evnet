import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evnet_agents/helpers/location_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import '../pickers/user_image_list_picker.dart';
import 'package:evnet_agents/screens/map/map_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:location/location.dart';

class AddObjectForm extends StatefulWidget {
  AddObjectForm(
    this.submitFn,
    this.isLoading,
  );

  final bool isLoading;
  final void Function(
    String title,
    String type,
    String saleOrRent,
    List<File> images,
    String description,
    String floor,
    String adresss,
    String city,
    GeoPoint location,
    String size,
    String amountRooms,
    String price,
    String age,
    bool pool,
    BuildContext ctx,
  ) submitFn;

  @override
  _AddObjectFormState createState() => _AddObjectFormState();
}

class _AddObjectFormState extends State<AddObjectForm> {
  final _formKey = GlobalKey<FormState>();
  var _title = '';
  var _type = 'Villa';
  var _saleOrRent = 'Sale';
  var _description = '';
  var _floor = '';
  var _adress = '';
  var _size = '';
  var _amountRooms = '1+1';
  var _price = '';
  var _age = '';
  bool _pool = false;
  List<File> _userImageFiles;
  String _typeDropdownValue = 'Villa';
  String _saleOrRentDropdownValue = 'Sale';
  String _amountRoomsDropdownValue = '1+1';
  GeoPoint _locationConnectedToAdress;
  String _city;

  TextEditingController adressController = TextEditingController();

  Future<void> _getCurrentUserLocation() async {
    try {
      final locData = await Location().getLocation();
      _locationConnectedToAdress =
          GeoPoint(locData.latitude, locData.longitude);
      String foundAdress = await LocationHelper.getPlaceAddress(
          locData.latitude, locData.longitude);
      _city = LocationHelper.fetchCityFromAdress(foundAdress);
      setState(() {
        this.adressController.text = foundAdress;
      });
    } catch (error) {
      print(error.toString());
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(),
      ),
    );
    if (selectedLocation == null) {
      return;
    } else {
      final locData = selectedLocation;
      _locationConnectedToAdress =
          GeoPoint(locData.latitude, locData.longitude);
      String foundAdress = await LocationHelper.getPlaceAddress(
          locData.latitude, locData.longitude);
      _city = LocationHelper.fetchCityFromAdress(foundAdress);
      setState(() {
        this.adressController.text = foundAdress;
      });
    }
  }

  void _pickedImage(List<File> images, BuildContext ctx) {
    _userImageFiles = images;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    // if (_userImageFiles == null) {
    //   Scaffold.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text(AppLocalizations.of(context).pickImageWarningMessage),
    //       backgroundColor: Theme.of(context).errorColor,
    //     ),
    //   );
    //   return;
    // }

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
        _title.trim(),
        _type,
        _saleOrRent,
        _userImageFiles,
        _description.trim(),
        _floor.trim(),
        _adress,
        _city,
        _locationConnectedToAdress,
        _size,
        _amountRooms,
        _price,
        _age,
        _pool,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(2),
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
                  UserImageListPicker(_pickedImage),
                  TextFormField(
                    key: ValueKey('title'),
                    autocorrect: true,
                    textCapitalization: TextCapitalization.none,
                    enableSuggestions: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a title to the prperty.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: 2,
                    maxLength: 1000,
                    decoration: InputDecoration(
                      labelText: 'Title',
                    ),
                    onSaved: (value) {
                      _title = value;
                    },
                  ),
                  DropdownButton<String>(
                    value: _typeDropdownValue,
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
                        newValue != null
                            ? _type = _typeDropdownValue = newValue
                            : _type = _typeDropdownValue;
                      });
                    },
                    items: <String>['Villa', 'Appartment', 'Business', 'Land']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
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
                        newValue != null
                            ? _saleOrRent = _saleOrRentDropdownValue = newValue
                            : _saleOrRent = _saleOrRentDropdownValue;
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
                    key: ValueKey('description'),
                    keyboardType: TextInputType.multiline,
                    maxLines: 8,
                    maxLength: 1000,
                    autocorrect: true,
                    textCapitalization: TextCapitalization.words,
                    enableSuggestions: false,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a description of property';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Description'),
                    onSaved: (value) {
                      _description = value;
                    },
                  ),
                  TextFormField(
                    key: ValueKey('floor'),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Floor'),
                    obscureText: false,
                    onSaved: (value) {
                      _floor = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      FlatButton.icon(
                        icon: Icon(
                          Icons.location_on,
                        ),
                        label: Text('Current Location'),
                        textColor: Theme.of(context).primaryColor,
                        onPressed: _getCurrentUserLocation,
                      ),
                      FlatButton.icon(
                        icon: Icon(
                          Icons.map,
                        ),
                        label: Text('Select on Map'),
                        textColor: Theme.of(context).primaryColor,
                        onPressed: _selectOnMap,
                      ),
                    ],
                  ),
                  TextFormField(
                    key: ValueKey('adress'),
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    maxLength: 1000,
                    autocorrect: true,
                    readOnly: true,
                    textCapitalization: TextCapitalization.words,
                    enableSuggestions: false,
                    // enableInteractiveSelection: false,
                    // enabled: false,
                    // initialValue: this.defaultAdress,
                    controller: this.adressController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a adress';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Adress'),
                    onSaved: (value) {
                      _adress = value;
                    },
                  ),
                  TextFormField(
                    key: ValueKey('size'),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Size'),
                    obscureText: false,
                    onSaved: (value) {
                      _size = value;
                    },
                  ),
                  DropdownButton<String>(
                    value: _amountRoomsDropdownValue,
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
                        newValue != null
                            ? _amountRooms =
                                _amountRoomsDropdownValue = newValue
                            : _amountRooms = _amountRoomsDropdownValue;
                      });
                    },
                    items: <String>[
                      '1+1',
                      '2+1',
                      '3+1',
                      '4+1',
                      '5+1',
                      '6+1',
                      '7+1'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: _pool,
                        onChanged: (value) {
                          setState(() {
                            _pool = value;
                          });
                        },
                      ),
                      Text('Pool'),
                    ],
                  ),
                  TextFormField(
                    key: ValueKey('price'),
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(labelText: 'Price'),
                    obscureText: false,
                    onSaved: (value) {
                      _price = value;
                    },
                  ),
                  TextFormField(
                    key: ValueKey('age'),
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(labelText: 'Age'),
                    obscureText: false,
                    onSaved: (value) {
                      _age = value;
                    },
                  ),
                  SizedBox(height: 12),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    RaisedButton(
                      child: Text('Add Property'),
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
