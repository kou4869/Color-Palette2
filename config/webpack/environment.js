const { environment } = require('@rails/webpacker')

const webpack = require('webpack')
environment.plugins.prepend('Provide',
    new webpack.ProvidePlugin({

    // jQueryの導入
        $: 'jquery/src/jquery',
        jQuery: 'jquery/src/jquery',

    // Bootstrapの導入
        Popper: 'popper.js'
    })
// ここまで

)

module.exports = environment
