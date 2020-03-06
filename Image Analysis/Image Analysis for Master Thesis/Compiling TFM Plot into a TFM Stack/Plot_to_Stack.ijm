// Iterate through the whole folder of traction data plot and compile as a stack//
  dir = getDirectory("Choose a Directory ");
  list=getFileList(dir);
  
  for (i=0; i<list.length; i++) {
	j=indexOf(list[i],"Traction");
	k=indexOf(list[i],"_");
	l=indexOf(list[i],"-");
	m=lastIndexOf(list[i], "-");
	if(j>=0 && k>0 && l>0 ) {
	break;	
	}

  }
	print(j);
	print(k);
	print(l);
	print(m);
	print(list[i]);
lengthOf(list[i]);
//Iterate through 1 to 50 frames
for (x=1;x<51;x++){
filename_template=list[i];
filename="Traction"+"_"+substring(filename_template,k+1,l)+"-"+d2s(x,0)+substring(filename_template,m,lengthOf(filename_template));
path=dir+File.separator+filename;
print(path);
run("plot FTTC", "select=[&path] vector_scale=1 max=10 plot_width=0 plot_height=0 lut=S_Pet");
print(filename);

}
run("Images to Stack", "name=TFM-Stack title=[] use");
saveAs(".tif",dir+File.separator+"TFM_Compilation.tif");
close("*");
