const PATH = require("path");
const ExtractTextPlugin = require("extract-text-webpack-plugin");
const UglifyJsPlugin = require('uglifyjs-webpack-plugin');
const CleanWebpackPlugin = require('clean-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');

// the path(s) that should be cleaned
let pathsToClean = [
  './public/css',
  './public/js',
  './public/images',
];

// the clean options to use
let cleanOptions = {
  exclude:  ['./private/*', './node_modules/*'],
  verbose:  true,
};

// definition of project file compilation
module.exports = {
	// defining entry point for the files
	entry: {
		index: PATH.join(__dirname, "./", "private/", "js/", "index.js"),
	},

	// defining output for the files
	output: {
	    path: PATH.join(__dirname, "./", "public/", "js/"),
	    filename: "[name].js"
	},

	// defining rules for the compilation of different sets of file
	module:{
		rules: [
			{
				// defining rules for the js scripts
				test: /\.js$/,
				exclude: /node_modules/,
				use: {
					loader: 'babel-loader',
				},
			},
			{
				// defining rules for the scss styling
			    test: /\.scss$/,
				exclude: /node_modules/,
			    use: ExtractTextPlugin.extract({
					fallback: "style-loader",
					use: [{
						// minimize the output css file
						// https://github.com/webpack-contrib/extract-text-webpack-plugin
					    loader: 'css-loader',
					    options: {
					        minimize: true,
					    }
					}, {
						// using sass loader for compiling the files
						// https://github.com/webpack-contrib/sass-loader
					    loader: 'sass-loader',
					}]
			    })
			},
		],
	},

	// defining plugins used to generate the file output
	plugins: [
		// deleting files and folder before generating new ones
		// https://github.com/johnagan/clean-webpack-plugin
		new CleanWebpackPlugin(
			pathsToClean, 
				{ cleanOptions }
		),

		// compressed css file genrating
		// https://github.com/webpack-contrib/extract-text-webpack-plugin
		new ExtractTextPlugin({
			filename: "./../css/[name].css"
		}),

		// compressing js files
		// https://github.com/webpack-contrib/uglifyjs-webpack-plugin
		new UglifyJsPlugin({
    		uglifyOptions: {
				compress: true,
			}
		}),

		// copying images files
		// this only work when any files are present in this folder if using in scss
		// it will give an error if you dont have images folder in private directory
		// https://github.com/webpack-contrib/copy-webpack-plugin
		new CopyWebpackPlugin([
			{
				from: PATH.join(__dirname, "./", "private/", "images/"),
				to: PATH.join(__dirname, "./", "public/", "images/"),
			}
		]),
	]
};
