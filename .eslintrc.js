<<<<<<< HEAD

=======
>>>>>>> 0b53ef020622b1816db59cbebf59940f7bf42c95
module.exports = {
    env: {
        browser: true,
        commonjs: true,
        es6: true,
        jquery: true
    },
    extends: [
        'airbnb-base'
    ],
    globals: {
        Atomics: 'readonly',
        SharedArrayBuffer: 'readonly',
    },
    parserOptions: {
        ecmaVersion: 2018,
    },
    rules: {
        indent: ['error', 4],
        'linebreak-style': ['error', 'unix'],
    },
};
