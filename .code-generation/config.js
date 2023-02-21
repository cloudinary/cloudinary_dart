module.exports = {
  "SDKSpecVersion": "master",
  "langConfig": {
    lang: 'Dart',
    newInstanceSyntax: '#name(#req)#optional',
    methodDelimiter: '.',
    groupDelimiter: '.',
    openQualifiersChar: '',
    closeQualifiersChar: '',
    closeTransformationChar: '',
    hideActionGroups: false,
    unsupportedTxParams: ['fl_waveform', 'e_anti_removal:', 'fl_animated', 'l_fetch', 'l_text', 'u_text', 'af_', 'if_', 'e_fade', '$overlaywidth_$mainvideowidth_div_3'],
    unsupportedSyntaxList: ['stroke(', 'textFit(', 'Animated.edit', 'getVideoFrame'],
    mainTransformationString: {
      openSyntaxString: {
        image: 'cloudinary.image(\'#publicID\').transformation(Transformation()',
        video: 'cloudinary.video(\'#publicID\').transformation(Transformation()',
        media: 'cloudinary.media(\'#publicID\').transformation(Transformation()'
      },
      closeSyntaxString : ');',
    },
    overwritePreset: 'dart',
    openActionChar: '(',
    closeActionChar: ')',
    arraySeparator: ', ',
    arrayOpen: '[',
    arrayClose: ']',
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
    methodNameMap: {
      'delivery_type': 'set_delivery_type',
      'asset_type': 'set_asset_type',
      'deliveryType': 'set_delivery_type',
      'assetType': 'set_asset_type',
      'signature': 'setSignature',
    },
    canGenerateSignature:false,
    classNameMap: {},
    childTransformations: {
      image: {
        open: "new ImageTransformation()",
        close: '',
      },
      video: {
        open: "new VideoTransformation()",
        close: '',
      },
      media: {
        open: "new Transformation()",
        close: '',
      }
    },
  },
  "overwrites": {
    qualifiers: {
      // colorOverride is a qualifier of Reshape.trim action.
      color_override: (payload) => {
        const {qualifierDTO} = payload;
        const colorName = qualifierDTO.qualifiers[0].name;

        // TODO this should be streamlined with how we deal with color.
        return `.colorOverride("${colorName}")`
      },

    }
  }
}
