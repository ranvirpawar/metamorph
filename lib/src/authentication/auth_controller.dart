// // theme_constants.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'auth_service.dart';
//
//
//
// // auth_controller.dart
// class AuthController extends GetxController {
//   final AuthService _authService;
//   final UserService _userService;
//
//   final isLoading = false.obs;
//   final currentPage = 0.obs;
//   final phoneController = TextEditingController();
//   final otpController = TextEditingController();
//   final nameController = TextEditingController();
//
//   AuthController(this._authService, this._userService);
//
//   Future<void> sendOTP() async {
//     try {
//       isLoading.value = true;
//       await _authService.sendOTP(phoneController.text);
//       currentPage.value = 1;
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         e.toString(),
//         backgroundColor: MetamorphColors.error.withOpacity(0.1),
//         colorText: Colors.white,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> verifyOTP() async {
//     try {
//       isLoading.value = true;
//       await _authService.verifyOTP(otpController.text);
//       currentPage.value = 2;
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         e.toString(),
//         backgroundColor: MetamorphColors.error.withOpacity(0.1),
//         colorText: Colors.white,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> completeProfile() async {
//     try {
//       isLoading.value = true;
//       await _userService.createOrUpdateProfile(
//         name: nameController.text,
//       );
//       Get.offAllNamed('/home');
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         e.toString(),
//         backgroundColor: MetamorphColors.error.withOpacity(0.1),
//         colorText: Colors.white,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
//
// // auth_screen.dart
// class AuthScreen extends StatelessWidget {
//   final controller = Get.put(AuthController(
//     Get.find<AuthService>(),
//     Get.find<UserService>(),
//   ));
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: MetamorphColors.background,
//       body: Stack(
//         children: [
//           // Animated background pattern
//           Positioned.fill(
//             child: CustomPaint(
//               painter: BackgroundPatternPainter(),
//             ),
//           ),
//
//           // Main content
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(24.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // App logo and name
//                   const SizedBox(height: 40),
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.auto_awesome,
//                         size: 40,
//                         color: MetamorphColors.primary,
//                       ),
//                       const SizedBox(width: 12),
//                       Text(
//                         'Metamorph',
//                         style: TextStyle(
//                           fontSize: 32,
//                           fontWeight: FontWeight.bold,
//                           background: Paint()
//                             ..shader = LinearGradient(
//                               colors: [
//                                 MetamorphColors.gradientStart,
//                                 MetamorphColors.gradientEnd,
//                               ],
//                             ).createShader(
//                               Rect.fromLTWH(0, 0, 200, 70),
//                             ),
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 40),
//
//                   // Page content
//                   Expanded(
//                     child: PageView(
//                       controller: PageController(
//                         initialPage: controller.currentPage.value,
//                       ),
//                       physics: const NeverScrollableScrollPhysics(),
//                       children: [
//                         PhoneInputPage(),
//                         OTPVerificationPage(),
//                         ProfileCompletionPage(),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//           // Loading overlay
//           Obx(() {
//             if (controller.isLoading.value) {
//               return Container(
//                 color: Colors.black54,
//                 child: Center(
//                   child: LoadingIndicator(),
//                 ),
//               );
//             }
//             return const SizedBox();
//           }),
//         ],
//       ),
//     );
//   }
// }
//
// // phone_input_page.dart
// class PhoneInputPage extends GetView<AuthController> {
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedColumn(
//       children: [
//         Text(
//           'Welcome to Metamorph',
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         const SizedBox(height: 12),
//         Text(
//           'Enter your phone number to get started',
//           style: TextStyle(
//             fontSize: 16,
//             color: Colors.white70,
//           ),
//         ),
//         const SizedBox(height: 40),
//         CustomTextField(
//           controller: controller.phoneController,
//           hint: 'Phone Number',
//           prefix: CountryCodePicker(),
//           keyboardType: TextInputType.phone,
//         ),
//         const SizedBox(height: 24),
//         GradientButton(
//           onPressed: controller.sendOTP,
//           child: Text('Continue'),
//         ),
//       ],
//     );
//   }
// }
//
// // otp_verification_page.dart
// class OTPVerificationPage extends GetView<AuthController> {
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedColumn(
//       children: [
//         Text(
//           'Verify Your Number',
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         const SizedBox(height: 12),
//         Text(
//           'Enter the 6-digit code we sent to ${controller.phoneController.text}',
//           style: TextStyle(
//             fontSize: 16,
//             color: Colors.white70,
//           ),
//         ),
//         const SizedBox(height: 40),
//         PinCodeTextField(
//           controller: controller.otpController,
//           length: 6,
//           backgroundColor: Colors.transparent,
//           enableActiveFill: true,
//           animationType: AnimationType.scale,
//           pinTheme: PinTheme(
//             shape: PinCodeFieldShape.box,
//             borderRadius: BorderRadius.circular(8),
//             activeColor: MetamorphColors.primary,
//             selectedColor: MetamorphColors.secondary,
//             inactiveColor: Colors.white24,
//           ),
//         ),
//         const SizedBox(height: 24),
//         GradientButton(
//           onPressed: controller.verifyOTP,
//           child: Text('Verify'),
//         ),
//       ],
//     );
//   }
// }
//
// // profile_completion_page.dart
// class ProfileCompletionPage extends GetView<AuthController> {
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedColumn(
//       children: [
//         Text(
//           'Complete Your Profile',
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         const SizedBox(height: 12),
//         Text(
//           'Tell us a bit about yourself',
//           style: TextStyle(
//             fontSize: 16,
//             color: Colors.white70,
//           ),
//         ),
//         const SizedBox(height: 40),
//         AvatarPicker(),
//         const SizedBox(height: 24),
//         CustomTextField(
//           controller: controller.nameController,
//           hint: 'Full Name',
//           prefix: Icon(Icons.person_outline),
//         ),
//         const SizedBox(height: 24),
//         GradientButton(
//           onPressed: controller.completeProfile,
//           child: Text('Get Started'),
//         ),
//       ],
//     );
//   }
// }
//
// // Custom widgets
// class GradientButton extends StatelessWidget {
//   final VoidCallback onPressed;
//   final Widget child;
//
//   const GradientButton({
//     required this.onPressed,
//     required this.child,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: 56,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             MetamorphColors.gradientStart,
//             MetamorphColors.gradientEnd,
//           ],
//         ),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: MaterialButton(
//         onPressed: onPressed,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: DefaultTextStyle(
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//           ),
//           child: child,
//         ),
//       ),
//     );
//   }
// }
//
// class CustomTextField extends StatelessWidget {
//   final TextEditingController controller;
//   final String hint;
//   final Widget? prefix;
//   final TextInputType? keyboardType;
//
//   const CustomTextField({
//     required this.controller,
//     required this.hint,
//     this.prefix,
//     this.keyboardType,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: MetamorphColors.surface,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(
//           color: Colors.white12,
//           width: 1,
//         ),
//       ),
//       child: TextField(
//         controller: controller,
//         keyboardType: keyboardType,
//         style: TextStyle(color: Colors.white),
//         decoration: InputDecoration(
//           hintText: hint,
//           hintStyle: TextStyle(color: Colors.white38),
//           prefixIcon: prefix,
//           border: InputBorder.none,
//           contentPadding: EdgeInsets.symmetric(
//             horizontal: 20,
//             vertical: 16,
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class LoadingIndicator extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SpinKitDoubleBounce(
//       color: MetamorphColors.primary,
//       size: 50.0,
//     );
//   }
// }
//
// class AnimatedColumn extends StatelessWidget {
//   final List<Widget> children;
//
//   const AnimatedColumn({required this.children});
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: children.asMap().entries.map((entry) {
//           return AnimatedSlideAndFade(
//             delay: Duration(milliseconds: entry.key * 100),
//             child: entry.value,
//           );
//         }).toList(),
//       ),
//     );
//   }
// }