'use strict';

process.env.EMBROIDER_REBUILD_ADDONS = '@docfy/ember';

const EmberApp = require('ember-cli/lib/broccoli/ember-app');
const path = require('path');
const env = EmberApp.env();

const IS_PRODUCTION = env === 'production';

module.exports = function (defaults) {
  let postcssPlugins = [
    {
      module: require('postcss-import'),
      options: {
        path: [path.join(__dirname, '../node_modules')]
      }
    },
    require('postcss-nested'),
    require('autoprefixer')
  ];

  let app = new EmberApp(defaults, {
    autoImport: {
      watchDependencies: [
        '@ember-eui/core',
        '@ember-eui/validated-form',
        '@ember-eui/flatpickr',
        '@ember-eui/pikaday'
      ]
    },

    'ember-power-select': {
      theme: false
    },

    postcssOptions: {
      compile: {
        enabled: true,
        plugins: postcssPlugins
      }
    },

    // Add options here
    '@ember-eui/core': {
      theme: false
    },

    'ember-cli-netlify': {
      redirects: ['/* /index.html 200']
    },

    fingerprint: {
      enabled: env === 'production',
      generateAssetMap: true
    },

    'ember-fetch': {
      preferNative: true // Recommended to enable faster preloading for browsers that support it.
    },

    svgJar: {
      sourceDirs: [
        './public/assets',
        './node_modules/@ember-eui/core/vendor/icon'
      ]
    }
  });

  const { Webpack } = require('@embroider/webpack');
  const { BundleAnalyzerPlugin } = require('webpack-bundle-analyzer');

  const plugins = [];

  if (!IS_PRODUCTION && process.env.ANALYZER) {
    plugins.push(new BundleAnalyzerPlugin());
  }

  return require('@embroider/compat').compatBuild(app, Webpack, {
    // staticAddonTestSupportTrees: true,
    // staticAddonTrees: true,
    // staticHelpers: true,
    // staticModifiers: true,
    // staticComponents: true,
    // splitAtRoutes: ['*'],
    packagerOptions: {
      webpackConfig: {
        plugins: plugins,
        module: {
          rules: [
            {
              test: /CHANGELOG.md$/,
              use: [
                {
                  loader: path.resolve('./stringify-loader.js'),
                  options: {}
                }
              ]
            }
          ]
        }
      }
    }
  });
};
