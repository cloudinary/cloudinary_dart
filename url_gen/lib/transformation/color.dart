import '../src/extensions/string_extension.dart';

class Color {
  String value;
  String? prefix;

  Color(this.value, {this.prefix});

  @override
  String toString() {
    if (prefix != null) {
      return '$prefix:$value';
    }
    return value;
  }

  String toStringWithPrefix(bool includedPrefix) {
    if (includedPrefix) {
      return toString();
    }
    return value;
  }

  static parseString(String color) {
    if (color.startsWith('#') || color.startsWith('rgb:')) {
      return rgb(color);
    } else {
      return named(color);
    }
  }

  static Color rgb(String hex) {
    return Color(hex.cldRemoveColorPrefixes(), prefix: 'rgb');
  }

  static Color named(String color) {
    return Color(color);
  }

  static Color snow() {
    return Color('snow');
  }

  static Color lightCoral() {
    return Color('lightcoral');
  }

  static Color rosybrown() {
    return Color('rosybrown');
  }

  static Color indianred() {
    return Color('indianred');
  }

  static Color red() {
    return Color('red');
  }

  static Color fireBrick() {
    return Color('firebrick');
  }

  static Color brown() {
    return Color('brown');
  }

  static Color darkred() {
    return Color('darkred');
  }

  static Color lightPink() {
    return Color('lightpink');
  }

  static Color pink() {
    return Color('pink');
  }

  static Color crimson() {
    return Color('crimson');
  }

  static Color palevioletred() {
    return Color('palevioletred');
  }

  static Color lavenderblush() {
    return Color('lavenderblush');
  }

  static Color maroon() {
    return Color('maroon');
  }

  static Color hotPink() {
    return Color('hotpink');
  }

  static Color deepPink() {
    return Color('deeppink');
  }

  static Color mediumVioletred() {
    return Color('mediumvioletred');
  }

  static Color violetred() {
    return Color('violetred');
  }

  static Color orchid() {
    return Color('orchid');
  }

  static Color plum() {
    return Color('plum');
  }

  static Color thistle() {
    return Color('thistle');
  }

  static Color violet() {
    return Color('violet');
  }

  static Color fuchsia() {
    return Color('fuchsia');
  }

  static Color magenta() {
    return Color('magenta');
  }

  static Color darkMagenta() {
    return Color('darkmagenta');
  }

  static Color purple() {
    return Color('purple');
  }

  static Color mediumOrchid() {
    return Color('mediumorchid');
  }

  static Color darkViolet() {
    return Color('darkviolet');
  }

  static Color darkOrchid() {
    return Color('darkorchid');
  }

  static Color indigo() {
    return Color('indigo');
  }

  static Color blueViolet() {
    return Color('blueviolet');
  }

  static Color mediumPurple() {
    return Color('mediumpurple');
  }

  static Color darkSlateBlue() {
    return Color('darkslateblue');
  }

  static Color lightSlateBlue() {
    return Color('lightslateblue');
  }

  static Color mediumSlateBlue() {
    return Color('mediumslateblue');
  }

  static Color slateBlue() {
    return Color('slateblue');
  }

  static Color ghostWhite() {
    return Color('ghostwhite');
  }

  static Color lavender() {
    return Color('lavender');
  }

  static Color blue() {
    return Color('blue');
  }

  static Color mediumBlue() {
    return Color('mediumblue');
  }

  static Color darkBlue() {
    return Color('darkblue');
  }

  static Color midnightBlue() {
    return Color('midnightblue');
  }

  static Color navy() {
    return Color('navy');
  }

  static Color navyBlue() {
    return Color('navyblue');
  }

  static Color royalBlue() {
    return Color('royalblue');
  }

  static Color cornflowerBlue() {
    return Color('cornflowerblue');
  }

  static Color lightSteelBlue() {
    return Color('lightsteelblue');
  }

  static Color lightSlateGray() {
    return Color('lightslategray');
  }

  static Color lightSlateGrey() {
    return Color('lightslategrey');
  }

  static Color slateGray() {
    return Color('slategray');
  }

  static Color slateGrey() {
    return Color('slategrey');
  }

  static Color dodgerBlue() {
    return Color('dodgerblue');
  }

  static Color aliceBlue() {
    return Color('aliceblue');
  }

  static Color steelBlue() {
    return Color('steelblue');
  }

  static Color lightSkyBlue() {
    return Color('lightskyblue');
  }

  static Color skyBlue() {
    return Color('skyblue');
  }

  static Color deepSkyBlue() {
    return Color('deepskyblue');
  }

  static Color lightBlue() {
    return Color('lightblue');
  }

  static Color powderBlue() {
    return Color('powderblue');
  }

  static Color cadetBlue() {
    return Color('cadetblue');
  }

  static Color darkTurquoise() {
    return Color('darkturquoise');
  }

  static Color azure() {
    return Color('azure');
  }

  static Color lightCyan() {
    return Color('lightcyan');
  }

  static Color paleTurquoise() {
    return Color('paleturquoise');
  }

  static Color aqua() {
    return Color('aqua');
  }

  static Color cyan() {
    return Color('cyan');
  }

  static Color darkCyan() {
    return Color('darkcyan');
  }

  static Color teal() {
    return Color('teal');
  }

  static Color darkSlateGray() {
    return Color('darkslategray');
  }

  static Color darkSlateGrey() {
    return Color('darkslategrey');
  }

  static Color mediumTurquoise() {
    return Color('mediumturquoise');
  }

