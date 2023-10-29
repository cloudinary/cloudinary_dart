import 'package:cloudinary_url_gen/transformation/color.dart';
import 'package:cloudinary_url_gen/transformation/coordinates/coordinates.dart';
import 'package:cloudinary_url_gen/transformation/effect/effect.dart';
import 'package:cloudinary_url_gen/transformation/effect/effect_actions.dart';
import 'package:cloudinary_url_gen/transformation/effect/objects/foreground_object.dart';
import 'package:cloudinary_url_gen/transformation/gravity/gravity.dart';
import 'package:cloudinary_url_gen/transformation/region.dart';
import 'package:test/test.dart';

import '../tests_utils.dart';

void main() {
  test('Test successful sepia effect formatting', () {
    cldAssert('e_sepia', Effect.sepia());
    cldAssert("e_sepia:50", Effect.sepia(50));
  });

  test('Test successful accelerate effect formatting', () {
    cldAssert("e_accelerate", Effect.accelerate());
    cldAssert("e_accelerate:100", Effect.accelerate(100));
  });

  test('Test successful deshake effect formatting', () {
    cldAssert("e_deshake", Effect.deshake());
    cldAssert("e_deshake:16", Effect.deshake(ShakeStrength.pixels16()));
  });

  test('Test successful reverse effect formatting', () {
    cldAssert("e_reverse", Effect.reverse());
  });

  test('Test successful boomerang effect formatting', () {
    cldAssert("e_boomerang", Effect.boomerang());
  });
  test('Test successful noise effect formatting', () {
    cldAssert("e_noise", Effect.noise());
    cldAssert("e_noise:10", Effect.noise(10));
  });
  test('Test successful make transparent effect formatting', () {
    cldAssert("e_make_transparent", Effect.makeTransparent());
    cldAssert("e_make_transparent:50", Effect.makeTransparent(tolerance: 50));
    cldAssert("e_make_transparent:50", Effect.makeTransparent()..tolerance(50));
  });
  test('Test successful fade in effect formatting', () {
    cldAssert("e_fade", Effect.fadeIn());
    cldAssert("e_fade:2000", Effect.fadeIn(2000));
    cldAssert("e_fade:-2000", Effect.fadeOut(2000));
  });
  test('Test successful loop in effect formatting', () {
    cldAssert("e_loop", Effect.loop());
    cldAssert("e_loop:2", Effect.loop(2));
    cldAssert("e_loop:2", Effect.loop()..additionalIterations(2));
  });
  test('Test successful black white effect formatting', () {
    cldAssert("e_blackwhite", Effect.blackwhite());
    cldAssert("e_blackwhite:50", Effect.blackwhite(50));
    cldAssert("e_blackwhite:50", Effect.blackwhite()..threshold(50));
  });
  test('Test successful dither effect formatting', () {
    cldAssert("e_ordered_dither:0",
        Effect.dither(DitherObject.threshold1x1NonDither()));
  });
  test('Test successful vignette effect formatting', () {
    cldAssert("e_vignette", Effect.vignette());
    cldAssert("e_vignette:30", Effect.vignette(30));
    cldAssert("e_vignette:30", Effect.vignette()..strength(30));
  });
  test('Test successful simulate blind effect formatting', () {
    cldAssert("e_simulate_colorblind", Effect.simulateColorBlind());
    cldAssert("e_simulate_colorblind:deuteranopia",
        Effect.simulateColorBlind(SimulateColorBlindObject.deuteranopia()));
  });
  test('Test successful cartoonify effect formatting', () {
    cldAssert("e_cartoonify", Effect.cartoonify());
    cldAssert("e_cartoonify:20", Effect.cartoonify(lineStrength: 20));
    cldAssert(
        "e_cartoonify:20:60",
        Effect.cartoonify()
          ..lineStrength(20)
          ..colorReductionLevel(60));
    cldAssert("e_cartoonify:30:bw",
        Effect.cartoonify(lineStrength: 30, blackwhite: true));
    cldAssert(
        "e_cartoonify:30:bw",
        Effect.cartoonify()
          ..lineStrength(30)
          ..colorReductionLevel(60)
          ..blackwhite());
    cldAssert(
        "e_cartoonify:bw",
        Effect.cartoonify()
          ..colorReductionLevel(60)
          ..blackwhite());
  });
  test('Test successful shadow effect formatting', () {
    cldAssert("e_shadow", Effect.shadow());
    cldAssert("e_shadow:50", Effect.shadow(strength: 50));
    cldAssert("e_shadow:50", Effect.shadow()..strength(50));
    cldAssert(
        "co_green,e_shadow:50",
        Effect.shadow()
          ..strength(50)
          ..color(Color.green()));
    cldAssert(
        "co_green,e_shadow:50,x_20,y_-20",
        Effect.shadow()
          ..strength(50)
          ..color(Color.green())
          ..offsetX(20)
          ..offsetY(-20));
  });
  test('Test successful vectorize effect formatting', () {
    cldAssert("e_vectorize", Effect.vectorize());
    cldAssert(
        "e_vectorize:colors:15:detail:2:despeckle:0.5:paths:4:corners:5",
        Effect.vectorize()
          ..numOfColors(15)
          ..detailsLevel(2)
          ..despeckleLevel(0.5)
          ..paths(4)
          ..cornersLevel(5));
  });
  test('Test successful outline effect formatting', () {
    cldAssert("e_outline", Effect.outline());
    cldAssert("e_outline:inner_fill",
        Effect.outline()..mode(OutlineMode.innerFill()));
    cldAssert(
        "co_red,e_outline:inner_fill:5",
        Effect.outline()
          ..mode(OutlineMode.innerFill())
          ..width(5)
          ..color(Color.red()));

    cldAssert(
        "co_red,e_outline:inner_fill:5:200",
        Effect.outline()
          ..mode(OutlineMode.innerFill())
          ..blurLevel(200).width(5)
          ..color(Color.red()));
    cldAssert(
        "co_red,e_outline:inner_fill:5:200",
        Effect.outline()
          ..mode(OutlineMode.innerFill())
          ..blurLevel(200).width(5)
          ..colorWithString('red'));
  });
  test('Test successful artistic effect formatting', () {
    cldAssert(
        "e_art:al_dente", Effect.artisticFilter(ArtisticFilter.alDente()));
  });
  test('Test successful negate effect formatting', () {
    cldAssert("e_negate", Effect.negate());
  });
  test('Test successful redeye effect formatting', () {
    cldAssert("e_redeye", Effect.redEye());
  });
  test('Test successful grayscale effect formatting', () {
    cldAssert("e_grayscale", Effect.grayscale());
  });
  test('Test successful oil paint effect formatting', () {
    cldAssert("e_oil_paint", Effect.oilPaint());
    cldAssert("e_oil_paint:40", Effect.oilPaint(40));
    cldAssert("e_oil_paint:40", Effect.oilPaint()..strength(40));
  });
  test('Test successful advanced redeye effect formatting', () {
    cldAssert("e_adv_redeye", Effect.advancedRedEye());
  });
  test('Test successful pixelate effect formatting', () {
    cldAssert("e_pixelate", Effect.pixelate());
    cldAssert("e_pixelate:3", Effect.pixelate()..squareSize(3));
    cldAssert(
        "e_pixelate_region:20,h_40,w_40,x_20,y_20",
        Effect.pixelate()
          ..squareSize(20)
          ..region(Custom()
            ..x(20)
            ..y(20)
            ..width(40)
            ..height(40))); // {
    cldAssert("e_pixelate_faces", Effect.pixelate()..region(Faces()));
    cldAssert(
        "e_pixelate_faces:7",
        Effect.pixelate()
          ..squareSize(7)
          ..region(Faces()));
    cldAssert(
        "e_pixelate_region:7,g_ocr_text",
        Effect.pixelate()
          ..squareSize(7)
          ..region(OCR()));
  });
  test('Test successful blur effect formatting', () {
    cldAssert("e_blur", Effect.blur());
    // cldAssert("e_blur:100_div_2", Effect.blur { strength(Expression("100 / 2")) })
    cldAssert("e_blur:300", Effect.blur()..strength(300));
    cldAssert(
        "e_blur_region:200,h_40,w_40,x_10,y_20",
        Effect.blur()
          ..strength(200)
          ..region(Custom()
            ..x(10)
            ..y(20)
            ..width(40)
            ..height(40)));
    cldAssert("e_blur_faces", Effect.blur()..region(Faces()));
    cldAssert(
        "e_blur_faces:600",
        Effect.blur()
          ..region(Faces())
          ..strength(600));
    cldAssert(
        "e_blur_region:600,g_ocr_text",
        Effect.blur()
          ..region(OCR())
          ..strength(600));
  });
  test('Test successful colorize effect formatting', () {
    cldAssert("e_colorize", Effect.colorize());
    cldAssert("e_colorize:80", Effect.colorize()..level(80));
    cldAssert("co_blue,e_colorize:80",
        Effect.colorize(level: 80)..color(Color.blue()));
  });
  test('Test successful gradient fade effect formatting', () {
    cldAssert('e_gradient_fade:100', Effect.gradientFade()..strength(100));
  });
  test('Test successful assist color blind effect formatting', () {
    cldAssert("e_assist_colorblind", Effect.assistColorBlind());
    cldAssert(
        "e_assist_colorblind:8", Effect.assistColorBlind()..stripesStrength(8));
    cldAssert("e_assist_colorblind:xray", Effect.assistColorBlind()..xray());
    // cldAssert(
    //     "e_assist_colorblind:\$var1",
    //     Effect.assistColorBlind { stripesStrength("\$var1") })
  });
  test('Test successful theme effect formatting', () {
    cldAssert("e_theme:color_black", Effect.theme(Color.black()));
    cldAssert("e_theme:color_black:photosensitivity_30",
        Effect.theme(Color.black())..photosensitivity(30));
  });
  test('Test successful remove background effect formatting', () {
    cldAssert("e_bgremoval", Effect.removeBackground());

    cldAssert("e_bgremoval:screen", Effect.removeBackground()..screen(true));
    cldAssert("e_bgremoval:red",
        Effect.removeBackground()..colorToRemove(Color.red()));
    cldAssert(
        "e_bgremoval:screen:red",
        Effect.removeBackground()
          ..screen(true)
          ..colorToRemove(Color.red()));
  });
  test('Test successful drop shadow effect formatting', () {
    cldAssert('e_dropshadow', Effect.dropShadow());
    cldAssert('e_dropshadow:elevation_11', Effect.dropShadow(elevation: 11));
    cldAssert('e_dropshadow:azimuth_10;elevation_11;spread_12',
        Effect.dropShadow(azimuth: 10, elevation: 11, spread: 12));
    cldAssert(
        'e_dropshadow:azimuth_10;elevation_11;spread_12',
        Effect.dropShadow()
          ..spread(12)
          ..elevation(11)
          ..azimuth(10));
  });

  test('Test successful background removal effect', () {
    cldAssert('e_background_removal', Effect.backgroundRemoval());
    cldAssert('e_background_removal:fineedges_y',
        Effect.backgroundRemoval(fineEdges: true));
    cldAssert('e_background_removal:fineedges_n',
        Effect.backgroundRemoval(fineEdges: false));
    cldAssert(
        'e_background_removal:hints_(cat;dog)',
        Effect.backgroundRemoval(
            hints: [ForegroundObject.cat(), ForegroundObject.dog()]));
    cldAssert(
        'e_background_removal:hints_(cat;dog)',
        Effect.backgroundRemoval()
          ..hints([ForegroundObject.cat(), ForegroundObject.dog()]));
    cldAssert(
        'e_background_removal:hints_(car;bus)',
        Effect.backgroundRemoval(
            hints: [ForegroundObject.car(), ForegroundObject.bus()]));
    cldAssert(
        'e_background_removal:fineedges_y:hints_(car;bus)',
        Effect.backgroundRemoval()
          ..fineEdges(true)
          ..hints([ForegroundObject.car(), ForegroundObject.bus()]));
  });

  test('Test successful zoompan effect', () {
    cldAssert('e_zoompan', Effect.zoomPan());
    cldAssert('e_zoompan:mode_ztc',
        Effect.zoomPan(mode: ZoomPanMode.zoomInToCenter()));
    cldAssert('e_zoompan:maxzoom_3', Effect.zoomPan(maxZoom: 3));
    cldAssert('e_zoompan:du_3', Effect.zoomPan(duration: 3));
    cldAssert(
        'e_zoompan:mode_ztc;from(g_auto;x_13)',
        Effect.zoomPan(mode: ZoomPanMode.zoomInToCenter())
            .from(ZoomPanArea(gravity: Gravity.autoGravity(), x: 13)));
  });

  test('Test successful generative recolor effect', () {
    cldAssert('e_gen_recolor:prompt_(sweater;dog;earring)',
        Effect.generativeRecolor(['sweater', 'dog', 'earring']));
    cldAssert(
        'e_gen_recolor:prompt_(sweater;dog;earring);to-color_5632a8',
        Effect.generativeRecolor(['sweater', 'dog', 'earring'])
            .toColor('5632a8'));
    cldAssert(
        'e_gen_recolor:prompt_(sweater;dog;earring);to-color_red',
        Effect.generativeRecolor(['sweater', 'dog', 'earring'],
            toColor: Color.red()));
    cldAssert(
        'e_gen_recolor:prompt_(sweater;dog;earring);multiple_true;to-color_red',
        Effect.generativeRecolor(['sweater', 'dog', 'earring'],
            multiple: true, toColor: Color.red()));
  });

  test('Test successful generative remove effect', () {
    cldAssert('e_gen_remove:prompt_(dog)', Effect.generativeRemove('dog'));
    cldAssert('e_gen_remove:prompt_(dog;cat;horse)',
        Effect.generativeRemove(['dog', 'cat', 'horse']));
    cldAssert('e_gen_remove:prompt_(dog);multiple_true',
        Effect.generativeRemove('dog', multiple: true));
    cldAssert('e_gen_remove:prompt_(dog);region_(x_10;y_10;w_10;h_10)',
        Effect.generativeRemove('dog', region: Rectangle(10, 10, 10, 10)));
    cldAssert(
        'e_gen_remove:prompt_(dog);region_(x_10;y_10;w_10;h_10);(x_20;y_20;w_20;h_20)',
        Effect.generativeRemove('dog',
            region: [Rectangle(10, 10, 10, 10), Rectangle(20, 20, 20, 20)]));
  });
}
