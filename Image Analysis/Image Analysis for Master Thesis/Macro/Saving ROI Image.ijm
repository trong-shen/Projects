list = getList("image.titles");
dir= getDirectory("Choose A Directory");
for (i=0;i<list.length; i++){
selectWindow(list[i]);
run("Clear Outside","stack");
j=indexOf(list[i],".");
figurename_1=substring(list[i],0,j);
path=dir+figurename_1+"-ROI.tif";
saveAs("Tiff",path);
close(figurename_1+"-ROI.tif");
}