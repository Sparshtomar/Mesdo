import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mesdo/routes/app_routes.dart';

class UploadResume extends StatefulWidget {
  const UploadResume({super.key});

  @override
  State<UploadResume> createState() => _UploadResumeState();
}

class _UploadResumeState extends State<UploadResume> {
  // PlatformFile? _selectedFile;
  // bool _fileTooLarge = false;

  // static const int maxFileSizeBytes = 50 * 1024 * 1024; // 50 MB

  // Future<void> _pickFile() async {
  //   final result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf', 'docx', 'doc'],
  //   );

  //   if (result != null && result.files.single.path != null) {
  //     final file = File(result.files.single.path!);
  //     final fileSize = await file.length();

  //     if (fileSize > maxFileSizeBytes) {
  //       setState(() {
  //         _fileTooLarge = true;
  //         _selectedFile = null;
  //       });
  //     } else {
  //       setState(() {
  //         _fileTooLarge = false;
  //         _selectedFile = result.files.single;
  //       });
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(30, 50, 30, 0),
            child: Column(
              children: [
                Text(
                  'Upload Resume',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 28.0,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Include all of your relevant experience and dates in this section',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0),
                ),
                SizedBox(height: 30),
                Container(
                  width: 317,
                  height: 378,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.grey[300]!, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Image.asset('assets/resume.png', height: 56, width: 51),
                        SizedBox(height: 12),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Click to Upload',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
                                ),
                                // recognizer:
                                //     TapGestureRecognizer()..onTap = _pickFile,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Maximum File Size - 50 MB',
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                        // if (_fileTooLarge)
                        //   Padding(
                        //     padding: const EdgeInsets.only(top: 10),
                        //     child: Text(
                        //       'File too large! Please upload a file smaller than 50 MB.',
                        //       style: TextStyle(color: Colors.red, fontSize: 12),
                        //       textAlign: TextAlign.center,
                        //     ),
                        //   ),
                        // if (_selectedFile != null && !_fileTooLarge)
                        //   Padding(
                        //     padding: const EdgeInsets.only(top: 10),
                        //     child: Text(
                        //       'Selected: ${_selectedFile!.name}',
                        //       style: TextStyle(
                        //         fontSize: 12,
                        //         color: Colors.black,
                        //       ),
                        //       textAlign: TextAlign.center,
                        //     ),
                        //   ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.PERSONAL_INFORAMATION);
                    // if (_selectedFile != null && !_fileTooLarge) {
                    //   // Proceed with next step (e.g. upload or continue)
                    //   print('Continue with file: ${_selectedFile!.path}');
                    // } else if (_fileTooLarge) {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(content: Text('File exceeds 50 MB limit')),
                    //   );
                    // } else {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(content: Text('Please upload a file first')),
                    //   );
                    // }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(324, 44),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text('Continue'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
