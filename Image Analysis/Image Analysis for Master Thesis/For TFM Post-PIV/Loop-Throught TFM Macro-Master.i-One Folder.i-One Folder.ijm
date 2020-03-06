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
	list=getFileList(dir);
 for (i=0; i<list.length; i++) {
	  
	//Iterate through each image file to open it, turn to 8-bit, and run PIV on it
		k=indexOf(list[i],".txt");
		x=indexOf(list[i],"FTTC");
		y=indexOf(list[i],"Traction");
		if (k<0 || x>=0|| y>=0 ){
			continue;
			print("skip");
		}
		folder_name=list[i];
		print(folder_name);
		path=dir+File.separator+folder_name;
		print(path);
	run("FTTC ", "pixel=0.16 poisson=0.5 young's=2000 regularization=0.00000001 plot_0=1400 plot_1=1048 select=[&path]");
}
}
}
}