// part of 'utilities.dart';

// extension FigmaDimention on double {
//   double toFigmaHeight(double fontSize) {
//     return this / fontSize;
//   }
// }


// class TStyle {
//   static TextStyle titleOnBoarding = TextStyle(
//       fontWeight: FontWeight.w700,
//       fontSize: 40,
//       color: kColorNeutral700,
//       height: 48.0.toFigmaHeight(40));

// //OVERLINE
//   static TextStyle overline12Regular = TextStyle(
//       fontWeight: FontWeight.w400,
//       fontSize: 12,
//       color: kColorNeutral700,
//       height: 20.0.toFigmaHeight(12));
//   static TextStyle overline12Medium = TextStyle(
//       fontWeight: FontWeight.w500,
//       fontSize: 12,
//       color: kColorNeutral700,
//       height: 20.0.toFigmaHeight(12));
//   static TextStyle overline12SemiBold = TextStyle(
//       fontWeight: FontWeight.w600,
//       fontSize: 12,
//       color: kColorNeutral700,
//       height: 20.0.toFigmaHeight(12));

//   //PARAGRAPH SMALL
//   static TextStyle paragraphSmallRegular = TextStyle(
//       fontWeight: FontWeight.w400,
//       fontSize: 14,
//       color: kColorNeutral700,
//       height: 20.0.toFigmaHeight(14));
//   static TextStyle paragraphSmallMedium = TextStyle(
//       fontWeight: FontWeight.w500,
//       fontSize: 14,
//       color: kColorNeutral700,
//       height: 20.0.toFigmaHeight(14));
//   static TextStyle paragraphSmallSemiBold = TextStyle(
//       fontWeight: FontWeight.w600,
//       fontSize: 14,
//       color: kColorNeutral700,
//       height: 20.0.toFigmaHeight(14));

//   //PARAGRAPH  XSMALL
//   static TextStyle paragraphXSmallRegular = TextStyle(
//       fontWeight: FontWeight.w400,
//       fontSize: 12,
//       color: kColorNeutral700,
//       height: 20.0.toFigmaHeight(12));
//   static TextStyle paragraphXSmallMedium = TextStyle(
//       fontWeight: FontWeight.w500,
//       fontSize: 12,
//       color: kColorNeutral700,
//       height: 20.0.toFigmaHeight(12));
//   static TextStyle paragraphXSmallSemiBold = TextStyle(
//       fontWeight: FontWeight.w600,
//       fontSize: 12,
//       color: kColorNeutral700,
//       height: 20.0.toFigmaHeight(12));

// //PARAGRAPH MEDIUM
//   static TextStyle paragraphMediumRegular = TextStyle(
//       fontWeight: FontWeight.w400,
//       fontSize: 16,
//       color: kColorNeutral700,
//       height: 24.0.toFigmaHeight(16));
//   static TextStyle paragraphMediumMedium = TextStyle(
//       fontWeight: FontWeight.w500,
//       fontSize: 16,
//       color: kColorNeutral700,
//       height: 24.0.toFigmaHeight(16));
//   static TextStyle paragraphMediumSemiBold = TextStyle(
//       fontWeight: FontWeight.w600,
//       fontSize: 16,
//       color: kColorNeutral700,
//       height: 24.0.toFigmaHeight(16));

//   //PARAGRAPH LARGE
//   static TextStyle paragraphLargeRegular = TextStyle(
//       fontWeight: FontWeight.w400,
//       fontSize: 16,
//       color: kColorNeutral700,
//       height: 24.0.toFigmaHeight(16));
//   static TextStyle paragraphLargeMedium = TextStyle(
//       fontWeight: FontWeight.w500,
//       fontSize: 16,
//       color: kColorNeutral700,
//       height: 24.0.toFigmaHeight(16));
//   static TextStyle paragraphLargeSemiBold = TextStyle(
//       fontWeight: FontWeight.w600,
//       fontSize: 16,
//       color: kColorNeutral700,
//       height: 24.0.toFigmaHeight(16));

