---
title: PDF.js
toc: true
comments: true
date: 2018-09-07 09:42:38
categories: javascript
tags: 
    - PDF.js 
    - JavaScript 
    - PDF解析器
---
# PDF.js介绍
PDF.js 是基于开放的 HTML5 及 JavaScript 技术实现的开源产品。简单说就是一个 PDF 解析器。

最初使用这个东西的原因是公司技术总监说要做一个打印模板设计器。本公司的产品有很多内容都是需要打印的，且每个打印的内容页面设计是不一样的，导致每次实现打印页面的时候就要单独写一个HTML页面，部分还涉及到小票的套打，很繁琐。因此，需要做一个打印设计器，方便每次打印页面的生成，具体我也不知道是怎么弄的。。。后台开发将设计好的内容以buffer的形式传给前端显示，前端这边需要做的就是将`buffer内容用PDF显示出来`。
# 下载
[官网地址](http://mozilla.github.io/pdf.js/)

# 显示 buffer 内容
1. 将viewer.js文件中的变量 DEFAULT_URL 删除
2. 在viewer.html中重新定义DEFAULT_URL,我们在这里做buffer的转换，`必须把buffer转换成Uint8Array类型`，这样pdf.js才能直接解析。
    ```
    <script>
        let  = "";//注意，删除的变量在这里重新定义
        let PDFData = window.sessionStorage.pdf;
        let rawLength = PDFData.length;
        //转换成pdf.js能直接解析的Uint8Array类型,见pdf.js-4068
        let array = new Uint8Array(new ArrayBuffer(rawLength));
        for(i = 0; i < rawLength; i++) {
            array[i] = PDFData.charCodeAt(i) & 0xff;
        }
        DEFAULT_URL = array;
    </script>
    ```
这段代码中我将buffer保存在浏览器本地传过来的，因为是在react项目中使用，我没有想到更好的办法将react组件中产生的内容传递到HTML页面中。。。。

以上代码要放在`<script src="viewer.js"></script>`前面。

至此，内容应该是可以显示了。

# 直接弹出打印预览窗口

前面说过，公司产品有很多内容都是需要打印的，客户不会太愿意在打开PDF预览界面之后手动点击打印按钮去打印，然后弹出打印预览窗口，还要点击打印，从打印机打印出来，这对客户来说`打印`需要执行的操作付出的代价过大了，所以为了更好的客户体验，在PDF页面渲染完成后直接弹出打印预览界面。

## PDF.js重写了浏览器本身的打印方法

```
    //viewer.js
    document.getElementById('print').addEventListener('click',
        SecondaryToolbar.printClick.bind(SecondaryToolbar));
```
## RenderingStates 渲染状态
viewer.js 中有RenderingStates来表示渲染的状态
```
var RenderingStates = {
    INITIAL: 0,
    RUNNING: 1,
    PAUSED: 2,
    FINISHED: 3
};
```
错误：
    首先想到在`view.renderingState === RenderingStates.FINISHED`的时候执行，即

    ```
    isViewFinished: function PDFRenderingQueue_isViewFinished(view) {
        <!-- 添加打印代码 -->
        if(view.renderingState === RenderingStates.FINISHED && sessionStorage.isPrint === 'true'){
            document.getElementById('print').click()
        }
        <!-- 添加打印代码 end-->
        return view.renderingState === RenderingStates.FINISHED;
        }
    ```
然后在加载页面多的时候会有这样的提示
![img](http://pe5s1kztp.bkt.clouddn.com/images/PDF%E8%AD%A6%E5%91%8A.jpg "PDF未完全加载已供打印")

嗯==，然后我实在没有找到很合适的地方去调用打印的这个方法，最后在这里加上的
![img](http://pe5s1kztp.bkt.clouddn.com/images/menu.saveimg.savepath20180907155350.jpg)

这样以后，‘PDF未完全加载已供打印’的提示没有的，打印页面也正常了。

注意`sessionStorage.isPrint=false;`这个控制语句要加上，不然即使点击了取消打印预览窗口，该窗口还是会不断弹出来。

如果有更好的方案，请不吝赐教，在下面留言，在下感激不尽。