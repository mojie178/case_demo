# Animate 动画

### <a name="nusucw"></a>基本用法
1、在页面的 <head>中引入样式文件：
```html
<head>
    <link rel="stylesheet" href="animate.min.css">
</head>
```
2、给你想要添加动画效果的元素加上 animated 样式，如果想要动画循环执行的话，你需要加上 infinite 样式。
3、最后，你需要加上下面中的一个样式：
```javascript
bounce
flash
pulse
rubberBand
shake
swing
tada
wobble
jello
bounceIn
bounceInDown
bounceInLeft
bounceInRight
bounceInUp
bounceOut
bounceOutDown
bounceOutLeft
bounceOutRight
bounceOutUp
fadeIn
fadeInDown
fadeInDownBig
fadeInLeft
fadeInLeftBig
fadeInRight
fadeInRightBig
fadeInUp
fadeInUpBig
fadeOut
fadeOutDown
fadeOutDownBig
fadeOutLeft
fadeOutLeftBig
fadeOutRight
fadeOutRightBig
fadeOutUp
fadeOutUpBig
flipInX
flipInY
flipOutX
flipOutY
lightSpeedIn
lightSpeedOut
rotateIn
rotateInDownLeft
rotateInDownRight
rotateInUpLeft
rotateInUpRight
rotateOut
rotateOutDownLeft
rotateOutDownRight
rotateOutUpLeft
rotateOutUpRight
hinge
rollIn
rollOut
zoomIn
zoomInDown
zoomInLeft
zoomInRight
zoomInUp
zoomOut
zoomOutDown
zoomOutLeft
zoomOutRight
zoomOutUp
slideInDown
slideInLeft
slideInRight
slideInUp
slideOutDown
slideOutLeft
slideOutRight
slideOutUp
```
完整例子：
```html
<h1 class="animated infinite bounce">Example</h1>
```
例子可查看：[https://daneden.github.io/animate.css/](https://daneden.github.io/animate.css/)
### <a name="7nznud"></a>与jQuery用法
当你将 animate.css 与 jQuery 一起使用或者添加你自己的 CSS 规则时， 你可以用 animate.css 做一大堆其他的事，使用 jQuery 动态添加动画：
```javascript
$('#yourElement').addClass('animated bounceOutLeft')
```
你也可以检测一个动画是否结束了：
```javascript
$('#yourElement').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', doSomething)
```
*__注意： jQuery.one() 用在你希望只执行事件一次 的时候。__*
你可以改变动画的持续时间，添加延迟或改变它执行的次数：
```css
#yourElement {
    -vendor-animation-duration: 3s;
    -vendor-animation-delay: 2s;
    -vendor-animation-iteration-count: infinite;
}
```
__*注意：确保用供应商的前缀（webkit, moz, 等等）来替换上面CSS中的 vendor*__
### <a name="paoruk"></a>自定义构建
Animate.css 由 gulp.js 提供支持，你可以很轻松地执行自定义构建。首先，你需要 Gulp 和其它的依赖项：
```bash
$ cd path/to/animate.css/
$ sudo npm install
```
接下来，运行 gulp 来查看变化和编译你的自定义构建。比如，如果你只需要 “attention seekers” 中的一些，只需编辑 animate-config.json 文件来只选择你需要的动画。
```javascript
"attention_seekers": {
    "bounce": true,
    "flash": false,
    "pulse": false,
    "shake": true,
    "swing": true,
    "tada": true,
    "wobble": true,
    "jello":true
}
```

