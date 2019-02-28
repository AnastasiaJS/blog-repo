---
title: hexo+nexT主题+githubPages个人博客搭建
date: 2018-08-29 09:41:56
categories: 博客搭建  #分类
toc: true #是否显示文章目录
tags:
    - nexT
    - hexo
    - githubPages
---
<!-- more -->
## 安装
   + node
   + git
   + hexo-cli
     + npm install -g hexo-cli
     
## 建站

``` bash
    $ hexo init <folder>
    $ cd <folder>
    $ npm install
```
    
### 结构说明
   - _config.yml 为站点配置文件
   - scaffolds 为模板文件夹
   - source 存放用户资源
   - themes 主题文件夹，里面也会有一个_config.yml，为主题配置文件
   
   #### NexT主题
   ##### 安装
   
```bash
    git clone https://github.com/theme-next/hexo-theme-next themes/next
```
   这样主题文件就拷贝到themes文件夹中
   #### 设置主题
   站点配置文件：
   
        theme: next
    

   
## 站点文件配置

[官方配置文档](https://hexo.io/zh-cn/docs/configuration)

### deploy 部署部分的设置
```bash
      deploy:
      type: git
      branch: 分支名字
      repo: https://github.com/github用户名/github用户名.github.io.git
```
### url配置

If your site is put in a subdirectory, set url as 'http://yoursite.com/child' and root as '/child/'

```bash
    url:  https://Anastasia.github.io
    root: /AnastasiaJ/ 
```
 ### 本地运行
 `hexo s --debug`


```html
    <div>Syntax Highlighting</div>
```

 *浏览器打开必须是 localhost:4000/`你的root`*
### 发布到服务器：以上配置好后分别执行
```bash
        hexo clean
        hexo d -g 或者 hexo g -d
```
*最好建一个分支，分支作为发布的博客内容，master作为构建代码，便于多台电脑发布博客*

### .md文件配置

```bash    
    title: hexo+nexT主题+githubPages个人博客搭建
    date: 2018-08-29 09:41:56
    categories: "博客搭建"  #分类
    toc: true #是否显示文章目录
    tags:
        -nexT
        -hexo
        -githubPages
```
## 写作
- 新建文章 hexo new post title (post不定，可以是scaffolds中的任意一篇草稿)
-        
## 插件
- [站点访问量“不蒜子”](http://ibruce.info/2015/04/04/busuanzi/)
- [评论系统1：Valine](https://blog.csdn.net/blue_zy/article/details/79071414)
- [评论系统2：必来力LiveRe](https://livere.com/insight/myCode)
- [音乐：hexo-tag-aplayer](https://aplayer.js.org/#/zh-Hans/ '使用 Hexo 插件插入音乐/视频')

其他插件可参考NexT [使用文档](http://theme-next.iissnan.com/getting-started.html#install-next-theme)
## 走过的坑

### 仓库的名字

仓库的名字的正确格式是github用户名.github.io

### hexo s 启动命令不识别

需要安装 hexo-server

-------------------

以上内容写的比较简单，主要是记录了一个主要的搭建过程，具体详细的部分都有官方文档可参考，这里不另外阐述。

    
   
   
