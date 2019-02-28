---
title: HEXO+NEXT主题个性化配置
date: 2018-08-27 18:02:52
comments: true #是否可评论
categories: 博客搭建  #分类
toc: true #是否显示文章目录
tags: 
	- hexo
	- nexT

---
主要说明当前博客中的音乐及其他主题个性化配置
<!--more-->
### 左下角音乐
*使用插件hexo-tag-aplayer | aplayer*
1. npm install hexo-tag-aplayer --save （aplayer）
2. 在themes/next/layout/_custom/header 中加入以下语句，具体的可参考官方文档设置
```    
<div id="player1" class="aplayer"></div>
<link rel="stylesheet" type="text/css" href="http://pe5s1kztp.bkt.clouddn.com/css/APlayer.min.css" />
<script src="http://pe5s1kztp.bkt.clouddn.com/js/APlayer.min.js"></script>
<script type="text/javascript">
const apo = new APlayer({
    container: document.getElementById('player1'),
    fixed: true,//固定在左下角
    autoplay: false,
    audio: [{
        name: '周杰伦',
        artist: '水管的友情',
        url: 'http://pe5s1kztp.bkt.clouddn.com/music%E6%B0%B4%E7%AE%A1%E7%9A%84%E5%8F%8B%E6%83%85.flac',
        cover: 'http://pe5s1kztp.bkt.clouddn.com/images/employee-1118183_640.jpg',
    }]
});
</script>
``` 


### 其他个性化配置可参考


[二次元博客 :）](http://mashirosorata.vicp.io/)
