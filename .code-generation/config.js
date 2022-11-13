module.exports = {
  "SDKSpecVersion": "master",
  "langConfig": {
    lang: 'Dart',
    methodDelimiter: ' ..',
    groupDelimiter: '.',
    openQualifiersChar: '',
    closeQualifiersChar: '',
    closeTransformationChar: '',
    hideActionGroups: false,
    specialCharacterMapping: [
      ['$', '\$']
    ],
    openActionChar: '(',
    closeActionChar: ')',
    unsupportedTxParams: ['fl_waveform', 'e_anti_removal:', 'fl_animated', 'l_fetch', 'l_text', 'u_text', 'af_', 'if_', 'e_fade', '$overlaywidth_$mainvideowidth_div_3'],
    unsupportedSyntaxList: ['stroke(', 'textFit(', 'Animated.edit', 'RoundCorners(', 'getVideoFrame'],
    mainTransformationString: {
      openSyntaxString: {
        image: 'cloudinary.image("#publicID") ..transformation(Transformation()',
        video: 'cloudinary.video("#publicID")',
        media: 'cloudinary.asset("#publicID")'
      },
      closeSyntaxString : '));',
    },
    overwritePreset: 'dart',
    newInstanceSyntax: '#name(#req)#optional',
    arrayOpen: '[',
    arrayClose: ']',
    arraySeparator: ', ',
    formats: {
      formatClassOrEnum: 'PascalCase',
      formatMethod: 'camelCase',
      formatFloat: (f) => {
        if (!f.toString().includes('.')) {
          return `'${f}.0'` // In JS world, 1.0 is 1, so we make sure 1.0 stays 1.0
        } else {
          return f;
        }
      }
    },
    methodNameMap: {},
    classNameMap: {},
    childTransformations: {
      image: {
        open: 'Image1Transformation {',
        close: ' }',
      },
      video: {
        open: 'VideoTransformation {',
        close: ' }',
      },
      media: {
        open: 'Transformation {',
        close: ' }',
      }
    }
  },
  "overwrites": {
    qualifiers: {
      color_override: (payload) => {
        const {qualifierDTO} = payload;
        const colorName = qualifierDTO.qualifiers[0].name;
        const group = qualifierDTO.qualifiers[0].group;

        // TODO Color - this should be streamlined with how we deal with color.
        return `.colorOverride(Color.${colorName.toUpperCase()})`
      },
      quality_override: (payload) => {
        const {qualifierDTO} = payload;
        const qualityName = qualifierDTO.qualifiers[0].name;
        return `.qualityOverride(Quality.${qualityName})`
      }
    }
  }
}
