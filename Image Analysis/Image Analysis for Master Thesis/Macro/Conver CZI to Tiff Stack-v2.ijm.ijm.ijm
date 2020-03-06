  dir = getDirectory("Choose a Directory ");
  list=getFileList(dir);
  for (i=0; i<list.length; i++) {
dir_2=dir+list[i];
list_2=getFileList(dir_2);
print(dir_2+"Tiff Stack");
File.makeDirectory(dir_2+"Tiff Stack");
	for (j=0; j<list_2.length; j++) {
		print(list_2[j]);
	if (startsWith(list_2[j],"Tiff")==1) {
	continue;
	}
	print(dir_2+list_2[j]);
	open(dir_2+list_2[j]);
	k=indexOf(list_2[j],".");
	print(k);
	figurename_1=substring(list_2[j],0,k);
	print(figurename_1);
	path=dir_2+"Tiff Stack/"+figurename_1+".tif";
	print(path);
	saveAs("tiff",path);
  	close("*");
	}
}