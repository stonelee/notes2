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

## drush

下载模块 `drush dl projectname`

升级 `drush up`

清缓存 `drush cc all`

备份数据库 `drush sql-dump > /path/to/filename.sql`
