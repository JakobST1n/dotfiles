
    module.exports.decorateConfig = config => {
      return Object.assign({}, config, {
        cursorColor: 'rgba(80, 115, 184, 0.5)',
        foregroundColor: '#dedfdf',
        backgroundColor: '#23292d',
        borderColor: '#23292d',
        colors: {
          black: '#23292d',
          red: '#ef4e7c',
          green: '#6ebb82',
          yellow: '#f79532',
          blue: '#1299ad',
          magenta: '#a067ab',
          cyan: '#09b399',
          white: '#dedfdf',
          lightBlack: '#42474b',
          lightRed: '#f37055',
          lightGreen: '#6ebb82',
          lightYellow: '#f79532',
          lightBlue: '#1299ad',
          lightMagenta: '#a067ab',
          lightCyan: '#09b399',
          lightWhite: '#fdfdfd',
        },
      });
    };
  