# js

------

## basic

`document.activeElement` 当前激活的元素

保留两位小数四舍五入 `2.4324.toFixed(2)`

## bootstrap

使用css动画，回调函数通过创建临时元素，查询style中的动画方法，获得动画结束方法

加入css动画样式之前先force reflow `$element[0].offsetWidth`,
然后 `$element.addClass('in')`

在事件响应中阻止默认事件运行
```js
e = $.Event('hide')
this.$element.trigger(e)
if (!this.isShown || e.isDefaultPrevented()) return
```

## 插件

[jQuery-slimScroll](http://rocha.la/jQuery-slimScroll)
自定义滚动条，mouseover时出现
