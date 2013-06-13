# angular

-----------

## directive

`transclude: true`使得ng-transclude可以嵌入内容，
`'element'`嵌入整个元素，并以较低优先级执行其他directive

`scope:true`建立新的scope, `scope:{}`取值:

`@`绑定dom属性值，name变化localName也变化:
对于`<widget my-attr="hello {{name}}">`可绑定`{ localName:'@myAttr' }`

`=`双向绑定:
对于`<widget my-attr="parentModel">`可绑定`{ localModel:'=myAttr' }`

`&`在parent scope中执行expression

controller在pre-linking前实例化，供link使用

编译时，compiler调用$interpolate服务解析expressions，并注册为watches，在digest后更新

1. 使用browser api将html解析为dom
2. 使用$compile解析dom，匹配directives，汇总为组，按priority排列，执行其compile（compile函数可以修改dom结构，产生link），最终返回link组
3. 使用scope执行link，注册监听，建立watches

compile修改dom模板，为提升性能将所有实例都需要的操作放到这里，
link（常用）操作特定dom实例，注册监听事件，从scope向DOM中复制内容。

### 内置directive

ngController ngModel ngBind

a IE8以下自动加入href，如果没有href则取消跳转

multiple,selected,checked,disabled,readOnly,required,open解决html中不存在为false的问题

ngSrc ngHref解决直接赋值的错误路径问题

form可以嵌套，嵌套时一般使用ngForm

* `ng-bind` 按字面内容插入
* `ng-bind-html` 解析html后插入，可以确保安全
* `ng-bind-html-unsafe` 完全信任html，直接innerHtml

`ng-cloak` 可以避免模板在加载过程中的闪动，初始时`display:none`，加载完成后再显示.
需要将angular.js放在header中，或者在css中加入
```css
[ng\:cloak], [ng-cloak], [data-ng-cloak], [x-ng-cloak], .ng-cloak, .x-ng-cloak {
  display: none;
}
```
也可以使用ngBind

## service

$q总是异步的，通过$rootScope.$apply()来激活

service与factory的区别
```js
app.service('myService', function() {
  // service is just a constructor function that will be called with 'new'
  this.sayHello = function(name) {
     return "Hi " + name + "!";
  };
});

app.factory('myFactory', function() {
  // factory returns an object. you can run some code before
  return {
    sayHello : function(name) {
      return "Hi " + name + "!";
    }
  }
});
```

将html元素编译为函数并使用scope调用 `$compile($node)(scope)`

将表达式编译为函数并调用 `$parse`
```js
var getter = $parse('user.name');
var setter = getter.assign;
var context = {user:{name:'angular'}};
var locals = {user:{name:'local'}};

expect(getter(context)).toEqual('angular');
setter(context, 'newValue');
expect(context.user.name).toEqual('newValue');
expect(getter(context, locals)).toEqual('local');
```

### communicate between controllers

sharing a service:

```js
function FirstController(someDataService) {
  // use the data service, bind to template...
  // or call methods on someDataService to send a request to server
}

function SecondController(someDataService) {
  // has a reference to the same instance of the service
  // so if the service updates state for example, this controller knows about it
}
```

emitting an event on scope:

```js
function FirstController($scope) {
  $scope.$on('someEvent', function() {});
  // another controller or even directive
}

function SecondController($scope) {
  $scope.$emit('someEvent', args);
}
```

## 源码

setupModuleLoader得到module(name, requires, configFn)

module得到moduleInstance

moduleInstance内部维护了invokeQueue和runBlocks

AngularPublic.js建立ngLocale和ng两个module

injector.js
执行$get

```js
function createInternalInjector(cache, factory) {

  get: function getService(serviceName) {
    return factory(serviceName);
  }
  invoke:function invoke(fn, self, locals){
    return fn.apply(self, args);//args为依赖数组getService得到的数组
  }
  instantiate: function instantiate(Type, locals) {
    return invoke(Type, instance, locals);
  }
  annotate(fn)获得$inject，即fn的依赖数组
}
```
