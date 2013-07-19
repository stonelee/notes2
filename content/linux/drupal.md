# drupal

----------

## 安装

语言文件放在 `profiles/standard/translations/`

建立文件并配置属性

```
cd ./sites/default
sudo cp default.settings.php settings.php
sudo chmod 777 settings.php

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

## drush

下载模块 `drush dl projectname`

升级 `drush up`

清缓存 `drush cc all`

备份数据库 `drush sql-dump > /path/to/filename.sql`

## modules

eck

代码风格检查 coder, grammar_parser

## php

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

