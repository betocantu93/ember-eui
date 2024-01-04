import copy from 'rollup-plugin-copy';
import { babel } from '@rollup/plugin-babel';
import { Addon } from '@embroider/addon-dev/rollup';

const addon = new Addon({
  srcDir: 'src',
  destDir: 'dist'
});

export default {
  output: { ...addon.output(), hoistTransitiveImports: false },
  plugins: [
    addon.publicEntrypoints([
      '**/*.js',
      'components/validated-form/field-base.js',
      'index.js',
      'template-registry.js',
      '**/*.cjs'
    ]),
    addon.appReexports([
      'components/**/*.js',
      'utils/**/*.js',
      'validators/**/*.js'
    ]),
    addon.dependencies(),
    babel({
      extensions: ['.js', '.gjs', '.ts', '.gts'],
      babelHelpers: 'bundled'
    }),
    addon.hbs(),
    addon.gjs(),
    addon.keepAssets(['**/*.css']),
    addon.clean(),
    copy({
      targets: [
        { src: '../README.md', dest: '.' },
        { src: '../LICENSE.md', dest: '.' }
      ]
    })
  ]
};
