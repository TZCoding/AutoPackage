# 创建IPADir文件夹
if [ ! -d ./IPADir ];
then
mkdir -p IPADir;
fi

# 工程绝对路径
project_path=$(cd `dirname $0`; pwd)

# 工程名
project_name=Jenkins

# target名称
target_name=Jenkins

# 打包模式 Debug/Release
development_mode=Debug

# build文件夹路径
build_path=${project_path}/build

# plist文件所在路径
exportOptionsPlistPath=${project_path}/ExportOptions.plist

# 导出.ipa文件所在路径
exportIpaPath=${project_path}/IPADir/${development_mode}

# 更新pod
# /usr/local/bin/pod update --verbose --no-repo-update

# 清理工程
echo "=================clean================="
xcodebuild clean  -project  ${project_name}.xcodeproj \
-configuration ${development_mode} \
-target ${target_name} \

# 编译工程
echo "=================archive================="
xcodebuild archive  -project ${project_name}.xcodeproj \
-scheme ${target_name} \
-configuration ${development_mode} \
-archivePath build/${project_name}.xcarchive \

# ipa打包
echo "=================ipa================="
xcodebuild -exportArchive -archivePath build/${project_name}.xcarchive \
-configuration ${development_mode} \
-exportPath ${exportIpaPath} \
-exportOptionsPlist ${exportOptionsPlistPath} \
-allowProvisioningUpdates

if [ -e $exportIpaPath/$target_name.ipa ]; then
echo 'ipa包导出成功！'
open $exportIpaPath
else
echo 'ipa包导出失败！'
fi

# 将ipa包上传蒲公英
echo "=================upload================="
uKey=""
apiKey=""
ipa_path=${exportIpaPath}/${target_name}.ipa

curl -F "file=@${ipa_path}" -F "uKey=${uKey}" -F "_api_key=${apiKey}" https://qiniu-storage.pgyer.com/apiv1/app/upload
echo ' '

