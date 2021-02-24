import 'dart:io';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';

class UserImageListPicker extends StatefulWidget {
  UserImageListPicker(this.imagePickFn);

  final void Function(List<File> pickedImageList, BuildContext ctx) imagePickFn;

  @override
  _UserImageListPickerState createState() => _UserImageListPickerState();
}

class _UserImageListPickerState extends State<UserImageListPicker> {
  // @override
  // void initState() {
  //   super.initState();
  // }
  List<Asset> images = List<Asset>();
  List<File> _files;
  String _error = 'No Error Dectected';

  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    if (images != null) {
      return GridView.count(
        crossAxisCount: 3,
        children: List.generate(images.length, (index) {
          Asset asset = images[index];
          return AssetThumb(
            asset: asset,
            width: 300,
            height: 300,
          );
        }),
      );
    }
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 35,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Please select your pictures",
          allViewTitle: "All Photos",
          useDetailsView: false,
          textOnNothingSelected: "No picture selected!",
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
      return;
    }
    if (resultList != null) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).pickImageSuccessfullyMsg),
          backgroundColor: Theme.of(context).accentColor,
          // duration: const Duration(seconds: 5),
        ),
      );
    } else {
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    List<File> files = [];
    for (Asset asset in resultList) {
      final filePath =
          await FlutterAbsolutePath.getAbsolutePath(asset.identifier);
      files.add(File(filePath));
    }
    setState(() {
      images = resultList;
      _files = files;
      _error = error;
    });
    widget.imagePickFn(_files, context);
  }

  // Future<String> getPathFromAsset(String identifier) async {
  //   String filePath = await FlutterAbsolutePath.getAbsolutePath(identifier);
  //   return filePath;
  // }

  // var _pickedImageList = <PickedFile>[];

  // void _pickImage() async {
  //   final pickedImageFile = await ImagePicker().getImage(
  //     source: ImageSource.gallery,
  //     imageQuality: 100,
  //     // maxWidth: 150,
  //   );
  //   if (pickedImageFile != null) {
  //     Scaffold.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(AppLocalizations.of(context).pickImageSuccessfullyMsg),
  //         backgroundColor: Theme.of(context).accentColor,
  //         // duration: const Duration(seconds: 5),
  //       ),
  //     );
  //   } else {
  //     return;
  //   }
  //   setState(() {
  //     _pickedImageList.add(pickedImageFile);
  //   });
  //   widget.imagePickFn(_pickedImageList, context);
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: _files != null ? FileImage(_files.last) : null,
        ),
        // ClipRRect(
        //   borderRadius:
        //       BorderRadius.all(Radius.circular(10.0)), //add border radius here
        //   child: _files != null
        //       ? Image.file(_files.last, width: 1000)
        //       : null, //add image location here
        // ),
        FlatButton.icon(
          textColor: Theme.of(context).primaryColor,
          onPressed: loadAssets,
          icon: const Icon(Icons.image),
          label: _files != null && _files.length < 1
              ? Text(AppLocalizations.of(context).addImage)
              : Text("Add more Image (" + images.length.toString() + ")"),
        ),
      ],
    );
  }
}
