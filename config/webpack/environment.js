const { environment } = require("@rails/webpacker");
const webpack = require("webpack");

// Add an additional plugin of your choosing : ProvidePlugin
environment.plugins.prepend(
  "Provide",
  new webpack.ProvidePlugin({
    $: "jquery/src/jquery",
    jQuery: "jquery/src/jquery",
    "window.Tether": "tether",
    Popper: ["popper.js", "default"], // for Bootstrap 4
  })
);

module.exports = environment;
