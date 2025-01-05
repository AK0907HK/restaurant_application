/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*',
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Roboto', 'Arial', 'sans-serif'], // Google Fontsで指定したフォント
      },

    },
  },
  plugins: [],
}

