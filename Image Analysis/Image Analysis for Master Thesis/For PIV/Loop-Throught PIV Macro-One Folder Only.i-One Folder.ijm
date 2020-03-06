	dir=getDirectory("Choose a Directory");
	list=getFileList(dir);
	print(dir);
  for (i=0; i<list.length; i++) {
	  
	//Iterate through each image file to open it, turn to 8-bit, and run PIV on it
		k=indexOf(list[i],".tif");
		if (k<0){
			continue;
			print("skip");
		}
		print(dir+File.separator+list[i]);
		open(dir+File.separator+list[i]);
		figurename_1=substring(list[i],0,k);
		run("8-bit");
		run("Invert","stack");
		run("Linear Stack Alignment with SIFT", "initial_gaussian_blur=1.60 steps_per_scale_octave=3 minimum_image_size=64 maximum_image_size=1024 feature_descriptor_size=4 feature_descriptor_orientation_bins=8 closest/next_closest_ratio=0.92 maximal_alignment_error=25 inlier_ratio=0.05 expected_transformation=Translation");
		path=dir+"PIV"+File.separator+figurename_1+"-PIV"+".txt";
		print("path");
		run("iterative PIV(Advanced)...", "  piv1=128 sw1=256 vs1=64 piv2=64 sw2=128 vs2=32 piv3=48 sw3=128 vs3=16 correlation=0.50 use debug_x=-1 debug_y=-1 batch path=&path");
		close("*");
}

