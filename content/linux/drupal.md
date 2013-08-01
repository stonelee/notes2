# drupal

----------

## 安装

语言文件放在 `profiles/standard/translations/`

建立文件并配置属性

```
cd ./sites/default
sudo cp default.settings.php settings.php
sudo chmod 666 settings.php

mkdir files
sudo chmod 777 files
```

## 开发

module file (.module), include file (.inc), install file (.install), settings.php file, and template.php file (in themes)
应该 `<?php`开头，但是没有闭合标签。
这是为了避免闭合标签后出现的空格导致的错误。
template files (.tpl.php)文件中需要`?>`来结尾

module中内部使用的方法名前面加下划线，如_function_name()，不应该被其他模块调用，同时防止错误覆盖了hook。
同时也应该加上模块名，防止与其他模块发生冲突

清缓存，注意权限配置，显示Notices and Errors

```
settings.php中

error_reporting(-1);
$conf['error_level'] = 2;
ini_set('display_errors', TRUE);
ini_set('display_startup_errors', TRUE);
```

调试信息

* `dpm` 使用Devel显示内容
* `watchdog`打印出日志需要在报告中查看
* `debug($user, 'User object')`
* `drupal_set_message` 保存在session中，通过$messages显示

从modules文件夹的module文件中递归寻找特定内容，并显示行号:
`grep -nHR --include=*.module 'admin/appearance' modules`

* `theme_get_setting` 从setting中获取值
* `variable_get` 从数据库中取值，使用form也可以更改此值

`drupal_attributes` 将array转为属性字符串，会 check_plain 过滤特殊字符

`drupal_add_js(path_to_theme() . '/js/hoverintent/hoverintent.js');`

`drupal_strtolower` 转为小写

`drupal_get_path_alias`， drupal_get_normal_path

`drupal_match_path` 检查path是否符合模式

`arg` 得到path的部分值

创建文件夹
```
  $dir = file_stream_wrapper_uri_normalize($dir);
  file_prepare_directory($dir,  FILE_CREATE_DIRECTORY);
```

* `file_copy` 复制文件并将记录加到数据库中
* `file_unmanaged_delete` 删除文件，不影响数据库
* `file_save_upload` 上传文件，保存在临时表中

* `image_load` 加载image并返回image对象
* `image_scale` 保持比例更改image尺寸
* `image_save` 保存

`hide`() 在后面render父节点时不进行渲染

`flood_is_allowed`， `flood_clear_event`，`flood_register_event`在一段时间内控制访问次数

`drupal_goto` 重定向到url

`ip_address` 客户端IP地址

`db_query_range` 从数据库中查询部分内容

`user_access` 判断用户是否有权限

`menu_get_item` 得到导航项

`drupal_get_title` 得到页面title

`system_region_list` 从主题中获取regions

`element_children` 得到元素的children，不以“#”打头

`l` 创建链接

`t` 翻译字符串

* `!variable` 原样输出，适用于url
* `@variable` 通过check_plain过滤html字符
* `%variable` 过滤并使用theme_placeholder强调

使用templates/node--teaser.tpl.php
`$vars['theme_hook_suggestions'][] = 'node__teaser';`

`page  -> region ->block`

template_preprocess 为template形式实现的theme提供变量

hook_form_alter中当$form_id为node_type_form时,
怀疑在#group为additional_settings中设置$form['rating']['nodeapi_example_node_type']后,
会自动在variable中保存nodeapi_example_node_type_plan

contextual_links 在block右上角添加编辑链接

私有文件路径配置
sites/default/files/private

编码规范
http://drupal.org/coding-standards

自定义模块一般放在/sites/default/modules.
如果想在一个drupal实例中配置多个站点,共有的自定义模块放在/sites/all/modules/custom中

确保服务器可以读 .info 和.module,但是不可写

.info中files[] = first.module ;引入php functions, classes, interfaces,静态文件(包括php templates)不需要在这里声明

```
theme('links__contextual__node', $vars)会先使用 theme_links__contextual__node(), 然后 theme_links__contextual(), 最后 theme_links(),
```

`'#type' => 'value'`类似hidden field,但是可以存储各种类型数据,而且不会被显示到页面上

system_settings_form($form)会自动添加submit按钮,并存储variables

confirm_form确认信息

token_replace将token解析为相应内容

* Entity types 基类,包括Nodes(content), Comments, Taxonomy terms, User profile
* Bundles 子类,例如article, blog posts, products, taxonomy
* Fields 属性, primitive data type with validators, widgets, formatter
* Entities 实例

注意使用filter_xss($text)

db_query 中使用%s, %d, %d, %b

执行顺序request -> index.php(bootstrap) -> menu system -> node system -> theme system

`hook_init ... hook_exit`

When creating a link to an entity, always use entity_uri($type, $entity)

$types = &drupal_static(__FUNCTION__); 页面缓存,将函数名作为key.
drupal_static() 可以集中控制php静态变量,也就是需要在function的多次调用中保存但是不属于全局变量的变量,常作为同一页面请求的缓存

## drush

下载模块 `drush dl projectname`

升级 `drush up`

清缓存 `drush cc all`

备份数据库 `drush sql-dump > /path/to/filename.sql`

## modules

eck

代码风格检查 coder, grammar_parser

调试email开发 reroute_e-mail

## php

debugger: `Xdebug` or `the Zend Debugger`

文档生成工具 `Doxygen`

`func_get_args` 得到函数的传入参数

5.3新语法 `$value ?: "default"`

`define` 定义常量

`global` function中无法调用外面的变量，除非使用global关键字

`include_once` 仅仅加载并执行脚本一次

`var_dump` 打印结构

`pathinfo` 解析file path

`usort` 根据自定义函数进行数组排序

`mt_rand` 随机整数

`htmlentities` 将特殊字符转化为html字符

* `explode` 分割字符串
* `implode` 连接字符串

`is_object()`
`is_bool()`
`is_int()`
`is_float()`
`is_string()`
`is_array()`
`is_numeric()`

* `array_merge` 后面的数组会覆盖前面重复的内容，如果不想覆盖，直接使用“+”
* `array_shift` 从数组头部去除数据
* `array_reverse` 反转数组
* `array_diff` 返回a中有而b中没有的

### 发邮件

```
sudo apt-get install php-pear
sudo pear install mail
sudo pear install Net_SMTP
sudo pear install Auth_SASL
sudo pear install mail_mime
sudo apt-get install postfix
```
