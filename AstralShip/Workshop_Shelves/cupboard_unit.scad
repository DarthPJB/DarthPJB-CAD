// Shelf door wheel mount
// John Bargman - 2021
// Astral Ship Engineering

//Import shelf door mounting
use<shelf_door_wheel_mount.scad>

/* [Material Parameters] */
// Width of sheet board material
Sheet_Material_Width = 9;
//maximum length of a single board
Sheet_Material_Max_Width = 1220;
//maximum width of a single board
Sheet_Material_Max_Length = 2440;

/* [Cupboard Settings] */
//length of entire cupbard unit
Cupboard_Total_Length = 5500;
//height of the top surface of the unit
Cupboard_Total_Height = 1100;
//width of the entire unit (at most distant point)
Cupboard_Total_Width = 330;


/* [Core Parameters] */
//Width of bearings in wheel housing
Bearing_Width          = 14;


module Workshop_Cabinate()
{
  //Draw Frame

  //Draw Sheets
  for(i=[0;Sheet_Material_Max_Length;Cupboard_Total_Length])
  {
    
  }

  //Draw Doors
  door_wheel_assembly();
}

Workshop_Cabinate();
