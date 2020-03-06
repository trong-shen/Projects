  // Input directory Make sure you select the folder with Tiff Couple
  dir3= getDirectory("Choose a Directory ");
  list3=getFileList(dir2);
  print(list.length);
for (k=0;k<list3.length;k++){
	if (list3[k]=="For Analyzing" ) {
	continue;
	}
	dir2_5=dir3+File.separator+list3[k];
	list2_5=getFileList(dir2_5);
for (l=0:l<list2_5.length;l++) {
	dir1_5=dir2_5+File.separator+list2_5[l];
	dir=dir1_5+File.separator+"Tiff Couple";
	if (!File.exists(dir)) {
		continue;
	}
	list=getFileList(dir);
	if (list.length==0) {
	continue;
	}
for (j=0;j<list2.length;j++){
	dir=dir2+File.separator+list2[j];
	list=getFileList(dir);
	print(dir):
  for (i=0; i<list.length; i++) {
	  
	//Iterate through each image file to open it, turn to 8-bit, and run PIV on it
		k=indexOf(list[i],".tif");
		if (k<0){
			continue;
			print("skip");
		}
		open(list[i]);
		figurename_1=substring(list[i],0,k);
		run("8-bit");
		run("Invert","stack");
		run("Linear Stack Alignment with SIFT", "initial_gaussian_blur=1.60 steps_per_scale_octave=3 minimum_image_size=64 maximum_image_size=1024 feature_descriptor_size=4 feature_descriptor_orientation_bins=8 closest/next_closest_ratio=0.92 maximal_alignment_error=25 inlier_ratio=0.05 expected_transformation=Translation");
		if (File.exists(dir+"PIV")!=1) {
		File.makeDirectory(dir+"PIV");
		}
		path=dir+"PIV"+File.separator+figurename_1+"-PIV"+".txt";
		run("iterative PIV(Advanced)...", "  piv1=128 sw1=256 vs1=64 piv2=64 sw2=128 vs2=32 piv3=48 sw3=128 vs3=16 correlation=0.50 use debug_x=-1 debug_y=-1 batch path=&path");
		close("*");
}
}
}
}