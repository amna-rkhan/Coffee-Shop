import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:finalboss/core/providers/coffee_provider.dart';
import 'package:finalboss/core/features/presentation/pages/size_ext.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _philosophyController;
  Uint8List? _selectedImageBytes;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<CoffeeProvider>(context, listen: false);
    _nameController = TextEditingController(text: provider.userName);
    _emailController = TextEditingController(text: provider.userEmail);
    _phoneController = TextEditingController(text: provider.userPhone);
    _philosophyController = TextEditingController(text: provider.userPhilosophy);
    _selectedImageBytes = provider.profileImageBytes;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _philosophyController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    
    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() {
        _selectedImageBytes = bytes;
      });
    }
  }

  void _saveProfile() {
    context.read<CoffeeProvider>().updateProfile(
      name: _nameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      philosophy: _philosophyController.text,
      imageBytes: _selectedImageBytes,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile updated successfully!', style: TextStyle(fontFamily: 'Sora')), 
        backgroundColor: Color(0xFFC67C4E),
        behavior: SnackBarBehavior.floating,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131313),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Edit Profile",
          style: TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.bold, 
            fontSize: 5.w(context), 
            fontFamily: 'Sora'
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 6.w(context)),
        child: Column(
          children: [
            SizedBox(height: 3.h(context)),
            _buildPhotoSection(context),
            SizedBox(height: 5.h(context)),
            _buildInputField(context, "FULL NAME", _nameController, Icons.person_outline),
            SizedBox(height: 2.5.h(context)),
            _buildInputField(context, "EMAIL ADDRESS", _emailController, Icons.email_outlined),
            SizedBox(height: 2.5.h(context)),
            _buildInputField(context, "PHONE NUMBER", _phoneController, Icons.phone_outlined),
            SizedBox(height: 2.5.h(context)),
            _buildInputField(context, "COFFEE PHILOSOPHY", _philosophyController, Icons.history_edu_outlined, isTextArea: true),
            SizedBox(height: 6.h(context)),
            _buildSaveButton(context),
            SizedBox(height: 4.h(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoSection(BuildContext context) {
    final double size = 30.w(context);
    // Calculate cache size based on device pixel ratio for maximum crispness
    final int cacheSize = (size * MediaQuery.of(context).devicePixelRatio).round();

    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFC67C4E), width: 2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: SizedBox(
                  width: size,
                  height: size,
                  child: _selectedImageBytes != null
                      ? Image.memory(
                          _selectedImageBytes!, 
                          fit: BoxFit.cover,
                          cacheWidth: cacheSize,
                          cacheHeight: cacheSize,
                          filterQuality: FilterQuality.high,
                          isAntiAlias: true,
                        )
                      : Image.asset(
                          'asset/images/user.png', 
                          fit: BoxFit.cover,
                          cacheWidth: cacheSize,
                          cacheHeight: cacheSize,
                          filterQuality: FilterQuality.high,
                          errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, size: 50, color: Colors.white24),
                        ),
                ),
              ),
            ),
            Positioned(
              bottom: 0, right: 5,
              child: GestureDetector(
                onTap: _pickImage,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Color(0xFFC67C4E),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        const Text(
          "Tap to change profile picture", 
          style: TextStyle(color: Colors.white60, fontSize: 13, fontFamily: 'Sora')
        ),
      ],
    );
  }

  Widget _buildInputField(BuildContext context, String label, TextEditingController controller, IconData icon, {bool isTextArea = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
          child: Text(
            label, 
            style: const TextStyle(
              color: Color(0xFFC67C4E), 
              fontSize: 11, 
              fontWeight: FontWeight.bold, 
              letterSpacing: 1.2,
              fontFamily: 'Sora'
            )
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: const Color(0xFF2F2D2C),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white10),
          ),
          child: TextField(
            controller: controller,
            maxLines: isTextArea ? 3 : 1,
            style: const TextStyle(fontSize: 15, fontFamily: 'Sora', color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              icon: Icon(icon, color: Colors.white38, size: 20),
              hintStyle: const TextStyle(color: Colors.white24),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 62,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFC67C4E),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        onPressed: _saveProfile,
        child: const Text(
          "Save Changes",
          style: TextStyle(
            color: Colors.white, 
            fontSize: 16, 
            fontWeight: FontWeight.bold, 
            fontFamily: 'Sora'
          ),
        ),
      ),
    );
  }
}
