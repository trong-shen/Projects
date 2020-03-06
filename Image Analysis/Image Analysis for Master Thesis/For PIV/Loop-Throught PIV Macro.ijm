  // Input directory Make sure you select the folder with Tiff Couple
  dir = getDirectory("Choose a Directory ");
  list=getFileList(dir);
  print(list.length);

  for (i=0; i<list.length; i++) {
	dir_2=dir+'/'+list[i];
	print(dir_2);
	list_2=getFileList(dir_2);
   
	//Iterate through each image file to open it, turn to 8-bit, and run PIV on it
		for (j=0; j<list_2.length; j++) {
		k=indexOf(list_2[j],".");
		if (k<0){
			continue;
			print("skip");
		}
		figurename_1=substring(list_2[j],0,k);
			//The file name must contain -F or else skip to next image		
			if (endsWith(figurename_1,"-F")==1) {
			print(dir_2+list_2[j]);
			open(dir_2+list_2[j]);
			rename("Original");
				if (File.exists(dir_2+"Tiff Couple"+figurename_1)!=1) {
				File.makeDirectory(dir_2+"Tiff Couple/"+figurename_1);
				}
				waitForUser;
				slice_n=1;
				slice_n=getNumber("Slice Number for Relaxed State", 1);
			// For iterating through all the stacks to create a paired image stack
				for (k=0; k<nSlices; k++){
				selectWindow("Original");
				// WTF you need to turn to the right slice to duplicate it. WTF does the range mean anyways in the option LOLL
				setSlice(slice_n);
				run("Duplicate...","range=1 use");
				rename("1");
				active_slice=k+1;
				selectWindow("Original");
				setSlice(active_slice);
				run("Duplicate...","range=1 use");
				rename("2");
				title=d2s(slice_n,0)+'-'+d2s((k+1),0);
				run("Concatenate...", "  title=&title keep open image1=[1] image2=[2] image3=[-- None --]");
				rename("1-2");
				path=dir_2+"Tiff Couple/"+figurename_1+"/"+title;
				saveAs('tiff', path);
				selectWindow("Original");
				close("\\Others");
				}
			
			close("Original");
			}

print("j is"+d2s(j,0));
	}
print("i is"+d2s(i,0));
}