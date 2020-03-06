				rename("Original")
				figurename_1="3-F";
				dir_2=getDirectory("Choose a Directory");
				slice_n=getNumber("Slice Number for Relaxed State", 1);
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