//   //MOBILE HEADING 5
//   static TextStyle mobileHeading5Regular = TextStyle(
//       fontWeight: FontWeight.w400,
//       fontSize: 20,
//       color: kColorNeutral700,
//       height: 28.0.toFigmaHeight(20));
//   static TextStyle mobileHeading5Medium = TextStyle(
//       fontWeight: FontWeight.w500,
//       fontSize: 20,
//       color: kColorNeutral700,
//       height: 28.0.toFigmaHeight(20));
//   static TextStyle mobileHeading5SemiBold = TextStyle(
//       fontWeight: FontWeight.w600,
//       fontSize: 20,
//       color: kColorNeutral700,
//       height: 28.0.toFigmaHeight(20));
//   static TextStyle mobileHeading5Bold = TextStyle(
//       fontWeight: FontWeight.w700,
//       fontSize: 20,
//       color: kColorNeutral700,
//       height: 28.0.toFigmaHeight(20));

//   //DESKTOP HEADING 2
//   static TextStyle desktopHeading2Regular = TextStyle(
//       fontWeight: FontWeight.w400,
//       fontSize: 36,
//       color: kColorNeutral700,
//       height: 44.0.toFigmaHeight(36));
//   static TextStyle desktopHeading2Medium = TextStyle(
//       fontWeight: FontWeight.w500,
//       fontSize: 36,
//       color: kColorNeutral700,
//       height: 44.0.toFigmaHeight(36));
//   static TextStyle desktopHeading2SemiBold = TextStyle(
//       fontWeight: FontWeight.w600,
//       fontSize: 36,
//       color: kColorNeutral700,
//       height: 44.0.toFigmaHeight(36));
//   static TextStyle desktopHeading2Bold = TextStyle(
//       fontWeight: FontWeight.w700,
//       fontSize: 36,
//       color: kColorNeutral700,
//       height: 44.0.toFigmaHeight(36));

//   //DESKTOP HEADING 5
//   static TextStyle desktopHeading5Regular = TextStyle(
//       fontWeight: FontWeight.w400,
//       fontSize: 24,
//       color: const Color(0xFF404040),
//       height: 32.0.toFigmaHeight(24));
//   static TextStyle desktopHeading5Medium = TextStyle(
//       fontWeight: FontWeight.w500,
//       fontSize: 24,
//       color: kColorNeutral700,
//       height: 32.0.toFigmaHeight(24));
//   static TextStyle desktopHeading5SemiBold = TextStyle(
//       fontWeight: FontWeight.w600,
//       fontSize: 24,
//       color: kColorNeutral700,
//       height: 32.0.toFigmaHeight(24));
//   static TextStyle desktopHeading5Bold = TextStyle(
//       fontWeight: FontWeight.w700,
//       fontSize: 24,
//       color: kColorNeutral700,
//       height: 32.0.toFigmaHeight(24));

//   //DESKTOP HEADING 6
//   static TextStyle desktopHeading6Regular = TextStyle(
//       fontWeight: FontWeight.w400,
//       fontSize: 20,
//       color: const Color(0xFF404040),
//       height: 28.0.toFigmaHeight(20));
//   static TextStyle desktopHeading6Medium = TextStyle(
//       fontWeight: FontWeight.w500,
//       fontSize: 20,
//       color: kColorNeutral700,
//       height: 28.0.toFigmaHeight(20));
//   static TextStyle desktopHeading6SemiBold = TextStyle(
//       fontWeight: FontWeight.w600,
//       fontSize: 20,
//       color: kColorNeutral700,
//       height: 28.0.toFigmaHeight(20));
//   static TextStyle desktopHeading6Bold = TextStyle(
//       fontWeight: FontWeight.w700,
//       fontSize: 20,
//       color: kColorNeutral700,
//       height: 28.0.toFigmaHeight(20));
// }
