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

调试信息`debug($user, 'User object')`

从modules文件夹的module文件中递归寻找特定内容，并显示行号:
`grep -nHR --include=*.module 'admin/appearance' modules`

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

