
//List of cities where private storage boxes are available (empty or unset means all cities)
ps_cities_whitelist = [];

//List of models to use for private storage boxes (must have at least one)
ps_box_models = ["Land_PaperBox_open_full_F", "Land_Pallet_MilBoxes_F", "Land_PaperBox_open_empty_F", "Land_PaperBox_closed_F"];

//whether or not to show map markers for private storage boxes
ps_markers_enabled = true; 

//shape, type, color, size, text (for map markers, if enabled)
ps_markers_properties = ["ICON", "mil_dot", "ColorUNKNOWN", [1,1], "Storage"];


//Arma 3 Storage container class (see list below)
/*
	"Supply1000" (maximumLoad = 1000)
	"Supply2000"
	"Supply3000"
	"Supply4000"
	"Supply5000"
	"ReammoBox_F" (maximumLoad = 20000)
	"ContainerSupply" (maximumLoad = 99999)
 */
ps_container_class = "ReammoBox_F";
