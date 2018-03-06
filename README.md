## 配合Jenkins实现自动打包上传蒲公英平台。

#### Xcode 9 默认不允许访问钥匙串的内容，必须要设置 allowProvisioningUpdates 才会允许，但是由于 Xcode integration 插件封闭，不能对其进行修改加上这个属性，使用 Shell 脚本代替插件。
1. 配置证书及描述文件；
1. 更改ExportOptions.plist里的provisioningProfiles，teamID。手动打包，导出的文件夹里包含ExportOptions.plist，直接拷贝可用。
1. 配置蒲公英uKey和apiKey
1. 如果是工作空间，把脚本里的 -project  ${project_name}.xcodeproj 换成 -workspace  ${project_name}.xcworkspace。
