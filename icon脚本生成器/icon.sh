# prepare
ROOT_DIR=$(pwd)

#check file exist
#设置1024尺寸的原图片路径
SOURCE_FILE="${ROOT_DIR}/Desktop/icon_1024x1024.png"
echo $SOURCE_FILE
if [[ ! -e ${SOURCE_FILE} ]];then
echo"文件不存在"
exit1
fi
#设置自动切割生成制定尺寸图片的位置
DEST_DIR="${ROOT_DIR}/Desktop/AppIcon"
# #如果目录有图片先清空
# if[[ -d ${DEST_DIR} ]];then
# rm -rf dir ${DEST_DIR}
# fi
mkdir -p "${DEST_DIR}"
#图片自定义的名称
Image_NAME=("icon_20x20.png" "icon_29x29.png" "icon_40x40-1.png" "icon_40x40-2.png" "icon_40x40.png" "icon_58x58-1.png" "icon_58x58.png" "icon_60x60.png" "icon_76x76.png" "icon_80x80-1.png" "icon_80x80.png" "icon_87x87.png" "icon_120x120-1.png" "icon_120x120.png" "icon_152x152.png" "icon_167x167.png" "icon_180x180.png" "icon_1024x1024.png")
#图片对应的尺寸
Image_SIZE=("20" "29" "40" "40" "40" "58" "58" "60" "76" "80" "80" "87" "120" "120" "152" "167" "180" "1024")


#sips starting
cp "${SOURCE_FILE}" "${DEST_DIR}"
for((i=0; i<${#Image_SIZE[@]} ;i++)); do
size=${Image_SIZE[i]}
sips -Z ${size} "${SOURCE_FILE}" --out "${DEST_DIR}/${Image_NAME[i]}"
done