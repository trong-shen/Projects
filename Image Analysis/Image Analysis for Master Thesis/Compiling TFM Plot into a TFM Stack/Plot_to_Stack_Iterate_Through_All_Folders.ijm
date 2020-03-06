  // Input directory Make sure you select the folder with Tiff Couple
  dir3= getDirectory("Choose a Directory ");
  list3=getFileList(dir3);
for (z=0;z<list3.length;z++){
	if (list3[z]=="For Analyzing" ) {
	continue;
	}
	folder_name_3=list3[z];
	slash_1=indexOf(list3[z],"/");
	folder_name_3=substring(folder_name_3,0,slash_1);
	dir2_5=dir3+folder_name_3+File.separator;
	list2_5=getFileList(dir2_5);
for (l=0;l<list2_5.length;l++) {
	folder_name_2=list2_5[l];
	slash_2=indexOf(list2_5[l],"/");
	if (slash_2<0) {
		continue;
	}
	
	folder_name_2=substring(folder_name_2,0,slash_2);
	dir1_5=dir2_5+folder_name_2+File.separator;
	dir2=dir1_5+"Tiff Couple";
	print(dir2);
	if (!File.exists(dir2)) {
		continue;
	}
	list2=getFileList(dir2);
	if (list2.length==0) {
	continue;
	}
	
for (j=0;j<list2.length;j++){
	folder_name_1=list2[j];
	slash_3=indexOf(list2[j],"/");
	folder_name_1=substring(folder_name_1,0,slash_3);
	dir=dir2+File.separator+folder_name_1+File.separator+"PIV"+File.separator+"PIV-Post_Analysis";
	print(dir);
	TFM_to_Stack(dir);
}
}
}



//Function for Writing the Files
function TFM_to_Stack(dir) {
// Iterate through the whole folder of traction data plot and compile as a stack//
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
}
