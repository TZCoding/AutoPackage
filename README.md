## 配合Jenkins实现自动打包上传蒲公英平台。

1. 配置工程证书文件；
2. 更改ExportOptions.plist里的provisioningProfiles，teamID;
```
  <key>provisioningProfiles</key>
	<dict>
		<key>obj.Jenkins.tz</key>  // bundle id
		<string>Jenkins</string>   // 描述文件名称
	</dict>
  ```
3. 配置蒲公英uKey和apiKey
4. 如果是工作空间，把脚本里的 -project  ${project_name}.xcodeproj 换成 -workspace  ${project_name}.xcworkspace。