  static Color lightSeaGreen() {
    return Color('lightseagreen');
  }

  static Color turquoise() {
    return Color('turquoise');
  }

  static Color aquamarine() {
    return Color('aquamarine');
  }

  static Color mediumAquamarine() {
    return Color('mediumaquamarine');
  }

  static Color mediumSpringGreen() {
    return Color('mediumspringgreen');
  }

  static Color mintCream() {
    return Color('mintcream');
  }

  static Color springGreen() {
    return Color('springgreen');
  }

  static Color mediumSeagreen() {
    return Color('mediumseagreen');
  }

  static Color seaGreen() {
    return Color('seagreen');
  }

  static Color mediumForestGreen() {
    return Color('mediumforestgreen');
  }

  static Color honeyDew() {
    return Color('honeydew');
  }

  static Color paleGreen() {
    return Color('palegreen');
  }

  static Color darkSeaGreen() {
    return Color('darkseagreen');
  }

  static Color lightGreen() {
    return Color('lightgreen');
  }

  static Color lime() {
    return Color('lime');
  }

  static Color limeGreen() {
    return Color('limegreen');
  }

  static Color green() {
    return Color('green');
  }

  static Color darkGreen() {
    return Color('darkgreen');
  }

  static Color lawnGreen() {
    return Color('lawngreen');
  }

  static Color chartreuse() {
    return Color('chartreuse');
  }

  static Color greenYellow() {
    return Color('greenyellow');
  }

  static Color darkOliveGreen() {
    return Color('darkolivegreen');
  }

  static Color oliveDrab() {
    return Color('olivedrab');
  }

  static Color yellowGreen() {
    return Color('yellowgreen');
  }

  static Color ivory() {
    return Color('ivory');
  }

  static Color lightYellow() {
    return Color('lightyellow');
  }

  static Color beige() {
    return Color('beige');
  }

  static Color yellow() {
    return Color('yellow');
  }

  static Color olive() {
    return Color('olive');
  }

  static Color darkKhaki() {
    return Color('darkkhaki');
  }

  static Color paleGoldenRod() {
    return Color('palegoldenrod');
  }

  static Color lemonChiffon() {
    return Color('lemonchiffon');
  }

  static Color khaki() {
    return Color('khaki');
  }

  static Color mediumGoldenRod() {
    return Color('mediumgoldenrod');
  }

  static Color gold() {
    return Color('gold');
  }

  static Color cornsilk() {
    return Color('cornsilk');
  }

  static Color lightGoldenRod() {
    return Color('lightgoldenrod');
  }

  static Color goldenRod() {
    return Color('goldenrod');
  }

  static Color darkGoldenRod() {
    return Color('darkgoldenrod');
  }

  static Color floralWhite() {
    return Color('floralwhite');
  }

  static Color oldLace() {
    return Color('oldlace');
  }

  static Color wheat() {
    return Color('wheat');
  }

  static Color orange() {
    return Color('orange');
  }

  static Color moccasin() {
    return Color('moccasin');
  }

  static Color papayaWhip() {
    return Color('papayawhip');
  }

  static Color blanchedAlmond() {
    return Color('blanchedalmond');
  }

  static Color navajoWhite() {
    return Color('navajowhite');
  }

  static Color antiqueWhite() {
    return Color('antiquewhite');
  }

  static Color tan() {
    return Color('tan');
  }

  static Color burlyWood() {
    return Color('burlywood');
  }

  static Color darkOrange() {
    return Color('darkorange');
  }

  static Color bisque() {
    return Color('bisque');
  }

  static Color linen() {
    return Color('linen');
  }

  static Color peru() {
    return Color('peru');
  }

  static Color peachPuff() {
    return Color('peachpuff');
  }

  static Color sandyBrown() {
    return Color('sandybrown');
  }

  static Color chocolate() {
    return Color('chocolate');
  }

  static Color saddlebrown() {
    return Color('saddlebrown');
  }

  static Color seaShell() {
    return Color('seashell');
  }

  static Color sienna() {
    return Color('sienna');
  }

  static Color lightSalmon() {
    return Color('lightsalmon');
  }

  static Color coral() {
    return Color('coral');
  }

  static Color darkSalmon() {
    return Color('darksalmon');
  }

  static Color orangered() {
    return Color('orangered');
  }

  static Color tomato() {
    return Color('tomato');
  }

  static Color mistyrose() {
    return Color('mistyrose');
  }

  static Color salmon() {
    return Color('salmon');
  }

  static Color white() {
    return Color('white');
  }

  static Color whiteSmoke() {
    return Color('whitesmoke');
  }

  static Color gainsboro() {
    return Color('gainsboro');
  }

  static Color lightGray() {
    return Color('lightgray');
  }

  static Color lightGrey() {
    return Color('lightgrey');
  }

  static Color silver() {
    return Color('silver');
  }

  static Color darkGray() {
    return Color('darkgray');
  }

  static Color darkGrey() {
    return Color('darkgrey');
  }

  static Color fractal() {
    return Color('fractal');
  }

  static Color gray() {
    return Color('gray');
  }

  static Color grey() {
    return Color('grey');
  }

  static Color dimGray() {
    return Color('dimgray');
  }

  static Color dimGrey() {
    return Color('dimgrey');
  }

  static Color opaque() {
    return Color('opaque');
  }

  static Color black() {
    return Color('black');
  }

  static Color none() {
    return Color('none');
  }

  static Color transparent() {
    return Color('transparent');
  }
}
