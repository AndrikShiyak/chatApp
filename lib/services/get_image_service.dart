import 'package:image_picker/image_picker.dart';

class GetImageService {
  GetImageService._();

  static final GetImageService _instance = GetImageService._();

  factory GetImageService() => _instance;

  final ImagePicker _imagePicker = ImagePicker();

  Future<XFile?> getImageFromGallery() {
    return _imagePicker.pickImage(source: ImageSource.gallery);
  }

  Future<XFile?> getImageFromCamera() {
    return _imagePicker.pickImage(source: ImageSource.camera);
  }
}
