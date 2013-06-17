# angular

-----------

## directive

`transclude: true`使得ng-transclude可以嵌入内容，
`'element'`嵌入整个元素，并以较低优先级执行其他directive

controller在pre-linking前实例化，供link使用

编译时，compiler调用$interpolate服务解析expressions，并注册为watches，在digest后更新

1. 使用browser api将html解析为dom
2. 使用$compile解析dom，匹配directives，汇总为组，按priority排列，执行其compile（compile函数可以修改dom结构，产生link），最终返回link组
3. 使用scope执行link，注册监听，建立watches

compile修改dom模板，为提升性能将所有实例都需要的操作放到这里，
link（常用）操作特定dom实例，注册监听事件，从scope向DOM中复制内容。

### scope

* `scope:true` 创建新的scope，原型继承父scope
* `scope:{}` 隔离的scope，适于创建可重用组件

ng-repeat, ng-switch, ng-view, ng-include会创建新的继承scope

ng-controller最好使用service共享数据，而不是使用scope

新的scope中如果要修改父scope变量，最好使用object或array，或者$parent.parentScopeProperty

因为在js的原型继承中，子类如果给属性赋值会自身创建该属性，并覆盖父类的同名属性；
而因为object是引用赋值，所以如果对array或object进行更改，修改的会是父类同名属性。
另外，如果对object进行赋值，会自身创建该属性。如果删除之，会再次暴露出父类同名属性。

必须使用attribute指定parent property，然后才能在scope中引用

```js
<my-component attribute-foo="{{foo}}" binding-foo="foo" isolated-expression-foo="updateFoo(newFoo)" >
scope:{
  //`@`绑定dom属性值，name变化localName也变化:
  isolatedAttributeFoo:'@attributeFoo',
  // `=`双向绑定:
  isolatedBindingFoo:'=bindingFoo',
  // `&`在parent scope中执行expression
  isolatedExpressionFoo:'&'
}
```

### 四种scopes，都拥有parent-child关系，通过$parent , $$childHead, $$childTail调用

原型继承ng-include, ng-switch, ng-controller, directive with scope: true

ng-repeat 原型继承并赋值

独立 scope: {...}，'=', '@',  '&'通过属性可以获取parent scope properties

transcluded scope -- directive with transclude: true. 原型继承，但是将isolate scope作为sibling


### $observe vs $watch

$observe()是attrs的方法，用于监测DOM属性的变化，特别是包含{{}}

```js
attr1="Name: {{name}}"
attrs.$observe('attr1', ...).
```

$watch()是scope的方法，用于监测expression，参数为函数或者字符串
如果是字符串，那么会$parse为函数，然后在每个digest循环中被调用，不能包含{{}}

```js
attr1="myModel.some_prop",
scope.$watch('myModel.some_prop', ...)
scope.$watch(attrs.attr1, ...)
scope.$watch(attrs['attr1'], ...)
```

link函数中， {{}}属性还没有执行，所以只能通过$observe来获得，或者使用@的isolate scope中的$watch

### compile vs link vs controller

compile用于DOM操作的模板（tElement = template element），如果定义了compile，那么link会被忽略，因此link需要作为compile的返回函数

link用来注册DOM listeners（$watch），修改DOM（iElement = individual instance element），在模板被clone之后执行

controller当其他directive需要与本directive交互时使用

on the AngularJS home page, the pane directive needs to add itself to the scope maintained by the tabs directive,
hence the tabs directive needs to define a controller method (think API) that the pane directive can access/call.

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

### defer

```js
 var deferred = $q.defer();

  setTimeout(function() {
    // since this fn executes async in a future turn of the event loop, we need to wrap
    // our code into an $apply call so that the model changes are properly observed.
    scope.$apply(function() {
      if (okToGreet(name)) {
        deferred.resolve('Hello, ' + name + '!');
      } else {
        deferred.reject('Greeting ' + name + ' is not allowed.');
      }
    });
  }, 1000);

  return deferred.promise;
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
