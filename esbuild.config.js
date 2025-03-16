const esbuild = require('esbuild');
const postcssPlugin = require('esbuild-plugin-postcss');

esbuild.build({
  entryPoints: ['app/javascript/application.js'], // ここは自分のエントリーファイルを指定
  bundle: true,
  outfile: 'app/assets/builds', // 出力先
  plugins: [
    postcssPlugin({
      plugins: [
        require('tailwindcss'),
        require('autoprefixer'),
      ]
    })
  ],
}).catch(() => process.exit(1));
