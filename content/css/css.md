# css

------

## basic

调整background的覆盖区域:
`background-clip: border-box 或 padding-box 或 content-box`

控制背景的起始位置:
background-origin.
取值为padding-box, border-box, content-box

控制背景大小，拉伸改变:
background-size

RGBA 和opacity 之间的不同是前者只会应用到指定的元素上，而后者会影响我们指定的元素及其子元素。

user-select 用来控制内容的可选择性。如果设为none则用户不能选择元素中的任何内容

url中不需要''

block元素如果不设定宽度，会使用文本宽度，进而扩展到最宽

### Shrink Wrap

使得block元素跟content一样宽

* float: left  最简单
* display: inline 可以在父元素中text-align:center实现居中
* display: inline-block 要考虑IE6兼容
* position: absolute;

## 技巧

mod设置border-radius，如果hd/ft没有设置，会出现直边,解决方法是也设置相应的border-radius

### backgrond

`background: #ccc url(/img/bullet.gif) no-repeat left center;`

可以直接用在body中作为背景显示

如果图片作为显示的内容，应该使用image标签；如果只是修饰，应该使用background

修饰性图片需要设置width, height

作为背景时通常需要空出位置防止文字覆盖，可以使用padding

background-position中
left center; 与 0 50%; 效果相同

可以使用keywords,  pixels or percentages。
如果使用px或em，则图像左上角定位在元素指定位置。
如果使用百分比，则图像相应百分比定位在元素指定百分比位置。
不要混用units和keywords

### 圆角

定宽使用上下两个标签，如果背景也需要图片那么需要三个标签。在上下标签里分别进行相应的padding

不定宽使用四个标签，使用滑动门技术，预先准备最大的图片，切割为四部分

em使得box大小随字体变化，为elastic布局。%使得box大小随屏幕大小变化，为liquid布局

Multiple background images可以省略多余的标签

border-radius专业圆角

border-image使用一个图像即可，而且可以通过图像控制边距

### 阴影

使用最大的阴影图片作为背景，img做margin。注意div为block，需要shrink-wrap

block中的inline image会自动跟文字的baseline对齐，因此外面包裹的div高度会大于image高度。
解决方法是设image的display: block, 或vertical-align: bottom or middle,
或索性设div的line-height:0

box-shadow

### 透明

```css
opacity: 0.8;
filter: alpha(opacity=80); /*proprietary IE code*/
```

问题是由于继承关系，包裹的内容文字也会透明，
background-color: rgba(0,0,0,0.8);这样里面的文字就不会透明了

IE6中png透明
```css
  filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='img/controls.png', sizingMethod='crop');
  _background:none;
```

### link style

锚点可以使用id，也可以`<a name="some"></a>`。
因此设置a样式不够严谨，应该使用a:link

注意顺序
```css
a:link, a:visited {text-decoration: none;}
a:hover, a:focus, a:active {text-decoration: underline;}
```

可以设置颜色，加粗，边框来区分链接样式。
使用border-bottom模拟下划线。
使用background实现各种样式的下划线，甚至gif动画

CSS3中加入:target，可以在该锚点被点击后触发

链接只应该用于get，如果用于post很有可能会误操作（如爬虫，加速器等）


### list

在a中控制样式而不是li中控制，这样通常有更好的浏览器兼容性

斜面效果：top-border颜色比background更亮，bottom-border比之更暗

在body中添加class用来区分本页特点，可以有效控制不同页面的样式差异

IE中如果a做了text-indent， 会失去边框等效果。解决方法是使用一个透明gif作为background-image

在a中可以使用多个span来完成更复杂的交互

## 案例

### Roma

body中设置background，font，color

页面居中 wrapper，定宽1070px

四部分 header, main, secondary, footer

中间两部分float:left; margin控制边距，定宽

footer字体小，颜色淡。text-align:center;  居中背景图

header中ul>li>a>em, strong, h1, h2, form 简单的不用加id

`<form action="#" method="get">`

`<input type="image" src="img/search-go.gif">`

carousel

a包裹img，a样式为background: #1e1a0e url(../img/loading.gif) no-repeat center center;来显示加载图片

img也可以有background

## 工具

### CSS3 Pie让IE6-8支持圆角、渐变、阴影

支持border-radius: 5px 10px 15px 20px;

box-shadow如果box背景透明会透出来，因此需要设置box背景

border-image

multiple background images, linear gradients as background images, and some of the new CSS3 background aspects such as background origin and clip，

需要使用 -pie-background，可以实现IE6的png透明

可以自动监听css的变化，

监听父级css变化-pie-watch-ancestors: 1

强制png透明 -pie-png-fix: true;

延迟渲染直到滚动到可视区域-pie-lazy-init:true;
