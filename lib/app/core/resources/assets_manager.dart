const String imagePath = "assets/images";
const String iconsPath = "assets/icons";
const String svgPath = "assets/svg";
const String filesPath="assets/files";
abstract class AssetsImage {
  static const String flower='$imagePath/Flower.png';
  static const String onBoaedingLogo ='$imagePath/onBoarding.png';

}

abstract class AssetsIcons {
  static const String logo = '$iconsPath/flower_logo.png';
  static const String dropIcon='$iconsPath/drop -down icon.png';
}

abstract class AssetsSvg {
  static const String logoSvg = '$svgPath/FloweryRiderSplash.svg';
}
abstract class AssetsFiles{
  static const String aboutAppFile='$filesPath/Flowery About Section JSON with Expanded Content.json';
  static const String termsFile='$filesPath/Flowery Terms and Conditions JSON with Arabic and English.json';
}