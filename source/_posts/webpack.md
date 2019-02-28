---
title: webpack demo
toc: true
comments: true
categories: webpack
date: 2018-10-12 09:45:55
tags:
    - webpack
    - 模块打包
---
简单的webpack demo

# 配置文件 package.json 

        {
            "name": "webpack-demo",
            "version": "1.0.0",
            "description": "",
            "private": true,
            "scripts": {
                "test": "echo \"Error: no test specified\" && exit 1",
                "start": "webpack-dev-server --open",
                "watch": "webpack --watch",
                "server": "node server.js",
                "build": "webpack"
            },
            "keywords": [],
            "author": "",
            "license": "ISC",
            "devDependencies": {
                "clean-webpack-plugin": "^0.1.19",
                "css-loader": "^1.0.0",
                "express": "^4.16.4",
                "file-loader": "^2.0.0",
                "html-webpack-plugin": "^3.2.0",
                "style-loader": "^0.23.1",
                "webpack": "^4.20.2",
                "webpack-cli": "^3.1.2",
                "webpack-dev-middleware": "^3.4.0",
                "webpack-dev-server": "^3.1.9",
                "xml-loader": "^1.2.1"
            },
            "dependencies": {
                "lodash": "^4.17.11"
            }
        }

**webpack 建议本地安装，这可以使我们在引入破坏式变更的依赖时，更容易分别升级项目。**

 *本地安装webpack后，能够从node_modules/.bing/webpack 访问它的bin版本*

从配置的依赖项来看，除了基本的webpack 及webpack-cli，还包括express、loader、plugin、middleware等，这些下面会进行说明。

# webpack.config.js 

        const path = require('path');
        const HtmlWebpackPlugin = require('html-webpack-plugin');
        const CleanWebpackPlugin = require('clean-webpack-plugin');
        const webpack = require('webpack');

        module.exports = {
            entry: {
                app: './src/index.js'
            },
            devtool: 'inline-source-map',
            devServer: {
                contentBase: './dist',
                hot: true
                },
            module: {
                rules: [
                {
                    test: /\.css$/,
                    use: ['style-loader', 'css-loader']
                }
                ]
            },
            plugins: [
                new CleanWebpackPlugin(['dist']),
                new HtmlWebpackPlugin({
                title: 'Output Management'
                }),
                new webpack.NamedModulesPlugin(),
                new webpack.HotModuleReplacementPlugin()
            ],
            output: {
                filename: '[name].bundle.js',
                path: path.resolve(__dirname, 'dist'),
                publicPath: '/'
            }
        };

## entry 项目入口

单个 entry='./src/index.js'；

多个 entry={
    app:'./src/index.js',
    main:'./src/main.js'
}

## output 项目出口

    output: {
                filename: '[name].bundle.js',
                path: path.resolve(__dirname, 'dist'),
                publicPath: '/'
            }

filename顾名思义，输出的文件的名字，多个入口的情况下，'[name].bundle.js' 会将文件输出为'app.bundle.js'及'main.bundle.js'，根据起点名称生成bundle文件。

path 输出路径；

publicPath：公共路径，会在服务器脚本用到，确保文件资源能够在 http://localhost:3000 下正确访问

## loader 管理资源

webpack 通过 loader 引入任何其他类型的文件。

/\.css$/: style-loader、css-loader；//css

/\.(png|svg|jpg|gif)$/: file-loader；//图片

/\.(woff|woff2|eot|ttf|otf)$/: file-loader；//字体

/\.(csv|tsv)$/: csv-loader；//csv

/\.xml$/: xml-loader；//xml数据

     import Data from './data.xml';
     function component() {
        console.log(Data);
        //import 这四种类型的数据(JSON, CSV, TSV, XML)中的任何一种，所导入的 Data 变量将包含可直接使用的已解析 JSON
    }


## 全局资源

        - |- /assets
        + |– /components
        + |  |– /my-component
        + |  |  |– index.jsx
        + |  |  |– index.css
        + |  |  |– icon.svg
        + |  |  |– img.png

类似这样，将模块和资源组合在一起，无需依赖于含有全部资源的 /assets 目录，而是将资源与代码组合在一起，这样的结构会非常有用。

 **会使代码更具有可移植性，因为现有的统一放置的方式会造成所有资源紧密耦合在一起。**

 当无法用这种方式开发，或者有多个组件间资源共享的时候，仍然可以将这些资源存储在公共目录中，配合 **alias** 来使用他们更方便import导入。

 ### alias写法：

    resolve:{
        alias: {
            ASSET: path.join(src, 'assets'),
            xyz$: path.resolve(__dirname, 'path/to/file.js')
        },
    }
    import Test1 from 'xyz'; // 精确匹配，所以 path/to/file.js 被解析和导入
    import Test2 from 'xyz/file.js'; // 非精确匹配，触发普通解析


**在给定对象的键后的末尾添加 $，以表示精准匹配**



## plugins
### HtmlWebpackPlugin

    npm install --save-dev html-webpack-plugin

该插件会根据我们的配置自动生成一个html入口文件，不用我们自己手动写。这样的好处就是，即使配置文件的入口点等名称改了，我们不用重新去修改index.html文件的内容。

生成的bundle文件会自动添加到html中。
### 清理/dist文件夹

    npm install clean-webpack-plugin --save-dev

每次webpack生成文件前建议清除 /dist 文件夹，避免过去生成的代码和最新的混合在一起。

# 开发
## 使用 source map (devtool)

用webpack打包，开发时需要追踪到具体错误和警告产生的位置，根据想要的效果不同需要做不同的配置。

开发环境适合使用：eval-source-map
生产环境可省略

具体说明还可查看 [官方配置](https://www.webpackjs.com/configuration/devtool/)


## 自动监测代码的变化

一下三种工具能在代码发生变化时自动编译代码：
 1. webpack's Watch Mode
 2. webpack-dev-server
 3. webpack-dev-middleware
 
### 观察模式
直接在配置文件package.json 中添加脚本 ` "watch": "webpack --watch" `

**缺点：需要手动刷新浏览器**

### webpack-dev-server

`npm install --save-dev webpack-dev-server`

在webpack.config.js中配置，告诉开发服务器在哪里查找文件

        devServer: {
            contentBase: './dist'
        }

同时添加一个 script 脚本，可以直接运行开发服务器(dev server)：

`"start": "webpack-dev-server --open"`

### webpack-dev-middleware 配合 express server
    `npm install --save-dev express webpack-dev-middleware`

webpack.config.js
    
    output: {
        publicPath: '/'
    }

server.js

    const express = require('express');
    const webpack = require('webpack');
    const webpackDevMiddleware = require('webpack-dev-middleware');

    const app = express();
    const config = require('./webpack.config.js');
    const compiler = webpack(config);

    // Tell express to use the webpack-dev-middleware and use the webpack.config.js
    // configuration file as a base.
    app.use(webpackDevMiddleware(compiler, {
    publicPath: config.output.publicPath
    }));

    // Serve the files on port 3000.
    app.listen(3000, function () {
    console.log('Example app listening on port 3000!\n');
    });

package.json

    "scripts": {
        "server": "node server.js",
    }

### 热替换
在项目已经运行的情况下，可以尝试模块热替换。